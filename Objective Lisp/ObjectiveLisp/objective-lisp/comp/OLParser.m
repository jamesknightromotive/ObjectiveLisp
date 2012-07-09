//
//  OLParser.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/6/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLParser.h"
#import "OLToken.h"
#import "OLLang.h"

@interface OLParser ()

- (OLList *)parseListAtEnumerator:(NSEnumerator *)enumerator;
- (OLEntity *)parseToken:(OLToken *)token;

@end


@implementation OLParser

@synthesize delegate=_delegate;

- (void)dealloc
{
    [_delegate release];
    [super dealloc];
}

- (void)parseTokens:(NSArray *)tokens
{
    NSMutableArray *array = [NSMutableArray array];
    NSEnumerator *enumerator = [tokens reverseObjectEnumerator];
    
    OLToken *token = nil; 
    while (token = [enumerator nextObject])
    {
        OLTokenType type = [token type];
        
        switch (type)
        {
            case TOKEN_LIST_CLOSE:
                // Start parsing a new list:
                [array addObject:[self parseListAtEnumerator:enumerator]];
                break;
                
            case TOKEN_LIST_OPEN:
                [_delegate parser:self encounteredError:@"Error: Mismatched parentheses."];                
                break;
                
            case TOKEN_WORD:
                [array addObject:[self parseToken:token]];
                break;
                
            case TOKEN_STRING:
                [array addObject:[OLString stringWithString:[token text]]];
                break;
                
            case TOKEN_ERROR:
                NSLog(@"Error: Error parsing token at: %lu", [token index]);
                break;
        }
    }
    
    NSEnumerator *entityEnumerator = [array reverseObjectEnumerator];
    OLEntity *parsedEntity = nil;
    while ((parsedEntity = [entityEnumerator nextObject]))
    {
        [_delegate parser:self parsedEntity:parsedEntity];
    }
}

- (OLList *)parseListAtEnumerator:(NSEnumerator *)enumerator
{
    OLList *list = [OLList list];
    
    OLToken *token = nil;
    
    while (token = [enumerator nextObject])
    {
        switch ([token type]) 
        {
            case TOKEN_LIST_CLOSE:
                // Start parsing a new list:
                list = [list conj:[self parseListAtEnumerator:enumerator]];
                break;
                
            case TOKEN_LIST_OPEN:
                // List over, close the list as is:
                return list;
                
            case TOKEN_WORD:
                // Identify symbol and add to list:
                list = [list conj:[self parseToken:token]];
                break;
                
            case TOKEN_STRING:
                // Add string to list:
                list = [list conj:[OLString stringWithString:[token text]]];
                break;
                
            case TOKEN_ERROR:
                NSLog(@"Error: Error parsing token at: %lu", [token index]);
                return nil;
        }
    }
    
    return nil;
}

- (OLEntity *)parseToken:(OLToken *)token
{
    NSString *tokenText = [token text];
    NSScanner *scanner = [NSScanner scannerWithString:tokenText];
    
    BOOL containsDecimal = NO;
    
    for (int i = 0; i < [tokenText length]; ++i)
    {
        if ([tokenText characterAtIndex:i] == '.')
        {
            containsDecimal = YES;
            break;
        }
    }
    
    
    if (containsDecimal)
    {
        double doubleValue;
        if ([scanner scanDouble:&doubleValue])
        {
            return [OLNumber numberWithDouble:doubleValue];
        }
    }
    else 
    {
        int integerValue;
        if ([scanner scanInt:&integerValue])
        {
            return [OLNumber numberWithInt:integerValue];
        }
    }
    
    return [OLSymbol symbolWithName:[token text]];
}

@end
