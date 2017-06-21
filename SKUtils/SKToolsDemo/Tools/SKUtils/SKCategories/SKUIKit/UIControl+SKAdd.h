//
//  UIControl+SKAdd.h
//  SKToolsDemo
//
//  Created by Sakya on 17/6/10.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (SKAdd)


/**
 设置点击间隔 可以用这个给重复点击加间隔
 */
@property (nonatomic, assign) NSTimeInterval custom_acceptEventInterval;

/**
 Removes all targets and actions for a particular event
 */
- (void)sk_removeAllTargets;

/**
 Adds or replaces a target and action for a particular event (or events)
 to an internal dispatch table.
设置控件的事件
 */
- (void)sk_setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 控件添加事件

 */
- (void)sk_addBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;


/**
 控件设置事件

 */
- (void)sk_setBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

/**
 控件移除事件

 */
- (void)sk_removeAllBlocksForControlEvents:(UIControlEvents)controlEvents;

@end
