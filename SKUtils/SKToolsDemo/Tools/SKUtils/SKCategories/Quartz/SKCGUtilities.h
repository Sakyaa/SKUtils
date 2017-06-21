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

// main screen's scale
#ifndef kScreenScale
#define kScreenScale YYScreenScale()
#endif

// main screen's size (portrait)
#ifndef kScreenSize
#define kScreenSize YYScreenSize()
#endif

// main screen's width (portrait)
#ifndef kScreenWidth
#define kScreenWidth YYScreenSize().width
#endif

// main screen's height (portrait)
#ifndef kScreenHeight
#define kScreenHeight YYScreenSize().height
#endif


NS_ASSUME_NONNULL_END
SK_EXTERN_C_END
