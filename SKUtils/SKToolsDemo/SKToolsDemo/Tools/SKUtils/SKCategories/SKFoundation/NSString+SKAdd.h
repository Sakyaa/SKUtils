//
//  NSString+SKAdd.h
//  SKToolsDemo
//
//  Created by Sakya on 17/6/10.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (SKAdd)

/**
 计算文字的高度
 @param font 文字大小
 @param width 最大宽度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 文字高度
 @param font 大小
 @param height 最大高度
 */
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

// 计算NSMutableAttributedString文字高度，可以处理计算带行间距的
- (CGFloat)boundingHeightWithSize:(CGSize)size font:(UIFont*)font;

/**
 文字高度
 
 @param size 最大size
 @param font 文字型号
 @param paragraphStyle 文字的style  可行距  缩紧类型
 */
- (CGFloat)boundingHeightWithSize:(CGSize)size font:(UIFont*)font paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle;


//*****************判断数据 ****************
//
/**
 判断是中文
 */
- (BOOL)isChinese;
/**
 字符串不为空
 */
- (BOOL)hasValue;
//银行卡
- (BOOL)isBankCard;
//身份证号
- (BOOL)isIdentityCard;
//邮箱
- (BOOL)isEmailAdress;


              //****************加密数据*****************
//
- (NSString *)sk_hmacMD5StringWithKey:(NSString *)key;
/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)sk_md5String;
// @name Encode and decode
///=============================================================================

/**
 Returns an NSString for base64 encoded.
 */
- (NSString *)sk_base64EncodedString;

/**
 Returns an NSString from base64 encoded string.
 */
+ (NSString *)sk_stringWithBase64EncodedString:(NSString *)base64EncodedString;


             //****************转换*****************
#pragma mark --网址转码 utf－8
/**
 转为utf－8编码
 */
+ (NSString *)stringTransformCoding:(NSString *)string;

- (NSNumber *)sk_numberValue;


- (NSString *)sk_stringByTrim;

@end
