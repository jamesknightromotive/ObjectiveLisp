//
//  OLREPL.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OLCompiler.h"
#import "OLRuntime.h"

@interface OLREPL : NSObject <OLCompilerDelegate, OLRuntimeDelegate>

- (void)enterReadEvalPrintLoop;

@end
