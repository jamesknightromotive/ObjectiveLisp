//
//  main.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/6/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OLREPL.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool 
    {
        OLREPL *repl = [[OLREPL alloc] init];
        
        [repl enterReadEvalPrintLoop];
        [repl release];
    }
    return 0;
}

