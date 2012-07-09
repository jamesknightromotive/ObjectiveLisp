//
//  OLSymbol.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLEntity.h"

@interface OLSymbol : OLEntity

@property (nonatomic, retain, readonly) NSString *name;

+ (OLSymbol *)symbolWithName:(NSString *)name;

- (id)initWithName:(NSString *)name;

@end
