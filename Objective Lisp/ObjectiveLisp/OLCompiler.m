//
//  OLCompiler.m
//  ObjectiveLisp
//
//  Created by James Knauer on 7/7/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLCompiler.h"
#import "OLSource.h"
#import "OLScanner.h"
#import "OLParser.h"
#import "OLToken.h"

@interface OLCompiler ()
{
    OLParser *_parser;
    OLScanner *_scanner;
}

@end

@implementation OLCompiler

@synthesize delegate=_delegate;

- (id)init
{
    if (self = [super init])
    {
        _parser = [[OLParser alloc] init];
        _scanner = [[OLScanner alloc] init];
        
        [_parser setDelegate:self];
    }
    
    return self;
}

- (void)dealloc
{
    [_parser release];
    [_scanner release];
    [super dealloc];
}

- (void)compileText:(NSString *)text
{
    [_parser parseTokens:[_scanner tokenizeSource:[OLSource sourceWithText:text]]];
}

- (void)parser:(OLParser *)parser parsedEntity:(OLEntity *)entity
{
    [_delegate compiler:self compiledEntity:entity];
}

- (void)parser:(OLParser *)parser encounteredError:(NSString *)error
{
    NSLog(@"%@", error);
}

@end
