//
//  UIColor+SKAdd.h
//  SKToolsDemo
//
//  Created by Sakya on 17/6/10.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SKAdd)


/**
 转换color
 @param rgbaValue The rgb value such as 0x66CCFF.
 @return [UIColor class]
 */
+ (UIColor *)sk_colorWithRGBA:(uint32_t)rgbaValue;

/**
 转换color
 @param rgbValue The rgb value such as 0x66CCFF.
 @param alpha 0.0 ～ 1.0
 @return [UIColor class]
 */
+ (UIColor *)sk_colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;


+ (UIColor *)sk_colorWithRGB:(uint32_t)rgbValue;

+ (UIColor *)sk_colorWithHexString:(NSString *)hexStr;


@end
