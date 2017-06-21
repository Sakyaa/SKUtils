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
@property (nullable, nonatomic, readonly) UIViewController *topViewController;


/**
 清除所有子视图
 */
- (void)sk_clearAllSubviews;



@end
