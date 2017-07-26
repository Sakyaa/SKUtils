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
+ (double)sk_systemVersion;

/// Whether the device is iPad/iPad mini.
@property (nonatomic, readonly) BOOL sk_isPad;

/// Whether the device is a simulator.
@property (nonatomic, readonly) BOOL sk_isSimulator;


@property (nonatomic, copy, readonly) NSString *sk_machineModelName;

@end

#ifndef kSystemVersion
#define kSystemVersion [UIDevice sk_systemVersion]
#endif

#ifndef kiOS6Later
#define kiOS6Later (kSystemVersion >= 6)
#endif

#ifndef kiOS7Later
#define kiOS7Later (kSystemVersion >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later (kSystemVersion >= 8)
#endif

#ifndef kiOS9Later
#define kiOS9Later (kSystemVersion >= 9)
#endif
NS_ASSUME_NONNULL_END
