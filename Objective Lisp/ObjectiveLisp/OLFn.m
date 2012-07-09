//
//  OLFn.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLFn.h"

@implementation OLFn

@synthesize lambda=_lambda, name=_name;

+ (OLFn *)fnWithLambda:(OLLambda)lambda
{
    return [[[OLFn alloc] initWithLambda:lambda] autorelease];
}

+ (OLFn *)fnWithLambda:(OLLambda)lambda name:(NSString *)name
{
    return [[[OLFn alloc] initWithLambda:lambda name:name] autorelease];
}

- (id)initWithLambda:(OLLambda)lambda
{
    return [self initWithLambda:lambda name:@"$ANONYMOUS_FN"];
}

- (id)initWithLambda:(OLLambda)lambda name:(NSString *)name
{
    if (self = [super init])
    {
        _lambda = [lambda copy];
        _name = [name retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_lambda release];
    [_name release];
    [super dealloc];
}

- (id)invokeWithArgs:(OLList *)args
{
    return _lambda(args);
}

- (id)value
{
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<OLFn: %@>", _name];
}
            


@end
