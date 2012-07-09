//
//  OLEnvironment.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/7/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLEnvironment.h"
#import "OLRuntime.h"
#import "OLList.h"
#import "OLNamespace.h"

@interface OLEnvironment ()
{
    NSMutableDictionary *_symbolTable;
    OLEnvironment *_parentEnvironment;
}

@end

@implementation OLEnvironment

+ (OLEnvironment *)environment
{
    return [[[OLEnvironment alloc] init] autorelease];
}

+ (OLEnvironment *)environmentWithValues:(OLList *)values forSymbols:(OLList *)symbols parent:(OLEnvironment *)parent
{
    return [[[OLEnvironment alloc] initWithValues:values forSymbols:symbols parent:parent] autorelease];    
}

- (id)init
{
    if (self = [super init])
    {
        _symbolTable = [[NSMutableDictionary alloc] init];
        _parentEnvironment = nil;
    }
    
    return self;
}

- (id)initWithValues:(OLList *)values forSymbols:(OLList *)symbols parent:(OLEnvironment *)parent
{
    if (self = [super init])
    {
        _symbolTable = [[NSMutableDictionary alloc] init];
        _parentEnvironment = parent;
        
        [self addValues:values forSymbols:symbols];
    }
    
    return self;
}

- (void)dealloc
{
    [_symbolTable release];
    [_parentEnvironment release];
    [super dealloc];
}

- (void)addValue:(OLValue *)value forSymbol:(OLSymbol *)symbol
{
    [_symbolTable setObject:value forKey:[symbol name]];
}

- (void)addValues:(OLList *)values forSymbols:(OLList *)symbols
{
    while (values)
    {
        [self addValue:(OLValue *)[values first] forSymbol:(OLSymbol *)[symbols first]];
        values = [values next];
        symbols = [symbols next];
    }
}

- (void)addNamespace:(OLNamespace *)ns
{
    [_symbolTable addEntriesFromDictionary:[ns symbolTable]];
}

- (OLValue *)lookupSymbol:(OLSymbol *)symbol
{
    OLValue *value = (OLValue *) [_symbolTable valueForKey:[symbol name]];
    
    if (value)
        return value;
    
    if (_parentEnvironment)
        return [_parentEnvironment lookupSymbol:symbol];
    
    return nil;
}

- (NSString *)description
{
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"{"];
    
    BOOL appendSpace = NO;
    
    for (NSString *key in [_symbolTable allKeys])
    {
        if (appendSpace)
            [string appendString:@" "];
        [string appendFormat:@"%@ : %@,", key, [[_symbolTable valueForKey:key] description]];
        appendSpace = YES;
    }
    
    [string appendString:@"}"];
    return [NSString stringWithString:string];
}

@end
