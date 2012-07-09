//
//  OLNamespace.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLLang.h"

@interface OLNamespace : NSObject

- (NSDictionary *)symbolTable;

- (void)addValue:(OLValue *)value forSymbol:(OLSymbol *)symbol;
- (void)addValues:(OLList *)values forSymbols:(OLList *)symbols;

@end
