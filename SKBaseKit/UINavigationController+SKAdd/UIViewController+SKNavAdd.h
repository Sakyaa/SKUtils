//
//  UIViewController+SKNavAdd.h
//  LTNavigationBar
//
//  Created by Sakya on 2017/10/11.
//  Copyright © 2017年 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SKNavAdd)
//additional
- (void)sk_setNeedsNavigationGroundColorAlpha:(CGFloat)alpha;
- (void)sk_setNeedsNavigationGroundColor:(UIColor *)backgroundColor
                                   alpha:(CGFloat)alpha;

@end
