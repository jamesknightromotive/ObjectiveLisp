//
//  OLNumber.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLNumber.h"
#import "OLInteger.h"
#import "OLDouble.h"
#import "OLBool.h"

@implementation OLNumber

+ (OLNumber *)numberWithInt:(int)intValue
{
    return [[[OLInteger alloc] initWithInt:intValue] autorelease];
}

+ (OLNumber *)numberWithDouble:(double)doubleValue
{
    return [[[OLDouble alloc] initWithDouble:doubleValue] autorelease];
}

+ (OLNumber *)numberWithBool:(BOOL)boolValue
{
    return [[[OLBool alloc] initWithBool:boolValue] autorelease];
}

- (void)dealloc
{
    [_number release];
    [super dealloc];
}

- (id)value
{
    return _number;
}

@end
