//
//  OLRuntime.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/7/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OLRuntime, OLEntity, OLEnvironment, OLList, OLValue;

@protocol OLRuntimeDelegate <NSObject>

- (void)runtime:(OLRuntime *)runtime returnedValue:(OLValue *)value;

@end

@interface OLRuntime : NSObject

@property (nonatomic, retain) id<OLRuntimeDelegate> delegate;

- (void)evaluateEntity:(OLEntity *)entity;

@end
