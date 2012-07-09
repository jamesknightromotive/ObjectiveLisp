//
//  OLForm.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLForm.h"

@implementation OLForm

@synthesize name=_name, invocation=_invocation;

+ (OLForm *)formWithName:(NSString *)name invocation:(OLFormInvocation)invocation
{
    return [[[OLForm alloc] initWithName:name invocation:invocation] autorelease];
}

- (id)initWithName:(NSString *)name invocation:(OLFormInvocation)invocation
{
    if (self = [super init])
    {
        _name = [name retain];
        _invocation = [invocation copy];
    }
    
    return self;
}

- (id)value
{
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<OLForm: %@>", _name];
}

@end
