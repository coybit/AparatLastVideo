//
//  NeatTextField.m
//  aparat2
//
//  Created by coybit on 11/14/16.
//  Copyright © 2016 Marblzz. All rights reserved.
//

#import "NeatLabel.h"

@implementation NeatLabel
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {10, 5, 10, 5};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
