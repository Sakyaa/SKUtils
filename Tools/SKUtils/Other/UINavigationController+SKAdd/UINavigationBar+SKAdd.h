//
//  UINavigationBar+SKAdd.h
//  SKToolsDemo
//
//  Created by Sakya on 2019/11/7.
//  Copyright © 2019 Sakya. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKNavigationBarManager : NSObject
+ (SKNavigationBarManager *)sharedManager;
@property (nonatomic, strong) UIColor *barColor; //NavigationBar background color, default is white
@property (nonatomic, strong) UIImage *backgroundImage; //default is nil

@end

@interface UINavigationBar (SKAdd)
- (void)sk_setBackgroundColor:(UIColor *)backgroundColor;
- (void)sk_setElementsAlpha:(CGFloat)alpha;
- (void)sk_setTranslationY:(CGFloat)translationY;
- (void)sk_reset;
//additional
- (void)sk_setNeedsNavigationBarGroundColorAlpha:(CGFloat)alpha;
- (void)sk_setNeedsNavigationBarGroundColor:(UIColor *)backgroundColor
                                      alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
