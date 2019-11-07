//
//  UIViewController+SKAdd.h
//  SKToolsDemo
//
//  Created by Sakya on 2019/11/7.
//  Copyright © 2019 Sakya. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (SKAdd)
//additional
- (void)sk_setNeedsNavigationGroundColorAlpha:(CGFloat)alpha;
- (void)sk_setNeedsNavigationGroundColor:(UIColor *)backgroundColor
                                   alpha:(CGFloat)alpha;

- (void)sk_setNeedsNavigationReset;
@end

NS_ASSUME_NONNULL_END
