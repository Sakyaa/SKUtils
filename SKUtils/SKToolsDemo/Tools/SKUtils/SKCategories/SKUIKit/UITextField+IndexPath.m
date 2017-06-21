//
//  UITextField+IndexPath.m
//  DangJian
//
//  Created by Sakya on 17/5/19.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "UITextField+IndexPath.h"
#import <objc/runtime.h>

@implementation UITextField (IndexPath)
static char indexPathKey;
- (NSIndexPath *)indexPath {
    return objc_getAssociatedObject(self, &indexPathKey);
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject(self, &indexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
