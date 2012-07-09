//
//  OLSource.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/6/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLSource.h"

@implementation OLSource

@synthesize text=_text, index=_index;

+ (OLSource *)sourceWithText:(NSString *)text
{
    return [[[OLSource alloc] initWithText:text] autorelease];
}

- (id)init
{
    if (self = [super init])
    {
        [self setText:nil];
        _index = -1;
    }
    
    return self;
}

- (id)initWithText:(NSString *)text
{
    if (self = [super init])
    {
        [self setText:text];
        _index = -1;
    }
    
    return self;
}

- (void)dealloc
{
    [_text release];
    [super dealloc];
}

- (unichar)currentCharacter
{
    if (_index < [_text length])
        return [_text characterAtIndex:_index];
    else
        return END_OF_STRING;
}

- (unichar)nextCharacter
{
    if (++_index < [_text length])
        return [_text characterAtIndex:_index];
    else
        return END_OF_STRING;
}

- (unichar)peekCharacter
{
    NSInteger index = _index + 1;
    if (index < [_text length])
        return [_text characterAtIndex:index];
    else
        return END_OF_STRING;
}

@end
