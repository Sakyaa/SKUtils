//
//  SKHelper.h
//  SKToolsDemo
//
//  Created by Sakya on 17/6/10.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SKHelper : NSObject


//版本升级管理
+ (void)appVersionDetected;


//获取视图
// 获取当前处于activity状态的view controller
+ (UIViewController *)activityViewController;
+ (UIViewController*)topViewController;
+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController;
//获取当前view的viewcontroller
+ (UIViewController *)superViewControllerWithView:(UIView *)view;


//获取图片的url
// *  将图片存入沙盒
+ (NSURL *)saveImage:(UIImage *)currentImage
            withName:(NSString *)imageName;
/**
 *  将文件存入沙盒
 *
 *  @param data 文件
 *  @param suffixName    文件后缀名
 *
 *  @return  NSURL返回路径
 */
+ (NSString *)writeToDocumentWithData:(NSData* )data
                       withSuffixName:(NSString *)suffixName;
//获取文件名下的文件
+ (NSData *)readDataFileName:(NSString *)fileName;



/**
 数组排序
 @param originalArray 输入数据
 @param key 排序的key
 @param sequence 是否是顺序
 */
+(NSMutableArray *)sortingArray:(NSMutableArray *)originalArray
                            key:(NSString *)key
                       sequence:(BOOL)sequence;

/**可选位置的圆角度*/
+ (void)roundingCorners:(UIRectCorner)corners
            cornerRadii:(CGSize)cornerRadii
                addView:(UIView *)addView;


/**
 字符串转时间戳项目中用到
 @param dateString 日期字符串
 */
+ (NSTimeInterval)timeIntervalWithString:(NSString *)dateString;

//统一收键盘
+ (void)sk_closeKeyboard;
/**
 删除NSUserDefaults所有记录
 */
+ (void)clearUserDefaults;

@end
