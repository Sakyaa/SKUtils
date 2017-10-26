//
//  AppManagement.m
//  SKToolsDemo
//
//  Created by Sakya on 2017/10/19.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "AppManagement.h"
#import "UIApplication+SKAdd.h"

@implementation AppManagement

+ (void)appVersionDetected {
    
    NSString *url = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/lookup?id=%@",@"appid"];
    [self postPath:url];
}
+ (void)postPath:(NSString *)path {
    
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    NSOperationQueue *queue = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        NSMutableDictionary *receiveStatusDic=[[NSMutableDictionary alloc]init];
        if (data) {
            NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([[receiveDic valueForKey:@"resultCount"] integerValue]>0) {
                [receiveStatusDic setValue:@"1" forKey:@"status"];
                [receiveStatusDic setValue:[[[receiveDic valueForKey:@"results"] objectAtIndex:0] valueForKey:@"version"]   forKey:@"version"];
            } else {
                [receiveStatusDic setValue:@"-1" forKey:@"status"];
            }
        } else {
            [receiveStatusDic setValue:@"-1" forKey:@"status"];
        }
        
        [self performSelectorOnMainThread:@selector(receiveData:) withObject:receiveStatusDic waitUntilDone:NO];
    }];
}
+ (void)receiveData:(id)sender {
    
    NSString *newVersion = [sender objectForKey:@"version"];
    NSString *oldVersion = [UIApplication sharedApplication].appVersion;
    if ([oldVersion compare:newVersion options:NSNumericSearch] ==NSOrderedDescending) {
        NSLog(@"%@ is bigger",oldVersion);
        
    } else if ([newVersion isEqualToString:oldVersion]) {
        
        NSLog(@"%@ is equal %@",newVersion,oldVersion);
    } else {
        
        NSLog(@"%@ is bigger ",newVersion);
    }
}
@end
