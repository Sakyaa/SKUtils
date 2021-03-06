//
//  PYFHUDManager.m
//  UnionProgarm
//
//  Created by Sakya on 17/2/23.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "SKHUDManager.h"
#import <MBProgressHUD.h>

#define kScreen_height  [[UIScreen mainScreen] bounds].size.height
#define kScreen_width   [[UIScreen mainScreen] bounds].size.width
#define kDefaultRect     CGRectMake(0, 0, kScreen_width, kScreen_height)

#define kDefaultView [[UIApplication sharedApplication] keyWindow]

#define kGloomyBlackColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]
#define kGloomyClearCloler  [UIColor colorWithRed:1 green:1 blue:1 alpha:0]

/* 默认网络提示，可在这统一修改 */
static NSString *const SKLoadingMessage = @"加载中";

/* 默认简短提示语显示的时间，在这统一修改 */
static CGFloat const   SKShowTime  = 2.0f;

/* 默认超时时间，30s后自动去除提示框 */
static NSTimeInterval const interval = 30.0f;

/* 手势是否可用，默认yes，轻触屏幕提示框隐藏 */
static BOOL isAvalibleTouch = YES;

@implementation SKHUDManager

UIView *gloomyView;//深色背景
UIView *prestrainView;//预加载view
BOOL isShowGloomy;//是否显示深色背景
#pragma mark -   类初始化
+ (void)initialize {
    if (self == [SKHUDManager self]) {
        //该方法只会走一次
        [self customView];
    }
}
#pragma mark - 初始化gloomyView
+(void)customView {
    gloomyView = [[GloomyView alloc] initWithFrame:kDefaultRect];
    gloomyView.backgroundColor = kGloomyBlackColor;
    gloomyView.hidden = YES;
    isShowGloomy = YES;
}
+ (void)showGloomy:(BOOL)isShow {
    isShowGloomy = isShow;
}
#pragma mark - 简短提示语
+ (void) showBriefAlert:(NSString *) message inView:(UIView *) view{
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?:kDefaultView animated:YES];
        hud.labelText = message;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.mode = MBProgressHUDModeText;
        hud.margin = 10.f;
        //HUD.yOffset = 200;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:SKShowTime];
    });
}
#pragma mark - 长时间的提示语
+ (void) showPermanentMessage:(NSString *)message inView:(UIView *) view{
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:gloomyView animated:YES];
        hud.labelText = message;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.mode = MBProgressHUDModeCustomView;
        hud.removeFromSuperViewOnHide = YES;
        hud.mode = MBProgressHUDModeText;
        [gloomyView addSubview:hud];
        [self showClearGloomyView];
        [hud show:YES];
    });
}
#pragma mark - 网络加载提示用
+ (void) showLoadingInView:(UIView *) view{
    
    [SKHUDManager hideAlert];
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:gloomyView];
        hud.labelText = SKLoadingMessage;
        hud.removeFromSuperViewOnHide = YES;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        if (isShowGloomy) {
            [self showBlackGloomyView];
        }else {
            [self showClearGloomyView];
        }
        [gloomyView addSubview:hud];
        [hud show:YES];
        [self hideAlertDelay];
    });
}
+ (void)showLoadingWithTitle:(NSString *)title inView:(UIView *)view {
    
    [SKHUDManager hideAlert];

    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:gloomyView];
        hud.labelText = title;
        hud.removeFromSuperViewOnHide = YES;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        if (isShowGloomy) {
            [self showBlackGloomyView];
        }else {
            [self showClearGloomyView];
        }
        [gloomyView addSubview:hud];
        [hud show:YES];
        [self hideAlertDelay];
    });
}

+(void)showAlertWithCustomImage:(NSString *)imageName title:(NSString *)title inView:(UIView *)view{
    
    [SKHUDManager hideAlert];

    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?:kDefaultView animated:YES];
        UIImageView *littleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
        littleView.image = [UIImage imageNamed:imageName];
        hud.customView = littleView;
        hud.removeFromSuperViewOnHide = YES;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.labelText = title;
        hud.mode = MBProgressHUDModeCustomView;
        [hud show:YES];
        [hud hide:YES afterDelay:SKShowTime];
    });
}
#pragma mark - 加载在window上的提示框

