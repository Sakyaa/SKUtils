//
//  NSData+SKAdd.h
//  SKToolsDemo
//
//  Created by Sakya on 17/6/10.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (SKAdd)

- (NSString *)sk_md5String;
- (NSString *)sk_hmacMD5StringWithKey:(NSString *)key;
+ (NSData *)sk_dataWithBase64EncodedString:(NSString *)base64EncodedString;
- (NSString *)sk_base64EncodedString;

@end
