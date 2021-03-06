//
//  SKCGUtilities.h
//  SKToolsDemo
//
//  Created by Sakya on 2017/6/13.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#if __has_include("SKKitMacro.h")
#import "SKKitMacro.h"
#endif

SK_EXTERN_C_BEGIN
NS_ASSUME_NONNULL_BEGIN

/// Get main screen's scale.
CGFloat SKScreenScale();

/// Get main screen's size. Height is always larger than width.
CGSize SKScreenSize();





/// Convert pixel to point.
/// Convert point to pixel.
static inline CGFloat CGFloatToPixel(CGFloat value) {
    return value * SKScreenScale();
}

/// Convert pixel to point.
static inline CGFloat CGFloatFromPixel(CGFloat value) {
    return value / SKScreenScale();
}
/// round point value for pixel-aligned
static inline CGFloat CGFloatPixelRound(CGFloat value) {
    CGFloat scale = SKScreenScale();
    return round(value * scale) / scale;
}

/// Convert CALayer's gravity string to UIViewContentMode.
UIViewContentMode SKCAGravityToUIViewContentMode(NSString *gravity);
/// Convert UIViewContentMode to CALayer's gravity string.
NSString *SKUIViewContentModeToCAGravity(UIViewContentMode contentMode);

// main screen's scale
#ifndef kScreenScale
#define kScreenScale SKScreenScale()
#endif

// main screen's size (portrait)
#ifndef kScreenSize
#define kScreenSize SKScreenSize()
#endif

// main screen's width (portrait)
#ifndef kScreenWidth
#define kScreenWidth SKScreenSize().width
#endif

// main screen's height (portrait)
#ifndef kScreenHeight
#define kScreenHeight SKScreenSize().height
#endif


NS_ASSUME_NONNULL_END
SK_EXTERN_C_END
