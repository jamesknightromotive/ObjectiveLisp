//
//  OLString.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLValue.h"
#import "OLObject.h"

@interface OLString : OLValue <OLObject>

+ (OLString *)stringWithString:(NSString *)string;
- (id)initWithString:(NSString *)string;

@end
