//
//  OLRuntime.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/7/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLRuntime.h"
#import "OLEnvironment.h"
#import "OLForm.h"
#import "OLLang.h"
#import "OLSpecialForms.h"
#import "OLCore.h"

@interface OLRuntime ()
{
    OLEnvironment *_globalEnvironment;
}

- (void)defineSpecialForms;
- (void)loadCore;

- (OLValue *)evaluateEntity:(OLEntity *)entity inEnvironment:(OLEnvironment *)environment;
- (OLValue *)evaluateList:(OLList *)list inEnvironment:(OLEnvironment *)environment;
- (OLList *)evaluateMembers:(OLList *)list inEnvironment:(OLEnvironment *)environment;

- (OLValue *)invokeForm:(OLForm *)form withArgs:(OLList *)args inEnvironment:(OLEnvironment *)environment;
- (OLValue *)invokeFn:(OLFn *)fn withArgs:(OLList *)args;

@end

@implementation OLRuntime

@synthesize delegate=_delegate;

- (id)init
{
    if (self = [super init])
    {
        _globalEnvironment = [[OLEnvironment alloc] init];
        [self defineSpecialForms];
        [self loadCore];
    }
    
    return self;
}

- (void)dealloc
{
    [_globalEnvironment release];
    [super dealloc];
}

- (void)evaluateEntity:(OLEntity *)entity
{
    [_delegate runtime:self returnedValue:[self evaluateEntity:entity inEnvironment:_globalEnvironment]];
}

- (OLValue *)evaluateList:(OLList *)list inEnvironment:(OLEnvironment *)environment
{
    OLValue *value = [self evaluateEntity:[list first] inEnvironment:environment];
    
    list = [list next];
    
    if ([value isKindOfClass:[OLForm class]])
    {
        return [self invokeForm:(OLForm *)value withArgs:list inEnvironment:environment];
    }
    
    if ([value isKindOfClass:[OLFn class]])
    {
        list = [self evaluateMembers:list inEnvironment:environment];
        return [self invokeFn:(OLFn *)value withArgs:list];
    }
    
    NSLog(@"Error: [list first] was neither an Fn nor a Form: %@", [value description]);
    return nil;
}

- (OLValue *)evaluateEntity:(OLEntity *)entity inEnvironment:(OLEnvironment *)environment
{    
    if ([entity isKindOfClass:[OLList class]])
        return [self evaluateList:(OLList *)entity inEnvironment:environment];
    
    if ([entity isKindOfClass:[OLSymbol class]])
        return [environment lookupSymbol:(OLSymbol *)entity];
    
    if ([entity isKindOfClass:[OLValue class]])
        return (OLValue *) entity;
    
    return nil;
}

- (OLList *)evaluateMembers:(OLList *)list inEnvironment:(OLEnvironment *)environment;
{
    if (list)
    {
        return [[self evaluateMembers:[list next] inEnvironment:environment] conj:[self evaluateEntity:[list first] inEnvironment:environment]];
    }
    return [OLList list];
}

- (OLValue *)invokeFn:(OLFn *)fn withArgs:(OLList *)args
{    
    return [fn lambda](args);
}

- (OLValue *)invokeForm:(OLForm *)form withArgs:(OLList *)args inEnvironment:(OLEnvironment *)environment
{
    OLFormInvocation invocation = [form invocation];
    
    return invocation(args, environment);
}

- (void)defineSpecialForms
{
    @autoreleasepool 
    {
        OLFormInvocation defInvocation = ^OLValue *(OLList *args, OLEnvironment *environment) {
            OLSymbol *symbol = (OLSymbol *) [args first];
            args = [args next];
            
            OLValue *value = [self evaluateEntity:[args first] inEnvironment:environment];
            
            [environment addValue:value forSymbol:symbol];
            return nil;
        };
        
        OLFormInvocation fnInvocation = ^OLValue *(OLList *args, OLEnvironment *environment) {
            OLList *vars = (OLList *) [args first];
            args = [args rest];
            OLList *exprs = (OLList *) [args first];
            
            OLLambda lambda = ^OLValue *(OLList *lambdaArgs) { 
                return [self evaluateList:exprs 
                            inEnvironment:[OLEnvironment environmentWithValues:lambdaArgs forSymbols:vars parent:environment]];
            };
            
            return [OLFn fnWithLambda:lambda];
        };
        
        OLFormInvocation ifInvocation = ^OLValue *(OLList *args, OLEnvironment *environment) {
            OLEntity *condition = [args first];
            args = [args rest];
            
            OLEntity *thenVal = [args first];
            args = [args rest];
            
            OLEntity *elseVal = [args first];
            
            OLValue *entity = [self evaluateEntity:condition inEnvironment:environment];
            
            BOOL result = NO;
            
            if (entity)
            {
                if ([entity isKindOfClass:[OLNumber class]])
                    result = [[(OLNumber *)entity value] boolValue];
                else
                    result = YES;
            }
            
            if (result)
                return [self evaluateEntity:thenVal inEnvironment:environment];
            
            return [self evaluateEntity:elseVal inEnvironment:environment];
        };
        
        OLFormInvocation doInvocation = ^OLValue *(OLList *args, OLEnvironment *environment) {
            OLValue *result = nil;
            
            while (args)
            {
                result = [self evaluateEntity:[args first] inEnvironment:environment];
                args = [args next];
            }
            
            return result;
        };
        
        OLFormInvocation quoteInvocation = ^OLValue *(OLList *args, OLEnvironment *environment) {
            NSMutableArray *array = [NSMutableArray array];
            
            OLList *list = (OLList *) [args first];
            
            while (list)
            {
                [array addObject:[list first]];
                 list = [list next];
            }
            
            return [OLArray arrayWithArray:array];
        };
        
        [_globalEnvironment addValue:[OLForm formWithName:SF_DEF invocation:defInvocation] 
                           forSymbol:[OLSymbol symbolWithName:SF_DEF]];
        
        [_globalEnvironment addValue:[OLForm formWithName:SF_FN invocation:fnInvocation] 
                           forSymbol:[OLSymbol symbolWithName:SF_FN]];
        
        [_globalEnvironment addValue:[OLForm formWithName:SF_IF invocation:ifInvocation] 
                           forSymbol:[OLSymbol symbolWithName:SF_IF]];
        
        [_globalEnvironment addValue:[OLForm formWithName:SF_DO invocation:doInvocation] 
                           forSymbol:[OLSymbol symbolWithName:SF_DO]];
        
        [_globalEnvironment addValue:[OLForm formWithName:SF_QUOTE invocation:quoteInvocation] 
                           forSymbol:[OLSymbol symbolWithName:SF_QUOTE]];
    }
}

- (void)loadCore
{
    OLCore *core = [[OLCore alloc] init];
    [_globalEnvironment addNamespace:core];
    [core release];
}
             
@end
