//
//  UINavigationController+SKAdd.h
//  SKToolsDemo
//
//  Created by Sakya on 2019/11/7.
//  Copyright © 2019 Sakya. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (SKAdd)
- (void)sk_setStatusBarStyle:(UIStatusBarStyle)statusBarStyle;
/**
 *  Hides the hairline view at the bottom of a navigation bar. The default value is @c NO.
 */
@property (nonatomic, assign) BOOL hidesHairline;
@end

NS_ASSUME_NONNULL_END
