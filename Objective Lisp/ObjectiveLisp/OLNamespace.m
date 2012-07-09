//
//  OLNamespace.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLNamespace.h"

@interface OLNamespace ()
{
    NSMutableDictionary *_symbolTable;
}

@end

@implementation OLNamespace

- (id)init
{
    if (self = [super init])
    {
        _symbolTable = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (NSDictionary *)symbolTable
{
    return [NSDictionary dictionaryWithDictionary:_symbolTable];
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

@end
