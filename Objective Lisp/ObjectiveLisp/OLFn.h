//
//  OLFn.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLValue.h"
#import "OLList.h"

typedef OLValue *(^OLLambda)(OLList *);

@interface OLFn : OLValue

@property (nonatomic, retain, readonly) OLLambda lambda;
@property (nonatomic, retain, readonly) NSString *name;

+ (OLFn *)fnWithLambda:(OLLambda)lambda;
+ (OLFn *)fnWithLambda:(OLLambda)lambda name:(NSString *)name;

- (id)initWithLambda:(OLLambda)lambda;
- (id)initWithLambda:(OLLambda)lambda name:(NSString *)name;

- (OLValue *)invokeWithArgs:(OLList *)args;

@end
