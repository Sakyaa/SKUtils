//
//  UIView+SKAdd.h
//  SKToolsDemo
//
//  Created by Sakya on 2017/6/13.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SKAdd)



/**
 获取当前的控制器
 */
@property (nullable, nonatomic, readonly) UIViewController *sk_viewController;
/**
 清除所有子视图
 */
- (void)sk_clearAllSubviews;


@property (nonatomic) CGFloat sk_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat sk_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat sk_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat sk_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat sk_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat sk_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat sk_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat sk_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint sk_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  sk_size;        ///< Shortcut for frame.size.
@end
