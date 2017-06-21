//
//  UIDevice+SKAdd.h
//  SKToolsDemo
//
//  Created by Sakya on 2017/6/21.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (SKAdd)
/// Device system version (e.g. 8.1)
+ (double)systemVersion;

/// Whether the device is iPad/iPad mini.
@property (nonatomic, readonly) BOOL isPad;

/// Whether the device is a simulator.
@property (nonatomic, readonly) BOOL isSimulator;

@end

NS_ASSUME_NONNULL_END
