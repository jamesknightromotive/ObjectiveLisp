//
//  OLBool.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLNumber.h"
#import "OLObject.h"

@interface OLBool : OLNumber <OLObject>

- (id)initWithBool:(BOOL)boolVal;

@end
