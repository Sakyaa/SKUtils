//
//  BaseViewController.h
//  ThePartyBuild
//
//  Created by Sakya on 17/4/24.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BaseViewController : UIViewController
/*
 *创建导航条按钮
 */
//右侧文字按钮和点击事件
- (UIButton *)setNavigationRightBarTitle:(NSString *)title
                               textColor:(UIColor *)color;
//右导航按钮和点击事件
- (void)setNavigationRightBarButtonImageNamed:(NSString *)imageName;
#pragma mark - rightAction
- (void)rightButtonTouchUpInside:(UIButton *)sender;


//左侧系统返回按钮
- (void)setDefaultNavigationLeftBarButton;
//设置左导航栏按钮
- (void)setNavigationLeftBarButtonImageNamed:(NSString *)imageName;
- (void)setNavigationLeftBarButtonTitle:(NSString *)title
                              textColor:(UIColor *)color;
#pragma mark - leftAction
- (void)leftButtonCustomTouchUpInside:(UIButton *)sender;

/**
 设置导航条标题
 @param title 标题
 */
- (void)setUpNavItemTitle:(NSString *)title;
@end
