//
//  UIViewController+SKNavAdd.m
//  LTNavigationBar
//
//  Created by Sakya on 2017/10/11.
//  Copyright © 2017年 ltebean. All rights reserved.
//

#import "UIViewController+SKNavAdd.h"
#import "UINavigationBar+Awesome.h"
#import "UINavigationController+SKAdd.h"


@implementation UIViewController (SKNavAdd)
//additional
- (void)sk_setNeedsNavigationGroundColorAlpha:(CGFloat)alpha {

//    navigationBarAppearance.translucent = YES;
    self.navigationController.hidesHairline = YES;
    /**
    //    navigationBarAppearance.translucent = NO;
    if (alpha < 1) {
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.hidesHairline = YES;
    } else {
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.hidesHairline = NO;
    }
     */
    
    [self.navigationController.navigationBar sk_setNeedsNavigationBarGroundColorAlpha:alpha];
}
- (void)sk_setNeedsNavigationGroundColor:(UIColor *)backgroundColor
                                   alpha:(CGFloat)alpha {
 /** navigationBarAppearance.translucent = NO;
    if (alpha < 1) {
        self.navigationController.navigationBar.translucent = YES;
    } else {
        self.navigationController.navigationBar.translucent = NO;
    }
  */
    
    self.navigationController.hidesHairline = YES;
    [self.navigationController.navigationBar sk_setNeedsNavigationBarGroundColor:backgroundColor alpha:alpha];
}
- (void)sk_setNeedsNavigationReset {
//    self.navigationController.navigationBar.translucent = NO;

    [self.navigationController.navigationBar lt_reset];
}
/**
 //设置自定义的分割线
 UIImageView *barImageView = [self findHairlineImageViewUnder:self.navigationBar];
 UIImageView *barFootView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
 //添加自定义分割线
 barFootView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
 [barImageView addSubview:barFootView];
 [barImageView bringSubviewToFront:barFootView];
 */
@end
