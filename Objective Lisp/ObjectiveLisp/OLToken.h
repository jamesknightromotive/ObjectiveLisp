//
//  OLToken.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/6/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

typedef enum
{
    // OLList:
    TOKEN_LIST_OPEN,
    TOKEN_LIST_CLOSE,
    
    // Full Tokens:
    TOKEN_WORD,
    TOKEN_STRING,
    
    // Error:
    TOKEN_ERROR
    
} OLTokenType;

@interface OLToken : NSObject

@property (nonatomic, assign) OLTokenType type;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, assign) NSUInteger index;

+ (OLToken *)tokenWithText:(NSString *)text index:(NSUInteger)index type:(OLTokenType)type;

- (id)initWithText:(NSString *)text index:(NSUInteger)index type:(OLTokenType)type;

@end
