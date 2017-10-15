//
//  UINavigationBar+Awesome.h
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SKNavigationBarManager : NSObject
+ (SKNavigationBarManager *)sharedManager;
@property (nonatomic, strong) UIColor *barColor; //NavigationBar background color, default is white
@property (nonatomic, strong) UIImage *backgroundImage; //default is nil

@end

@interface UINavigationBar (Awesome)
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)lt_setElementsAlpha:(CGFloat)alpha;
- (void)lt_setTranslationY:(CGFloat)translationY;
- (void)lt_reset;
//additional
- (void)sk_setNeedsNavigationBarGroundColorAlpha:(CGFloat)alpha;
- (void)sk_setNeedsNavigationBarGroundColor:(UIColor *)backgroundColor
                                   alpha:(CGFloat)alpha;

@end
