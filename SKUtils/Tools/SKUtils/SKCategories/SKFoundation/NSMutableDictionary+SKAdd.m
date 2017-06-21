//
//  NSMutableDictionary+SKAdd.m
//  SKToolsDemo
//
//  Created by Sakya on 17/6/10.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "NSMutableDictionary+SKAdd.h"

@implementation NSMutableDictionary (SKAdd)

- (void)setSafeObject:(id)anObject forKey:(NSString *)aKey {
    if (!aKey || aKey.length < 1 || [aKey isEqual:[NSNull null]]) {
        return;
    }
    if (anObject == nil || [anObject isEqual:[NSNull null]] || !anObject) {
        
        [self setObject:@"" forKey:aKey];
        return;
    }
    
    [self setObject:anObject forKey:aKey];
}

@end
