//
//  SKHUDManage.h
//  SKUIKitDemo
//
//  Created by Sakya on 2017/9/7.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>



@interface SKHUDManage : NSObject

/**
 成功提示

 @param statues 文字描述
 */
extern void SKHUDShowSuccessStatus(NSString *statues);
/**
 错误提示

 @param statues 文字描述
 */
extern void SKHUDShowErrorStatus(NSString *statues);

/**
 加载中...
 @param statues 文字可选项
 */
extern void SKHUDShowStatus(NSString *statues);

/**
 提示语
 @param statues 文字描述
 */
extern void SKHUDShowMessage(NSString *statues);

/**
 显示进度
 @param progress 进度描述
 */
extern void SKHUDShowProgress(CGFloat progress);

/**
 有描述的进度

 @param progress 进度
 @param statues 描述
 */
extern void SKHUDShowProgressAndStatues(CGFloat progress, NSString *statues);

/**
 关闭提示框
 */
extern void SKHUDDismissHud(void);

/**
 自定义的图片和描述

 @param statues 描述
 @param imageName 图片名称
 */
extern void SKHUDShowCustomImageStatus(NSString *statues, NSString *imageName);

/**
 是否是在主线程
 */
//- (void)isMainThreadOperation:(MainQueueBlock)mainQueueBlock
//         childThreadOperation:(ChildQueueBlock)childQueueBlock;
@end
