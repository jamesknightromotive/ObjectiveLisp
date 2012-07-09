//
//  NSString+CharacterUtility.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/7/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CharacterUtility)

+ (NSString *)stringWithCharacter:(unichar)character;
- (id)initWithCharacter:(unichar)character;

@end

@interface NSMutableString (CharacterUtility)

- (void)appendCharacter:(unichar)character;

@end