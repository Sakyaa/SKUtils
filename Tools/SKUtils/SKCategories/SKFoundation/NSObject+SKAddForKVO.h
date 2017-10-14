//
//  NSObject+SKAddForKVO.h
//  SKToolsDemo
//
//  Created by Sakya on 2017/6/21.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SKAddForKVO)
- (void)sk_addObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(id _Nonnull obj, _Nullable id oldVal, _Nullable id newVal))block;

- (void)sk_removeObserverBlocksForKeyPath:(NSString *)keyPath;


- (void)sk_removeObserverBlocks;

@end
NS_ASSUME_NONNULL_END
