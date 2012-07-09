//
//  OLEnvironment.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/7/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OLList, OLValue, OLRuntime, OLSymbol, OLNamespace;

@interface OLEnvironment : NSObject

+ (OLEnvironment *)environment;
+ (OLEnvironment *)environmentWithValues:(OLList *)values forSymbols:(OLList *)symbols parent:(OLEnvironment *)parent;

- (id)initWithValues:(OLList *)values forSymbols:(OLList *)symbols parent:(OLEnvironment *)parent;

- (void)addValue:(OLValue *)value forSymbol:(OLSymbol *)symbol;
- (void)addValues:(OLList *)values forSymbols:(OLList *)symbols;

- (void)addNamespace:(OLNamespace *)ns;
 
- (OLValue *)lookupSymbol:(OLSymbol *)symbol;

@end
