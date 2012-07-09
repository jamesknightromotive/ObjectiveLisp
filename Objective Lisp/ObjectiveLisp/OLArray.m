//
//  OLArray.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLArray.h"

@interface OLArray ()
{
    NSArray *_array;
}

@end

@implementation OLArray

+ (OLArray *)arrayWithArray:(NSArray *)array
{
    return [[[OLArray alloc] initWithArray:array] autorelease];
}

- (id)initWithArray:(NSArray *)array
{
    if (self = [super init])
    {
        _array = [array retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_array release];
    [super dealloc];
}

- (NSUInteger)count
{
    return [_array count];
}

- (id)value
{
    return self;
}

- (NSString *)description
{
    NSMutableString *result = [NSMutableString string];
    
    BOOL appendSpace = NO;
    
    NSEnumerator *enumerator = [_array objectEnumerator];
    OLEntity *entity= nil;
    
    while ((entity = [enumerator nextObject]))
    {
        if (appendSpace)
            [result appendString:@" "];
        
        NSString *description = entity ? [entity description] : @"nil";
        [result appendString:description];
        
        appendSpace = YES;
    }
    
    return [NSString stringWithFormat:@"[%@]", result];
}

@end
