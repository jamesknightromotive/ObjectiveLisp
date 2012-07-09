//
//  OLSymbol.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLSymbol.h"

@implementation OLSymbol

@synthesize name=_name;

+ (OLSymbol *)symbolWithName:(NSString *)name
{
    return [[[OLSymbol alloc] initWithName:name] autorelease];
}

- (id)initWithName:(NSString *)name
{
    if (self = [super init])
    {
        _name = [name retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_name release];
    [super dealloc];
}

- (NSString *)description
{
    return _name;
}

@end
