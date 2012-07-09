//
//  OLForm.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLValue.h"

@class OLList, OLEnvironment;

typedef OLValue *(^OLFormInvocation)(OLList *, OLEnvironment *);

@interface OLForm : OLValue

@property (nonatomic, retain, readonly) NSString *name;
@property (nonatomic, copy, readonly) OLFormInvocation invocation;

+ (OLForm *)formWithName:(NSString *)name invocation:(OLFormInvocation)invocation;

- (id)initWithName:(NSString *)name invocation:(OLFormInvocation)invocation;

@end
