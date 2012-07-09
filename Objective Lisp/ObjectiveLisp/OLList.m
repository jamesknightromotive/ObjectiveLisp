//
//  OLList.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLList.h"

@implementation OLList

@synthesize first=_first, rest=_rest;

+ (OLList *)list
{
    return [[[OLList alloc] init] autorelease];
}

+ (OLList *)listWithFirst:(OLEntity *)first
{
    return [[[OLList alloc] initWithFirst:first] autorelease];
}

+ (OLList *)listWithFirst:(OLEntity *)first rest:(OLList *)rest
{
    return [[[OLList alloc] initWithFirst:first rest:rest] autorelease];
}

- (id)init
{
    return [self initWithFirst:nil rest:nil];
}

- (id)initWithFirst:(OLEntity *)first
{
    return [self initWithFirst:first rest:[OLList list]];
}

- (id)initWithFirst:(OLEntity *)first rest:(OLList *)rest
{
    if (self = [super init])
    {
        _first = [first retain];
        _rest = [rest retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_first release];
    [_rest release];
    [super dealloc];
}

- (OLList *)conj:(OLEntity *)entity
{
    return [OLList listWithFirst:entity rest:self];
}

- (OLList *)next
{
    if ([_rest first] || [_rest rest])
        return _rest;
        
    return nil;
}

- (NSString *)description
{
    NSMutableString *result = [NSMutableString string];
    
    BOOL appendSpace = NO;
    
    OLList *list = self;
    
    while (list)
    {
        if (appendSpace)
            [result appendString:@" "];
        
        OLEntity *entity = [list first];
        
        NSString *description = entity ? [entity description] : @"nil";
        [result appendString:description];
        
        list = [list next];
        appendSpace = YES;
    }
    
    return [NSString stringWithFormat:@"(%@)", result];
}


@end
