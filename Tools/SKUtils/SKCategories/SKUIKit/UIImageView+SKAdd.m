//
//  UIImageView+SKAdd.m
//  SKToolsDemo
//
//  Created by Sakya on 2017/6/12.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "UIImageView+SKAdd.h"
#import "UIImage+SKAdd.h"


@implementation UIImageView (SKAdd)

- (void)sk_setCircleImageUrl:(NSString *)url {
    
    //如果本地导入了SDWebImage库
#if __has_include(<SDWebImage.h>)
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"img_studio_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        self.image = [image sk_setCircleImage];
    }];
#endif
    
}
- (void)sk_setCircleImageUrl:(NSString *)url
        placeholderImageName:(NSString *)placeholderImageName {
    
#if __has_include(<SDWebImage.h>)
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholderImageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        self.image = [image sk_setCircleImage];
    }];
#endif
}
- (void)sk_setImageUrl:(NSString *)url
     RoundCornerRadius:(CGFloat)radius
  placeholderImageName:(NSString *)placeholderImageName {
    
#if __has_include(<SDWebImage.h>)
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholderImageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        self.image = [image sk_imageByRoundCornerRadius:radius];

    }];
#endif
}

@end
