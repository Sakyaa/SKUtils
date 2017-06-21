//
//  UIDevice+SKAdd.m
//  SKToolsDemo
//
//  Created by Sakya on 2017/6/21.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "UIDevice+SKAdd.h"

@implementation UIDevice (SKAdd)
- (BOOL)isPad {
    static dispatch_once_t one;
    static BOOL pad;
    dispatch_once(&one, ^{
        pad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    });
    return pad;
}

- (BOOL)isSimulator {
#if TARGET_OS_SIMULATOR
    return YES;
#else
    return NO;
#endif
}
@end
