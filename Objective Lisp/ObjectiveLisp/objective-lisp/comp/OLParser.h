//
//  OLParser.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/6/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OLEntity, OLParser, OLList;

@protocol OLParserDelegate <NSObject>

- (void)parser:(OLParser *)parser parsedEntity:(OLEntity *)entity;
- (void)parser:(OLParser *)parser encounteredError:(NSString *)error;

@end

@interface OLParser : NSObject

@property (nonatomic, retain) id<OLParserDelegate> delegate;

- (void)parseTokens:(NSArray *)tokens;

@end