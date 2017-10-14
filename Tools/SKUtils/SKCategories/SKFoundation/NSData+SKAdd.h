//
//  NSData+SKAdd.h
//  SKToolsDemo
//
//  Created by Sakya on 17/6/10.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (SKAdd)


/**
 MD5

 @return md5加密
 */
- (NSString *)sk_md5String;
- (NSString *)sk_hmacMD5StringWithKey:(NSString *)key;
+ (NSData *)sk_dataWithBase64EncodedString:(NSString *)base64EncodedString;
- (NSString *)sk_base64EncodedString;
/**
 Returns an encrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData encrypted, or nil if an error occurs.
 */
- (NSData *)sk_aes256EncryptWithKey:(NSData *)key iv:(NSData *)iv;

/**
 Returns an decrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData decrypted, or nil if an error occurs.
 */
- (NSData *)sk_aes256DecryptWithkey:(NSData *)key iv:(NSData *)iv;
//加密
- (NSData *)sk_aes256_encrypt:(NSString *)key;

//解密
- (NSData *)sk_aes256_decrypt:(NSString *)key;



@end
