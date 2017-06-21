//
//  NSMutableDictionary+SKAdd.h
//  SKToolsDemo
//
//  Created by Sakya on 17/6/10.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (SKAdd)


/**
 针对一些需要上传的字段但字段不能为nil 则用 @"" 代替
 */
- (void)setSafeObject:(id)anObject forKey:(NSString *)aKey;

@end
