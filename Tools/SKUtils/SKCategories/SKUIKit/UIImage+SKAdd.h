//
//  UIImage+SKAdd.h
//  SKToolsDemo
//
//  Created by Sakya on 17/6/11.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SKAdd)


/**
 Create and return a 1x1 point size image with the given color.


 @param color color
 */
+ (UIImage *)sk_imageWithColor:(UIColor *)color;


/**
 Create and return a pure color image with the given color and size.
 
 @param color  The color.
 @param size   New image's type.
 */
+ (UIImage *)sk_imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 Create and return an image with custom draw code.


 @param size  The image size.
 
 */
+ (UIImage *)sk_imageWithSize:(CGSize)size
                    drawBlock:(void (^)(CGContextRef context))drawBlock;

#pragma mark - modify image
/**
 Returns a new image which is scaled from this image.
 The image will be stretched as needed.
 
 @param size  The new size to be scaled, values should be positive.
 
 */
- (UIImage *)sk_imageByResizeToSize:(CGSize)size;
/**
 Rounds a new image with a given corner size.
 
 @param radius  The radius of each corner oval. Values larger than half the
 rectangle's width or height are clamped appropriately to half
 the width or height.
 */
- (UIImage *)sk_imageByRoundCornerRadius:(CGFloat)radius;

/**
 Returns a new rotated image (relative to the center).
 
 @param radians   Rotated radians in counterclockwise.⟲
 
 @param fitSize   YES: new image's size is extend to fit all content.
 NO: image's size will not change, content may be clipped.
 */
- (UIImage *)sk_imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;


/**
 圆形图片
 */
- (instancetype)sk_setCircleImage;

+ (instancetype)sk_setCircleImage:(NSString *)image;

#pragma mark - image effect

/**
 Rounds a new image with a given corner size.
 
 @param radius       The radius of each corner oval. Values larger than half the
 rectangle's width or height are clamped appropriately to
 half the width or height.
 
 @param borderWidth  The inset border line width. Values larger than half the rectangle's
 width or height are clamped appropriately to half the width
 or height.
 
 @param borderColor  The border stroke color. nil means clear color.
 */
- (UIImage *)sk_imageByRoundCornerRadius:(CGFloat)radius
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(UIColor *)borderColor;

/**
 Applies a blur, tint color, and saturation adjustment to this image,
 optionally within the area specified by @a maskImage.
 
 @param blurRadius     The radius of the blur in points, 0 means no blur effect.
 
 @param tintColor      An optional UIColor object that is uniformly blended with
 the result of the blur and saturation operations. The
 alpha channel of this color determines how strong the
 tint is. nil means no tint.
 
 @param tintBlendMode  The @a tintColor blend mode. Default is kCGBlendModeNormal (0).
 
 @param saturation     A value of 1.0 produces no change in the resulting image.
 Values less than 1.0 will desaturation the resulting image
 while values greater than 1.0 will have the opposite effect.
 0 means gray scale.
 
 @param maskImage      If specified, @a inputImage is only modified in the area(s)
 defined by this mask.  This must be an image mask or it
 must meet the requirements of the mask parameter of
 CGContextClipToMask.
 
 @return               image with effect, or nil if an error occurs (e.g. no
 enough memory).
 */

- (UIImage *)sk_imageByBlurRadius:(CGFloat)blurRadius
                        tintColor:(UIColor *)tintColor
                         tintMode:(CGBlendMode)tintBlendMode
                       saturation:(CGFloat)saturation
                        maskImage:(UIImage *)maskImage;

#pragma mark - image compression
/**
 *  根据指定宽度，等比例调整图片尺寸
 *
 *  @param width 指定宽度
 */
- (UIImage *)sk_imageByResizeToWidth:(CGFloat)width;
/**
 *  根据指定宽度及是否按屏幕分辨比放大，等比例调整图片尺寸
 *
 *  @param width 指定宽度
 *  @param scale 是否按屏幕分辨比放大
 */
- (UIImage *)sk_imageByResizeToWidth:(CGFloat)width scale:(BOOL)scale;
/**
 *  根据压缩精度系数及文件大小，获取压缩后的JPEG格式的图片数据
 *
 *  @param factor   压缩精度系数[1e-10, 0.1]
 *  @param fileSize 文件大小
 */
- (NSData *)sk_compressToJPEGFormatDataWithFactor:(CGFloat)factor maxFileSize:(u_int64_t)fileSize;
/**
 *  指定图片宽度及图片文件大小，压缩图片，图片将等比例缩放
 *
 *  @param width       指定图片宽度
 *  @param maxFileSize 文件大小
 */
- (NSData *)sk_resetImageDataWithImageWidth:(CGFloat)width maxFileSize:(uint64_t)maxFileSize;



@end
