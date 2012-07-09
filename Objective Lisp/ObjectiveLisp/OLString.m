//
//  OLString.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLString.h"

@interface OLString ()
{
    NSString *_string;
}

@end

@implementation OLString

+ (OLString *)stringWithString:(NSString *)string
{
    return [[[OLString alloc] initWithString:string] autorelease];
}

- (id)initWithString:(NSString *)string
{
    if (self = [super init])
    {
        _string = [string retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_string release];
    [super dealloc];
}

- (id)value
{
    return _string;
}

@end
