//
//  OLBool.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLBool.h"

@implementation OLBool

- (id)initWithBool:(BOOL)boolVal
{
    if (self = [super init])
    {
        _number = [[NSNumber alloc] initWithBool:boolVal];
    }
    
    return self;
}

- (NSString *)description
{
    return [_number boolValue] ? @":True" : @":False";
}

@end