#pragma mark - public  show methods
+ (void)show {
    
    [self showLoadingWithTitle:nil inView:nil];
}
+ (void)showAddedTo:(UIView *)view {

    [self showLoadingWithTitle:nil inView:view];
}

/**
 *  显示“加载中”，待圈圈，若要修改直接修改kLoadingMessage的值即可
 */
+ (void)showLoading {
    
    [self showLoadingWithTitle:SKLoadingMessage inView:nil];

}
+ (void)showLoadingAddedTo:(UIView *)view {
   
    [self showLoadingWithTitle:SKLoadingMessage inView:nil];
}

/**
 自定义加载中的提示语
 
 @param prompt 提示语
 */
+ (void)showLoadingPrompt:(NSString *)prompt {
    
    [self showLoadingWithTitle:prompt inView:nil];

}
+ (void)showLoadingPrompt:(NSString *)prompt addedTo:(UIView *) view {
    [self showLoadingWithTitle:prompt inView:view];

}

/**
 *  一直显示自定义提示语，不带圈圈
 *
 *  @param prompt 提示信息
 */
+ (void)showPermanentPrompt:(NSString *)prompt {
    [self showPermanentMessage:prompt inView:nil];
}
+ (void)showPermanentPrompt:(NSString *)prompt addedTo:(UIView *) view {
    
    [self showPermanentMessage:prompt inView:view];
}

+ (void)showBriefPrompt:(NSString *) prompt {
    [self showBriefAlert:prompt inView:nil];

}
+ (void)showBriefPrompt:(NSString *) prompt addedTo:(UIView *) view {
    [self showBriefAlert:prompt inView:view];
}
+(void)showAlertWithCustomImage:(NSString *)imageName title:(NSString *)title {
    [self showAlertWithCustomImage:imageName title:title inView:nil];

}
+(void)showAlertWithCustomImage:(NSString *)imageName title:(NSString *)title addedTo:(UIView *)view {
    
    [self showAlertWithCustomImage:imageName title:title inView:view];

}
/**
 显示成功的提示
 @param prompt 成功描述  有图片的
 */
+ (void)showSuccessWithPrompt:(NSString *)prompt {
    
    [self showAlertWithCustomImage:@"" title:prompt inView:nil];

}
+ (void)showSuccessWithPrompt:(NSString *)prompt addedTo:(UIView *)view {
    
    [self showAlertWithCustomImage:@"" title:prompt inView:view];

}

/**
 显示失败描述
 
 @param prompt 描述 有图片的
 */
+ (void)showErrorWithPrompt:(NSString *)prompt {
    
    [self showAlertWithCustomImage:@"" title:prompt inView:nil];

}
+ (void)showErrorWithPrompt:(NSString *)prompt addedTo:(UIView *)view {
    
    [self showAlertWithCustomImage:@"" title:prompt inView:view];

}

#pragma mark -   GloomyView背景色
+ (void)showBlackGloomyView {
    
    gloomyView.backgroundColor = kGloomyBlackColor;
    [self gloomyConfig];
}
+ (void)showClearGloomyView {
    gloomyView.backgroundColor = kGloomyClearCloler;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self gloomyConfig];
    });
}
#pragma mark -   决定GloomyView add到已给view或者window上
+ (void)gloomyConfig {
    gloomyView.hidden = NO;
    gloomyView.alpha = 1;
    if (prestrainView) {
        [prestrainView addSubview:gloomyView];
    }else {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (![window.subviews containsObject:gloomyView]) {
            [window addSubview:gloomyView];
        }
    }
}
#pragma mark - public隐藏提示框  hide methods

+(void)hideAlert{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [SKHUDManager HUDForView:gloomyView];
        [UIView animateWithDuration:0.5 animations:^{
            gloomyView.center = prestrainView ? prestrainView.center: [UIApplication sharedApplication].keyWindow.center;
            gloomyView.alpha = 0;
            hud.alpha = 0;
        } completion:^(BOOL finished) {
            [hud removeFromSuperview];
        }];
    });
    
}
#pragma mark -   超时后（默认30s）自动隐藏加载提示
+ (void)hideAlertDelay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideAlert];
    });
}
#pragma mark -   获取view上的hud
+ (MBProgressHUD *)HUDForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            return (MBProgressHUD *)subview;
        }
    }
    return nil;
}
@end


@implementation GloomyView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (isAvalibleTouch) {
        [SKHUDManager hideAlert];
    }
}
@end
