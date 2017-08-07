//
//  NetworkLib.m
//  ThePartyBuild
//
//  Created by Sakya on 17/4/26.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "NetworkLib.h"
//#import <AFNetworking.h>
//#import <AFNetworkReachabilityManager.h>


//static AFNetworkReachabilityManager *networkManager;


@implementation NetworkLib
/**
+ (void)requestServer:(HTTP_METHED)methed
                  url:(NSString *)path
            parameter:(NSDictionary *)param
              success:(SuccessBlock) successBlock
               failed:(FailedBlock) failedBlock {
    
    
    if (methed == HTTP_METHED_GET) {
        [NetworkLib requestGetUrl:path parameter:param header:nil success:^(id responseData) {
            successBlock(responseData);
        } failed:^(id responseData) {
            failedBlock(failedBlock);
        }];
    } else if (methed == HTTP_METHED_POST) {
        [NetworkLib requestPostUrl:path parameter:param header:nil success:^(id responseData) {
            successBlock(responseData);
        } failed:^(id responseData) {
            failedBlock(failedBlock);
        }];
        
    }
}

+ (void)requestServer:(HTTP_METHED)methed
                  url:(NSString *)path
            parameter:(NSDictionary *)param
               header:(NSDictionary *)headerDictionary
              success:(SuccessBlock) successBlock
               failed:(FailedBlock) failedBlock {
   
    // 登录之后 || 异地登陆 || 注销 的每个请求都要加Header.
    NSString *token = [UserOperation shareInstance].account;
    NSDictionary *headerParam;
    //暂时用测试token
    if(token != nil) headerParam = @{@"token":token};

    if (methed == HTTP_METHED_GET) {
        [NetworkLib requestGetUrl:path parameter:param header:headerParam success:^(id responseData) {
            successBlock(responseData);
        } failed:^(id responseData) {
            failedBlock(failedBlock);
        }];
    } else if (methed == HTTP_METHED_POST) {
        
        [NetworkLib requestPostUrl:path parameter:param header:headerParam success:^(id responseData) {
            successBlock(responseData);
        } failed:^(id responseData) {
            failedBlock(failedBlock);
        }];
    }
    
}
+ (void)requestPostUrl:(NSString *)path
             parameter:(NSDictionary *)param
                header:(NSDictionary *)headerParam
               success:(void(^)(id responseData)) successBlock
                failed:(void(^)(id responseData)) failedBlock {
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    //申明返回的结果是类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是类型
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = SERVER_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/xml",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
   //设置请求头 token
    if (headerParam != nil) {
        NSArray *allKeys = [headerParam allKeys];
        for (NSString *key in allKeys){
            [manager.requestSerializer setValue:[headerParam objectForKey:key] forHTTPHeaderField:key];
        }
    }
    NSString *pathUrl = [NSString stringWithFormat:@"%@%@",APPBASEURLIP,path];
    DDLogInfo(@"请求参数***%@%@",pathUrl,param);
    [manager POST:pathUrl parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        DDLogInfo(@"%@",responseObject);
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DDLogInfo(@"%@",error);
        failedBlock(error);
    }];
  
}
+ (void)requestGetUrl:(NSString *)path
            parameter:(NSDictionary *)param
               header:(NSDictionary *)headerParam
              success:(void(^)(id responseData)) successBlock
               failed:(void(^)(id responseData)) failedBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是类型
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = SERVER_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/xml",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
  
    //设置请求头 token
    if (headerParam != nil) {
        NSArray *allKeys = [headerParam allKeys];
        for (NSString *key in allKeys){
            [manager.requestSerializer setValue:[headerParam objectForKey:key] forHTTPHeaderField:key];
        }
    }
    NSString *pathUrl = [NSString stringWithFormat:@"%@%@",APPBASEURLIP,path];
    DDLogInfo(@"请求参数***%@%@",pathUrl,param);
    [manager GET:pathUrl parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
        DDLogInfo(@"%@",responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DDLogInfo(@"%@",error);
        failedBlock(error);
    }];
}

+ (void)uploadWithPath:(NSString *)path
                 param:(NSDictionary *)param
                images:(NSArray <UIImage *>*)images
            uploadName:(NSString *)uploadName
          successBlock:(void(^)(id result))successBlock
          failureBlock:(void(^)(NSError *errorMsg))failureBlock {
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //申明返回的结果是类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是类型
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = SERVER_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/xml",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
    // 登录之后 || 异地登陆 || 注销 的每个请求都要加Header.
    NSString *token = [UserOperation shareInstance].account;
    //暂时用测试token
       //设置请求头 token
    if (token != nil) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    NSString *pathUrl = [NSString stringWithFormat:@"%@%@",APPBASEURLIP,path];
    [manager POST:pathUrl parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
//        NSString * fileName = [NSString stringWithFormat:@"%ld.jpg",(long)[[NSDate date] timeIntervalSince1970]];
//        
//        //-- methom 1
//        for (UIImage *image in images) {
//            
//            NSURL * urlPath = [Helper saveImage:image withName:fileName];
//            [formData appendPartWithFileURL:urlPath name:uploadName error:nil];
//        }
        //-- methom 2
        for (UIImage *image in images) {
            
            NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval nowa = [nowDate timeIntervalSince1970];
            UIImage *compressionImage = [image sk_imageByResizeToWidth:300];
            NSData *imageData;
            if (UIImagePNGRepresentation(compressionImage) == nil) {
                imageData = UIImageJPEGRepresentation(compressionImage, 0.5);
            } else {
                imageData = UIImagePNGRepresentation(compressionImage);
            }
            [formData appendPartWithFileData:imageData name:uploadName fileName:[NSString stringWithFormat:@"image%f",nowa] mimeType:@"png/jpeg/jpg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successBlock(responseObject);
        DDLogInfo(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DDLogInfo(@"%@",error);
        failureBlock(error);
    }];
    
    
}
+ (void)netReachability {
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //当网络状态发生变化时会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                [UserOperation shareInstance].netState = NetworkConditionWiFi;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机网络");
                [UserOperation shareInstance].netState = NetworkConditionWWAN;
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                [UserOperation shareInstance].netState = NetworkConditionNotReachable;
                
                break;
            case AFNetworkReachabilityStatusUnknown:
                [UserOperation shareInstance].netState = NetworkConditionNotReachable;
                
                NSLog(@"未知网络");
                break;
                
            default:
                break;
        }
    }];
    [manager startMonitoring];
}

- (void)dealloc {
    
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    
}
*/

@end
