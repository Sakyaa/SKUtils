//
//  UIViewController+SKNavAdd.m
//  LTNavigationBar
//
//  Created by Sakya on 2017/10/11.
//  Copyright © 2017年 ltebean. All rights reserved.
//

#import "UIViewController+SKNavAdd.h"
#import "UINavigationBar+Awesome.h"
#import "UINavigationController+Chameleon.h"


@implementation UIViewController (SKNavAdd)
//additional
- (void)sk_setNeedsNavigationGroundColorAlpha:(CGFloat)alpha {

    
    
    self.navigationController.hidesNavigationBarHairline = YES;
    [self.navigationController.navigationBar sk_setNeedsNavigationBarGroundColorAlpha:alpha];


}
- (void)sk_setNeedsNavigationGroundColor:(UIColor *)backgroundColor
                                   alpha:(CGFloat)alpha {

    self.navigationController.hidesNavigationBarHairline = NO;
    [self.navigationController.navigationBar sk_setNeedsNavigationBarGroundColor:backgroundColor alpha:alpha];
}
@end
