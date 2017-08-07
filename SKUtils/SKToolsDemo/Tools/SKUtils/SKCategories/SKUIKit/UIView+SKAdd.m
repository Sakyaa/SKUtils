//
//  UIView+SKAdd.m
//  SKToolsDemo
//
//  Created by Sakya on 2017/6/13.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "UIView+SKAdd.h"

@implementation UIView (SKAdd)

- (UIViewController *)sk_viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
- (void)sk_clearAllSubviews {
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
}



- (CGFloat)sk_left {
    return self.frame.origin.x;
}

- (void)setSk_left:(CGFloat)sk_left {
    CGRect frame = self.frame;
    frame.origin.x = sk_left;
    self.frame = frame;
}

- (CGFloat)sk_top {
    return self.frame.origin.y;
}

- (void)setSk_top:(CGFloat)sk_top {
    CGRect frame = self.frame;
    frame.origin.y = sk_top;
    self.frame = frame;
}

- (CGFloat)sk_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setSk_right:(CGFloat)sk_right {
    CGRect frame = self.frame;
    frame.origin.x = sk_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)sk_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setSk_bottom:(CGFloat)sk_bottom {
    CGRect frame = self.frame;
    frame.origin.y = sk_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)sk_width {
    return self.frame.size.width;
}

- (void)setSk_width:(CGFloat)sk_width {
    CGRect frame = self.frame;
    frame.size.width = sk_width;
    self.frame = frame;
}

- (CGFloat)sk_height {
    return self.frame.size.height;
}

- (void)setSk_height:(CGFloat)sk_height {
    CGRect frame = self.frame;
    frame.size.height = sk_height;
    self.frame = frame;
}

- (CGFloat)sk_centerX {
    return self.center.x;
}

- (void)setSk_centerX:(CGFloat)sk_centerX {
    self.center = CGPointMake(sk_centerX, self.center.y);
}

- (CGFloat)sk_centerY {
    return self.center.y;
}

- (void)setSk_centerY:(CGFloat)sk_centerY {
    self.center = CGPointMake(self.center.x, sk_centerY);
}

- (CGPoint)sk_origin {
    return self.frame.origin;
}

- (void)setSk_origin:(CGPoint)sk_origin {
    CGRect frame = self.frame;
    frame.origin = sk_origin;
    self.frame = frame;
}

- (CGSize)sk_size {
    return self.frame.size;
}

- (void)setSk_size:(CGSize)sk_size {
    CGRect frame = self.frame;
    frame.size = sk_size;
    self.frame = frame;
}


@end
