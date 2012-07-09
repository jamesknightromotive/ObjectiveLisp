//
//  OLScanner.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/6/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

@class OLSource;

@interface OLScanner : NSObject

- (NSArray *)tokenizeSource:(OLSource *)source;

@end
