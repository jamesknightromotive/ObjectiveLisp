//
//  OLCore.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLCore.h"

#define FN_OP_ADD @"+"
#define FN_OP_SUB @"-"
#define FN_OP_MUL @"*"
#define FN_OP_DIV @"/"

@interface OLCore ()

- (void)addCoreFns;

@end

@implementation OLCore

- (id)init
{
    if (self = [super init])
    {
        [self addCoreFns];
    }
    
    return self;
}

- (void)addCoreFns
{
    OLLambda fnOpAdd = ^OLValue *(OLList *args) 
    {
        OLEntity *entity = nil;
        
        BOOL isDouble = NO;
        double doubleSum = 0.0;
        
        while (args) 
        {
            entity = [args first];
            
            if ([entity isKindOfClass:[OLNumber class]])
            {
                NSNumber *number = [(OLNumber *)entity value];
                
                if ([entity isKindOfClass:[OLDouble class]])
                {
                    doubleSum += [number doubleValue];
                    isDouble = YES;
                }
                else 
                {
                    doubleSum += [number intValue];
                }
            }
            else
            {
                NSLog(@"Error: operator+ passed non-number argument: %@", [entity description]);
                return nil;
            }
            
            args = [args next];
        }
    
        if (isDouble)
            return [OLNumber numberWithDouble:doubleSum];
        
        return [OLNumber numberWithInt:(int)doubleSum];
    };

    OLLambda fnOpSub = ^OLValue *(OLList *args) 
    {
        OLEntity *entity = nil;
        
        BOOL isDouble = NO;
        double doubleSum = 0.0;
        
        while (args) 
        {
            entity = [args first];
            
            if ([entity isKindOfClass:[OLNumber class]])
            {
                NSNumber *number = [(OLNumber *)entity value];
                
                if ([entity isKindOfClass:[OLDouble class]])
                {
                    doubleSum -= [number doubleValue];
                    isDouble = YES;
                }
                else 
                {
                    doubleSum -= [number intValue];
                }
            }
            else
            {
                NSLog(@"Error: operator- passed non-number argument.");
                return nil;
            }
            
            args = [args next];
        }
        
        if (isDouble)
            return [OLNumber numberWithDouble:doubleSum];
        
        return [OLNumber numberWithInt:(int)doubleSum];
    };

    OLLambda fnOpMul = ^OLValue *(OLList *args) 
    {
        OLEntity *entity = nil;
        
        BOOL isDouble = NO;
        double doubleSum = 1.0;
        
        while (args) 
        {
            entity = [args first];
            
            if ([entity isKindOfClass:[OLNumber class]])
            {
                NSNumber *number = [(OLNumber *)entity value];
                
                if ([entity isKindOfClass:[OLDouble class]])
                {
                    doubleSum *= [number doubleValue];
                    isDouble = YES;
                }
                else 
                {
                    doubleSum *= [number intValue];
                }
            }
            else
            {
                NSLog(@"Error: operator* passed non-number argument.");
                return nil;
            }
            
            args = [args next];
        }
        
        if (isDouble)
            return [OLNumber numberWithDouble:doubleSum];
        
        return [OLNumber numberWithInt:(int)doubleSum];
    };

    OLLambda fnOpDiv = ^OLValue *(OLList *args) 
    {
        OLEntity *entity = nil;
        
        BOOL isDouble = NO;
        double doubleSum = 0.0;
        
        entity = [args first];
        
        if ([entity isKindOfClass:[OLNumber class]])
        {
            NSNumber *number = [(OLNumber *)entity value];
            
            if ([entity isKindOfClass:[OLDouble class]])
            {
                doubleSum = [number doubleValue];
                isDouble = YES;
            }
            else 
            {
                doubleSum = [number intValue];
            }
        }
        else
        {
            NSLog(@"Error: operator/ passed non-number argument.");
            return nil;
        }
        
        args = [args next];
        
        while (args) 
        {
            entity = [args first];
            
            if ([entity isKindOfClass:[OLNumber class]])
            {
                NSNumber *number = [(OLNumber *)entity value];
                
                if ([entity isKindOfClass:[OLDouble class]])
                {
                    doubleSum /= [number doubleValue];
                    isDouble = YES;
                }
                else 
                {
                    doubleSum /= [number intValue];
                }
            }
            else
            {
                NSLog(@"Error: operator/ passed non-number argument.");
                return nil;
            }
            
            args = [args next];
        }
        
        if (isDouble)
            return [OLNumber numberWithDouble:doubleSum];
        
        return [OLNumber numberWithInt:(int)doubleSum];
    };

    [self addValue:[OLFn fnWithLambda:fnOpAdd] forSymbol:[OLSymbol symbolWithName:FN_OP_ADD]];
    [self addValue:[OLFn fnWithLambda:fnOpSub] forSymbol:[OLSymbol symbolWithName:FN_OP_SUB]];
    [self addValue:[OLFn fnWithLambda:fnOpMul] forSymbol:[OLSymbol symbolWithName:FN_OP_MUL]];
    [self addValue:[OLFn fnWithLambda:fnOpDiv] forSymbol:[OLSymbol symbolWithName:FN_OP_DIV]];
}

@end
