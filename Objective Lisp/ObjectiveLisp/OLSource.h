//
//  OLSource.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/6/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#define END_OF_STRING 0

@interface OLSource : NSObject

@property (nonatomic, retain) NSString *text;
@property (nonatomic, readonly) NSInteger index;

+ (OLSource *)sourceWithText:(NSString *)text;

- (id)initWithText:(NSString *)text;

- (unichar)currentCharacter;
- (unichar)nextCharacter;
- (unichar)peekCharacter;

@end
