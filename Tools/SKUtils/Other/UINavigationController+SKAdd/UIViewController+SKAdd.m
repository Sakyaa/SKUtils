//
//  UIViewController+SKAdd.m
//  SKToolsDemo
//
//  Created by Sakya on 2019/11/7.
//  Copyright © 2019 Sakya. All rights reserved.
//

#import "UIViewController+SKAdd.h"
#import "UINavigationBar+SKAdd.h"
#import "UINavigationController+SKAdd.h"

@implementation UIViewController (SKAdd)
//additional
- (void)sk_setNeedsNavigationGroundColorAlpha:(CGFloat)alpha {
    self.navigationController.hidesHairline = YES;
    [self.navigationController.navigationBar sk_setNeedsNavigationBarGroundColorAlpha:alpha];
}
- (void)sk_setNeedsNavigationGroundColor:(UIColor *)backgroundColor
                                   alpha:(CGFloat)alpha {
    self.navigationController.hidesHairline = YES;
    [self.navigationController.navigationBar sk_setNeedsNavigationBarGroundColor:backgroundColor alpha:alpha];
}
- (void)sk_setNeedsNavigationReset {
    self.navigationController.hidesHairline = NO;
    [self.navigationController.navigationBar sk_reset];
}
@end
