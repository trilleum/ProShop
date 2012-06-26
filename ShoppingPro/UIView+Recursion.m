//
//  UIView+Recursion.m
//  Flash2Pay
//
//  Created by Tao Xie on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIView+Recursion.h"

@implementation UIView (Recursion)
- (void)enableInteraction {
    NSLog(@"view %@ interaction enabled", self);
    self.userInteractionEnabled = YES;
    for (UIView *subview in self.subviews) {
        [subview enableInteraction];
    }
}
@end
