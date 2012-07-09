//
//  OLCompiler.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/7/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLParser.h"

@class OLCompiler, OLEntity;

@protocol OLCompilerDelegate <NSObject>

- (void)compiler:(OLCompiler *)compiler compiledEntity:(OLEntity *)entity;

@end

@interface OLCompiler : NSObject <OLParserDelegate>

@property (nonatomic, retain) id<OLCompilerDelegate> delegate;

- (void)compileText:(NSString *)text;

@end
