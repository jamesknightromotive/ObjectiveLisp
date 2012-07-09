//
//  NSString+CharacterUtility.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/7/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "NSString+CharacterUtility.h"

@implementation NSString (CharacterUtility)

+ (NSString *)stringWithCharacter:(unichar)character
{
    return [[[NSString alloc] initWithCharacter:character] autorelease];
}

- (id)initWithCharacter:(unichar)character
{
    return [self initWithFormat:@"%C", character];
}

@end

@implementation NSMutableString (CharacterUtility)

- (void)appendCharacter:(unichar)character
{
    [self appendFormat:@"%C", character];
}

@end
