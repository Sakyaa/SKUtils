//
//  NetworkLib.h
//  ThePartyBuild
//
//  Created by Sakya on 17/4/26.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SERVER_REQUEST_TIME_OUT 10

typedef NS_OPTIONS(NSInteger, HTTP_METHED) {
    
    HTTP_METHED_POST = 0,
    
    HTTP_METHED_GET
};


/**
 请求成功的block
 */
typedef void(^SuccessBlock)(id responseData);
/**
 请求失败的block
 */
typedef void(^FailedBlock)(id responseData);


@interface NetworkLib : NSObject

+ (void)requestServer:(HTTP_METHED)methed
                  url:(NSString *)path
            parameter:(NSDictionary *)param
              success:(SuccessBlock) successBlock
               failed:(FailedBlock) failedBlock;

+ (void)requestServer:(HTTP_METHED)methed
                  url:(NSString *)path
            parameter:(NSDictionary *)param
               header:(NSDictionary *)headerDictionary
              success:(SuccessBlock) successBlock
               failed:(FailedBlock) failedBlock;

/**
 包含图片上传的post

 @param path 上传地址
 @param param 上传参数
 @param images 上传图片数组
 @param uploadName 上传图片的key
 */
+ (void)uploadWithPath:(NSString *)path
                 param:(NSDictionary *)param
                images:(NSArray <UIImage *>*)images
       uploadName:(NSString *)uploadName
          successBlock:(void(^)(id result))successBlock
          failureBlock:(void(^)(NSError *errorMsg))failureBlock;



/**
 网络状况监测
 */
+ (void)netReachability;
@end
