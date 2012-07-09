//
//  OLValue.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLValue.h"

@implementation OLValue

- (id)value
{
    NSLog(@"Error: OLValue is an abstract class.");
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self value]];
}

@end
