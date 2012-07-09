//
//  OLList.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLEntity.h"

@interface OLList : OLEntity

@property (nonatomic, retain, readonly) OLEntity *first;
@property (nonatomic, retain, readonly) OLList *rest;

+ (OLList *)list;
+ (OLList *)listWithFirst:(OLEntity *)first;
+ (OLList *)listWithFirst:(OLEntity *)first rest:(OLList *)rest;

- (id)initWithFirst:(OLEntity *)first;
- (id)initWithFirst:(OLEntity *)first rest:(OLList *)rest;

- (OLList *)conj:(OLEntity *)first;
- (OLList *)next;

@end
