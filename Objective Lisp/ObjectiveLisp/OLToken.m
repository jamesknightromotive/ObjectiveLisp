//
//  OLToken.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/6/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLToken.h"

@implementation OLToken

@synthesize type=_type, text=_text, index=_index;

+ (OLToken *)tokenWithText:(NSString *)text index:(NSUInteger)index type:(OLTokenType)type
{
    return [[[OLToken alloc] initWithText:text index:index type:type] autorelease];
}

- (id)initWithText:(NSString *)text index:(NSUInteger)index type:(OLTokenType)type
{
    if (self = [super init])
    {
        [self setText:text];
        [self setIndex:index];
        [self setType:type];
    }
    
    return self;    
}

- (void)dealloc
{
    [_text release];
    [super dealloc];
}

@end
