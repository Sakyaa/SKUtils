//
//  SKHUDManage.m
//  SKUIKitDemo
//
//  Created by Sakya on 2017/9/7.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "SKHUDManage.h"
#import <SVProgressHUD.h>

typedef void(^MainQueueBlock)();
typedef void(^ChildQueueBlock)();

/* 默认简短提示语显示的时间，在这统一修改 */
static CGFloat const    SKHUDShowTime  = 2.0f;
//
static SKHUDManage      *HUDManager;



@implementation SKHUDManage
+ (void)load{
    HUDManager = [[SKHUDManage alloc] init];
    //该方法只会走一次
    [SVProgressHUD setMaximumDismissTimeInterval:SKHUDShowTime];
    [SVProgressHUD setMinimumSize:CGSizeMake(130, 130)];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0.1 green:0.3 blue:0.5 alpha:0.8]];
//    [SVProgressHUD setForegroundColor:[UIColor orangeColor]];
//    [SVProgressHUD setInfoImage:nil];
}

void SKHUDShowSuccessStatus(NSString *statues){
 
    [HUDManager threadOperation:^{
        [SVProgressHUD showSuccessWithStatus:statues];
    }];
}
void SKHUDShowErrorStatus(NSString *statues){
    
    [HUDManager threadOperation:^{
        [SVProgressHUD showErrorWithStatus:statues];
    }];
}

void SKHUDShowMessage(NSString *statues){

    [HUDManager threadOperation:^{
        [SVProgressHUD showInfoWithStatus:statues];
    }];
}



void SKHUDShowMaskStatus(NSString *statues){

    [HUDManager threadOperation:^{
        [SVProgressHUD showWithStatus:statues];
    }];
}

void SKHUDShowProgress(CGFloat progress){

    [HUDManager threadOperation:^{
        [SVProgressHUD showProgress:progress];
    }];
}
void SKHUDShowProgressAndStatues(CGFloat progress, NSString *statues) {
    
    [HUDManager threadOperation:^{
        [SVProgressHUD showProgress:progress status:statues];
    }];
}

void SKHUDDismissHud(void){

    [HUDManager threadOperation:^{
        [SVProgressHUD dismiss];
    }];
}
void SKHUDShowCustomImageStatus(NSString *statues, NSString *imageName) {
    
    [HUDManager threadOperation:^{
        [SVProgressHUD showImage:[UIImage imageNamed:imageName] status:statues];
    }];
}

/**
 是否是在主线程
 */
- (void)threadOperation:(MainQueueBlock)queueBlock {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            queueBlock();
        });
    } else {
        queueBlock();
    }
}

@end
