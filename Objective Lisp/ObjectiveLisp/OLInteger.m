//
//  OLInteger.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLInteger.h"

@implementation OLInteger

- (id)initWithInt:(int)intValue
{
    if (self = [super init])
    {
        _number = [[NSNumber alloc] initWithInt:intValue];
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%d", [_number intValue]];
}

@end
