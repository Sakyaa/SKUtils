//
//  SKHelper.m
//  SKToolsDemo
//
//  Created by Sakya on 17/6/10.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "SKHelper.h"
#import "UIImage+SKAdd.h"
#import "UIApplication+SKAdd.h"

@implementation SKHelper

//获取当前视图控制器
#pragma mark -- 获取当前的ViewController
// 获取当前处于activity状态的view controller
+ (UIViewController *)activityViewController {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    } else {
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
        //        <span style="font-family: Arial, Helvetica, sans-serif;">//  这方法下面有详解    </span>
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    } else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    } else {
        result = nextResponder;
    }
    
    return result;
}
//获取最上层的控制器
+ (UIViewController*)topViewController {
    
    return [SKHelper topViewControllerWithRootViewController:[[UIApplication sharedApplication] keyWindow].rootViewController];
}
+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)superViewControllerWithView:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


+ (NSData *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return data;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength &&
           data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    return data;
}
+ (NSString *)writeToDocumentWithData:(NSData* )data withSuffixName:(NSString *)suffixName {
    
    NSString *path = [self filePathDependsFileName:suffixName];
    [data writeToFile:path atomically:YES];
    return path;
}
//获取文件路径
+ (NSString*)filePathDependsFileName:(NSString*)fileName {
    
    // 获取沙盒目录
    /**
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:fileName];
     */
    NSArray* myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* myDocPath = [myPaths objectAtIndex:0];
    NSString* filePath = [myDocPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
    return filePath;
    
}
+ (NSData *)readDataFileName:(NSString *)fileName {
    
    NSString *path = [self filePathDependsFileName:fileName];
    //    　最后:从文件中读出数据:
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:NULL];
    return data;
}

+(NSMutableArray *)sortingArray:(NSMutableArray *)originalArray
                            key:(NSString *)key
                       sequence:(BOOL)sequence {
    //    yes升序    no降序大到小
    
    NSSortDescriptor *reversedSorter = [NSSortDescriptor sortDescriptorWithKey:key ascending:sequence];
    NSMutableArray *descriptors = [NSMutableArray arrayWithObjects:&reversedSorter count:1];
    NSArray *middleArray = [originalArray sortedArrayUsingDescriptors:descriptors];
    NSMutableArray *sendArray = [NSMutableArray arrayWithArray:middleArray];
    return sendArray;
}
+ (void)roundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii addView:(UIView *)addView {
    
    if (!addView) return;
    UIBezierPath  *maskPath= [UIBezierPath  bezierPathWithRoundedRect:addView.bounds
                                                    byRoundingCorners:corners          cornerRadii:cornerRadii];
    CAShapeLayer*maskLayer = [[CAShapeLayer  alloc]  init];
    maskLayer.frame = addView.bounds;
    maskLayer.path = maskPath.CGPath;
    addView.layer.mask = maskLayer;
    
}

#pragma mark -- time
//时间戳转化为时间字符串
+(NSString *)dateStringWithTimeInterval:(double)stampTime
                              timeStyle:(SKTimeStyle)style {
    NSAssert(stampTime > 0, @"less than 0");
    NSString *stampTimeStr = [NSString stringWithFormat:@"%f",stampTime];
    if ([stampTimeStr length] > 10) stampTime = [[stampTimeStr substringWithRange:NSMakeRange(0, 10)] doubleValue];
    NSTimeInterval time= stampTime;
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSString *dateString = [[SKHelper dataFormatTimeStyle:style] stringFromDate: detaildate];
    return dateString;
}
//时间字符串转换为时间戳
+ (NSTimeInterval)timeIntervalWithString:(NSString *)dateString {
    if (!dateString) return 0;
    NSDate *getDate = [[SKHelper dataFormatTimeStyle:SKTimeAllContainsNormalStyle] dateFromString:dateString];
    NSTimeInterval getTimeIntervla = [getDate timeIntervalSince1970];
    return getTimeIntervla;
}
+ (NSTimeInterval)timeIntervalWithString:(NSString *)dateString
                               timeStyle:(SKTimeStyle)style {
    if (!dateString) return 0;
    NSDate *getDate = [[SKHelper dataFormatTimeStyle:style] dateFromString:dateString];
    NSTimeInterval getTimeIntervla = [getDate timeIntervalSince1970];
    return getTimeIntervla;
}
+ (NSDateFormatter *)dataFormatTimeStyle:(SKTimeStyle)style {
    
    NSDateFormatter *transferFormatter;
    if (style == SKTimeAllContainsNormalStyle) {
        static NSDateFormatter *formatterGetData;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            formatterGetData = [[NSDateFormatter alloc] init];
            [formatterGetData setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            [formatterGetData setLocale:[NSLocale currentLocale]];
        });
        transferFormatter = formatterGetData;
    } else if (style == SKTimeAllContainsSlashStyle) {
        static NSDateFormatter *formatterGetData;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            formatterGetData = [[NSDateFormatter alloc] init];
            [formatterGetData setDateFormat:@"yyyy/MM-dd HH:mm:ss"];
            [formatterGetData setLocale:[NSLocale currentLocale]];
        });
        transferFormatter = formatterGetData;
    } else if (style == SKTimeMonthDayHourSecondStyle) {
        static NSDateFormatter *formatterGetData;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            formatterGetData = [[NSDateFormatter alloc] init];
            [formatterGetData setDateFormat:@"MM-dd HH:mm:ss"];
            [formatterGetData setLocale:[NSLocale currentLocale]];
        });
        transferFormatter = formatterGetData;
    }
    return transferFormatter;
}
#pragma mark -- system
+ (void)sk_closeKeyboard {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
+ (void)clearUserDefaults {
    
    //方法一
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    /**
    //方法二

    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    // 方法三
    [[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:[[NSBundle mainBundle] bundleIdentifier]];
     */
}
@end
