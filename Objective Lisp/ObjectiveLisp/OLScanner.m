//
//  OLScanner.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/6/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLScanner.h"
#import "OLSource.h"
#import "OLToken.h"
#import "NSString+CharacterUtility.h"

@interface OLScanner ()

- (BOOL)isAlphabeticCharacter:(unichar)character;
- (BOOL)isNumericCharacter:(unichar)character;
- (BOOL)isListOpenCharacter:(unichar)character;
- (BOOL)isListCloseCharacter:(unichar)character;
- (BOOL)isQuotationCharacter:(unichar)character;
- (BOOL)isSpecialCharacter:(unichar)character;
- (BOOL)isWhitespaceCharacter:(unichar)character;
- (BOOL)isEndOfStringCharacter:(unichar)character;

- (BOOL)isListCharacter:(unichar)character;
- (BOOL)isStringTerminatingCharacter:(unichar)character;
- (BOOL)isWordTerminatingCharacter:(unichar)character;

@end

@implementation OLScanner

- (NSArray *)tokenizeSource:(OLSource *)source
{
    NSMutableArray *tokens = [NSMutableArray array];
    
    while (![self isEndOfStringCharacter:[source peekCharacter]])
    {
        unichar character = [source nextCharacter];
        
        // Skip whitespace:
        while ([self isWhitespaceCharacter:character])
        {
            character = [source nextCharacter];
            
            if ([self isEndOfStringCharacter:character])
                goto EndParse;
        }
        
        NSInteger index = [source index];
        
        OLToken *token = nil;
        
        // Identify token type:
        if ([self isListOpenCharacter:character])
        {
            // List token:
            token = [OLToken tokenWithText:[NSString stringWithCharacter:character] index:index type:TOKEN_LIST_OPEN];
            [tokens addObject:token];
        }
        else if ([self isListCloseCharacter:character])
        {
            token = [OLToken tokenWithText:[NSString stringWithCharacter:character] index:index type:TOKEN_LIST_CLOSE];
            [tokens addObject:token];
        }
        else if ([self isQuotationCharacter:character])
        {
            // String literal token:
            NSMutableString *literalTokenText = [[NSMutableString alloc] init];
            [literalTokenText appendCharacter:character];
            
            while (![self isStringTerminatingCharacter:[source peekCharacter]])
            {
                [literalTokenText appendCharacter:[source nextCharacter]];
            }
            
            if ([self isEndOfStringCharacter:[source peekCharacter]])
            {
                token = [OLToken tokenWithText:[NSString stringWithString:literalTokenText] index:index type:TOKEN_ERROR];
                [literalTokenText release];
                
                [tokens addObject:token];
                goto EndParse;
            }
            else 
            {
                [literalTokenText appendCharacter:[source nextCharacter]];
                token = [OLToken tokenWithText:[NSString stringWithString:literalTokenText] index:index type:TOKEN_STRING];
                [literalTokenText release];
                
                [tokens addObject:token];                
            }
        }
        else 
        {
            NSMutableString *wordTokenText = [[NSMutableString alloc] init];
            [wordTokenText appendCharacter:character];
            
            while (![self isWordTerminatingCharacter:[source peekCharacter]])
            {
                [wordTokenText appendCharacter:[source nextCharacter]];
            }
            
            token = [OLToken tokenWithText:[NSString stringWithString:wordTokenText] index:index type:TOKEN_WORD];
            [wordTokenText release];
            
            [tokens addObject:token];            
        }
        
    }
    
EndParse:
    
    return [NSArray arrayWithArray:tokens];
}

- (BOOL)isAlphabeticCharacter:(unichar)character
{
    return ((character >= 'a' && character <= 'z') || (character >= 'A' && character <= 'Z'));
}

- (BOOL)isNumericCharacter:(unichar)character
{
    return (character >= '0' && character <= '9'); 
}

- (BOOL)isQuotationCharacter:(unichar)character
{
    return (character == '"');
}

- (BOOL)isListOpenCharacter:(unichar)character
{
    return character == '(';
}

- (BOOL)isListCloseCharacter:(unichar)character
{
    return character == ')';
}

- (BOOL)isSpecialCharacter:(unichar)character
{
    switch (character)
    {
        case '@':
        case ':':
        case '#':
        case '%':
            return YES;
            
        default:
            return NO;
    }
}

- (BOOL)isWhitespaceCharacter:(unichar)character
{
    switch (character)
    {
        case ' ':
        case ',':
        case '\n':
        case '\t':
            return YES;
            
        default:
            return NO;
    }
}

- (BOOL)isEndOfStringCharacter:(unichar)character
{
    return character == END_OF_STRING;
}

- (BOOL)isListCharacter:(unichar)character
{
    return [self isListOpenCharacter:character] || [self isListCloseCharacter:character];
}

- (BOOL)isStringTerminatingCharacter:(unichar)character
{
    return [self isQuotationCharacter:character] || [self isEndOfStringCharacter:character];
}

- (BOOL)isWordTerminatingCharacter:(unichar)character
{
    return [self isWhitespaceCharacter:character] || [self isListCharacter:character] || [self isEndOfStringCharacter:character];
}

@end
