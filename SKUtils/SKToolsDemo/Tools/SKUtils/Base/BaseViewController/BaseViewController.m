//
//  BaseViewController.m
//  ThePartyBuild
//
//  Created by Sakya on 17/4/24.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    导航条颜色
    //    导航条红色
//    UIColor *barColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:CGRectMake(0, 0, kScreenWidth, 64) andColors:@[COLOR_BUTTON_BLUE_TOP,COLOR_BUTTON_BLUE_BOTTOM]];
//    self.navigationController.navigationBar.barTintColor = COLOR_BLUE_SYSTEM;
    //    是否根据按所在界面的navigationbar与tabbar的高度
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.extendedLayoutIncludesOpaqueBars = YES;
    

    
    //背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 状态栏是否透明
    //   self.navigationController.navigationBar.translucent = YES;
    // 视图延伸不考虑透明的Bars(这里包含导航栏和状态栏)
    //     意思就是延伸到边界 这个属性在状态栏不透明的状态下才生效 （从顶端开始布局)
    //    self.extendedLayoutIncludesOpaqueBars = YES;
    
    //导航条文字类型
    //    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:FONT_MID}];
    //退出键盘
    //    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

}
- (void)setUpNavItemTitle:(NSString *)title {
    
    self.navigationItem.title = title;
}

//设置右导航栏文字的按钮
- (UIButton *)setNavigationRightBarTitle:(NSString *)title
                               textColor:(UIColor *)color {
    
    UIButton *rightButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 50, 44)];
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, +5, 0, -5);
    
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [rightButton setTitleColor:color forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    return rightButton;
}

//设置右导航栏按钮
- (void)setNavigationRightBarButtonImageNamed:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    
    UIButton *rightButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 44, 44)];
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, +15, 0, -15);
    rightButton.imageView.contentMode = UIViewContentModeRight;
    
    [rightButton setImage:image forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setAdjustsImageWhenHighlighted:NO];
//    rightButton.custom_acceptEventInterval = 1;
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItems
    = @[rightBarButton];
}



//左侧系统返回按钮颜色返回按钮颜色
- (void)setDefaultNavigationLeftBarButton {
    
    UIImage *image = [UIImage imageNamed:@"navBar_whiteBack_icon"];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.bounds = CGRectMake(0, 0, 44, 44);
    [leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    leftButton.imageView.contentMode = UIViewContentModeLeft;
    [leftButton setImage:image forState:UIControlStateNormal];
    [leftButton setImage:image forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonTouchUpInsideBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem
    = leftBarButtonItem;
}


//设置左导航栏按钮
- (void)setNavigationLeftBarButtonImageNamed:(NSString *)imageName {
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *leftButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 44, 44)];
    [leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    leftButton.imageView.contentMode = UIViewContentModeLeft;
    [leftButton setImage:image forState:UIControlStateNormal];
    [leftButton setImage:image forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonCustomTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    //    修复iOS 7以下左侧返回按钮偏右
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItems = @[leftBarButtonItem];
}
- (void)setNavigationLeftBarButtonTitle:(NSString *)title
                              textColor:(UIColor *)color {
    UIButton *leftButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 50, 44)];
    leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    [leftButton setTitle:title forState:UIControlStateNormal];
    [leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [leftButton setTitleColor:color forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonCustomTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.tag = 0;
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:leftBarButton];
}
//左侧双按钮
- (void)setNavigationLeftBarButtonLeftImageName:(NSString *)leftImageName
                                secondImageName:(NSString *)secondImageName
{
    UIButton *leftButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 44, 44)];
    [leftButton setImage:[UIImage imageNamed:leftImageName] forState:UIControlStateNormal];
    leftButton.tag = 0;
    [leftButton addTarget:self action:@selector(leftButtonTouchUpInsideBack:) forControlEvents:UIControlEventTouchUpInside];
    //    UIButton *secondLeftButton = [UIButton buttonWithType: UIButtonTypeCustom];
    //    [secondLeftButton setFrame:CGRectMake(0, 0, 44, 44)];
    //    [secondLeftButton setImage:[UIImage imageNamed:secondImageName] forState:UIControlStateNormal];
    //    [secondLeftButton setImage:[UIImage imageNamed:secondImageName] forState:UIControlStateHighlighted];
    //    [secondLeftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    //    secondLeftButton.tag = 1;
    //    [secondLeftButton addTarget:self action:@selector(leftButtonTouchUpInsideBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil
                                       action:nil];
    negativeSpacer.width = - 20;
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    //    UIBarButtonItem *secondBarButton = [[UIBarButtonItem alloc] initWithCustomView:secondLeftButton];
    //    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,leftBarButton,secondBarButton,negativeSpacer]];
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,leftBarButton]];
    
}

#pragma mark - action
//左按钮点击事件
- (void)leftButtonCustomTouchUpInside:(UIButton *)sender {
    
    
}
- (void)leftButtonTouchUpInsideBack:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
//右按钮点击事件
- (void)rightButtonTouchUpInside:(UIButton *)sender {
    
    
    
}
//设置状态栏的白色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
