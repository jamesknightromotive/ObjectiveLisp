//
//  OLREPL.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLREPL.h"
#import "OLCompiler.h"
#import "OLRuntime.h"

@interface OLREPL ()
{
    OLCompiler *_compiler;
    OLRuntime *_runtime;
}

@end

@implementation OLREPL 

- (id)init
{
    if (self = [super init])
    {
        _compiler = [[OLCompiler alloc] init];
        _runtime = [[OLRuntime alloc] init];
        
        [_compiler setDelegate:self];
        [_runtime setDelegate:self];
    }
    
    return self;
}

- (void)enterReadEvalPrintLoop
{
    NSLog(@"Welcome!");
    char input[4096];
    while (true)
    {
        @autoreleasepool 
        {
            scanf("%s", input);
            
            //NSString *string = [NSString stringWithCString:input encoding:NSASCIIStringEncoding];
            //NSString *string = @"(+ 2 2) (- 2 3) (/ 4 2) (/ 30.0f 45) (* 6 6 6)";
            
            NSString *string = @"(def sumOfSquares (fn (x y) (+ (* x x) (* y y)))) (sumOfSquares 3 4)";
            
            [_compiler compileText:string];
        }
    }
}

- (void)compiler:(OLCompiler *)compiler compiledEntity:(OLEntity *)entity
{
    NSLog(@"-> %@", [entity description]);
    [_runtime evaluateEntity:entity];
}

- (void)runtime:(OLRuntime *)runtime returnedValue:(OLValue *)value
{
    NSLog(@"<- %@", [value description]);
}

@end
