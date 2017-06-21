//
//  UIView+SKAdd.m
//  SKToolsDemo
//
//  Created by Sakya on 2017/6/13.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "UIView+SKAdd.h"

@implementation UIView (SKAdd)

- (UIViewController *)topViewController {
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
@end
