//
//  OLFloat.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLDouble.h"

@implementation OLDouble

- (id)initWithDouble:(double)doubleVal
{
    if (self = [super init])
    {
        _number = [[NSNumber alloc] initWithDouble:doubleVal];
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%f", [_number doubleValue]];
}

@end
