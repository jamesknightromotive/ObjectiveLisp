//
//  OLDictionary.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLDictionary.h"

@interface OLDictionary ()
{
    NSDictionary *_dictionary;
}

@end

@implementation OLDictionary

+ (OLDictionary *)dictionaryWithDictionary:(NSDictionary *)dictionary
{
    return [[[OLDictionary alloc] initWithDictionary:dictionary] autorelease];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _dictionary = [dictionary retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_dictionary release];
    [super dealloc];
}

- (NSUInteger)count
{
    return [_dictionary count];
}

- (id)value
{
    return self;
}

@end
