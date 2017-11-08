//
//  UIImageView+SKAdd.h
//  SKToolsDemo
//
//  Created by Sakya on 2017/6/12.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SKAdd)


/**
 加载网络图片设置为圆形图片

 @param url 网络图片地址
 */
- (void)sk_setCircleImageUrl:(NSString *)url;

/**
 加载网络图片设置为圆形图片


 @param url 网络图片地址
 @param placeholderImageName 占位图
 */
- (void)sk_setCircleImageUrl:(NSString *)url
        placeholderImageName:(NSString *)placeholderImageName;

/**
 加载网络图片设置为圆形图片
 @param url 网络图片地址
 @param radius 自定义圆角度
 @param placeholderImageName 占位图
 */
- (void)sk_setImageUrl:(NSString *)url
     roundCornerRadius:(CGFloat)radius
  placeholderImageName:(NSString *)placeholderImageName;
@end
