//
//  OLDictionary.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLValue.h"
#import "OLCollection.h"

@interface OLDictionary : OLValue <OLCollection>

+ (OLDictionary *)dictionaryWithDictionary:(NSDictionary *)dictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
