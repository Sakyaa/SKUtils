//
//  UINavigationController+SKAdd.h
//  SKToolsDemo
//
//  Created by Sakya on 2017/10/15.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKNavigationEnums.h"


@interface UINavigationController (SKAdd)

- (void)sk_setStatusBarStyle:(UIStatusBarStyle)statusBarStyle;
/**
 *  Hides the hairline view at the bottom of a navigation bar. The default value is @c NO.
 *
 *  @since 2.0.3
 */
@property (nonatomic, assign) BOOL hidesHairline;
@end
