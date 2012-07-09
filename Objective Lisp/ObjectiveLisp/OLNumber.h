//
//  OLNumber.h
//  ObjectiveLisp
//
//  Created by James Knauer on 7/8/12.
//  Copyright (c) 2012 Romotive. All rights reserved.
//

#import "OLValue.h"
#import "OLObject.h"

@interface OLNumber : OLValue <OLObject>
{
    NSNumber *_number;
}

+ (OLNumber *)numberWithInt:(int)intValue;
+ (OLNumber *)numberWithDouble:(double)doubleValue;
+ (OLNumber *)numberWithBool:(BOOL)boolValue;

@end
