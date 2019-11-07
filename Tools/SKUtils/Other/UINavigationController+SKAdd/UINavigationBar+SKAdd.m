//
//  UINavigationBar+SKAdd.m
//  SKToolsDemo
//
//  Created by Sakya on 2019/11/7.
//  Copyright © 2019 Sakya. All rights reserved.
//

#import "UINavigationBar+SKAdd.h"
#import <objc/runtime.h>
#import "UINavigationController+SKAdd.h"

@implementation SKNavigationBarManager

+ (SKNavigationBarManager *)sharedManager {
    static SKNavigationBarManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SKNavigationBarManager alloc] init];
    });
    return manager;
}

@end

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@implementation UINavigationBar (SKAdd)
static char overlayKey;
- (UIView *)overlay {
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay {
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sk_setBackgroundColor:(UIColor *)backgroundColor {
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight`
        [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)sk_setTranslationY:(CGFloat)translationY {
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)sk_setElementsAlpha:(CGFloat)alpha {
    //在iOS 11 之下才有用
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
        }
        if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]) {
            obj.alpha = alpha;
        }
    }];
}

- (void)sk_reset {
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //   设置导航条黑线出现
    //    self.sk_viewController.navigationController.hidesNavigationBarHairline = NO;
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

#pragma mark -- sk
//additional
- (void)sk_setNeedsNavigationBarGroundColorAlpha:(CGFloat)alpha {
    [self sk_setBackgroundColor:[[SKNavigationBarManager sharedManager].barColor colorWithAlphaComponent:alpha]];
}

- (void)sk_setNeedsNavigationBarGroundColor:(UIColor *)backgroundColor
                                      alpha:(CGFloat)alpha {
    [self sk_setBackgroundColor:[backgroundColor colorWithAlphaComponent:alpha]];
}

@end
