//
//  UIControl+SKAdd.m
//  SKToolsDemo
//
//  Created by Sakya on 17/6/10.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "UIControl+SKAdd.h"
#import <objc/runtime.h>

static const int block_key;

@interface _SKUIControlBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);
@property (nonatomic, assign) UIControlEvents events;

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events;
- (void)invoke:(id)sender;

@end

@implementation _SKUIControlBlockTarget

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events {
    self = [super init];
    if (self) {
        _block = [block copy];
        _events = events;
    }
    return self;
}

- (void)invoke:(id)sender {
    if (_block) _block(sender);
}

@end

@interface UIControl()

@property (nonatomic, assign) NSTimeInterval custom_acceptEventTime;

@end
@implementation UIControl (SKAdd)
+ (void)load{
    
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    
    Method customMethod = class_getInstanceMethod(self, @selector(custom_sendAction:to:forEvent:));
    SEL customSEL = @selector(custom_sendAction:to:forEvent:);
    
    //添加方法 语法：BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types) 若添加成功则返回No
    // cls：被添加方法的类  name：被添加方法方法名  imp：被添加方法的实现函数  types：被添加方法的实现函数的返回值类型和参数类型的字符串
    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(customMethod), method_getTypeEncoding(customMethod));
    
    //如果系统中该方法已经存在了，则替换系统的方法  语法：IMP class_replaceMethod(Class cls, SEL name, IMP imp,const char *types)
    if (didAddMethod) {
        class_replaceMethod(self, customSEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    } else {
        method_exchangeImplementations(systemMethod, customMethod);
    }
}

- (NSTimeInterval )custom_acceptEventInterval {
    return [objc_getAssociatedObject(self, "UIControl_acceptEventInterval") doubleValue];
}

- (void)setCustom_acceptEventInterval:(NSTimeInterval)custom_acceptEventInterval {
    objc_setAssociatedObject(self, "UIControl_acceptEventInterval", @(custom_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval )custom_acceptEventTime {
    return [objc_getAssociatedObject(self, "UIControl_acceptEventTime") doubleValue];
}

- (void)setCustom_acceptEventTime:(NSTimeInterval)custom_acceptEventTime {
    objc_setAssociatedObject(self, "UIControl_acceptEventTime", @(custom_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)custom_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    // 如果想要设置统一的间隔时间，可以在此处加上以下几句
    // 值得提醒一下：如果这里设置了统一的时间间隔，会影响UISwitch,如果想统一设置，又不想影响UISwitch，建议将UIControl分类，改成UIButton分类，实现方法是一样的
    // if (self.custom_acceptEventInterval <= 0) {
    //     // 如果没有自定义时间间隔，则默认为2秒
    //    self.custom_acceptEventInterval = 2;
    // }
    
    // 是否小于设定的时间间隔
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.custom_acceptEventTime >= self.custom_acceptEventInterval);
    // 更新上一次点击时间戳
    if (self.custom_acceptEventInterval > 0) {
        self.custom_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
    if (needSendAction) {
        [self custom_sendAction:action to:target forEvent:event];
    }
}

- (void)sk_removeAllTargets {
    [[self allTargets] enumerateObjectsUsingBlock: ^(id object, BOOL *stop) {
        [self removeTarget:object action:NULL forControlEvents:UIControlEventAllEvents];
    }];
    [[self _sk_allUIControlBlockTargets] removeAllObjects];
}

- (void)sk_setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    if (!target || !action || !controlEvents) return;
    NSSet *targets = [self allTargets];
    for (id currentTarget in targets) {
        NSArray *actions = [self actionsForTarget:currentTarget forControlEvent:controlEvents];
        for (NSString *currentAction in actions) {
            [self removeTarget:currentTarget action:NSSelectorFromString(currentAction)
              forControlEvents:controlEvents];
        }
    }
    [self addTarget:target action:action forControlEvents:controlEvents];
}
- (void)sk_addBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block {
    if (!controlEvents) return;
    _SKUIControlBlockTarget *target = [[_SKUIControlBlockTarget alloc]
                                       initWithBlock:block events:controlEvents];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
    NSMutableArray *targets = [self _sk_allUIControlBlockTargets];
    [targets addObject:target];
}


- (void)sk_setBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block {
    [self sk_removeAllBlocksForControlEvents:UIControlEventAllEvents];
    [self sk_addBlockForControlEvents:controlEvents block:block];
}

- (void)sk_removeAllBlocksForControlEvents:(UIControlEvents)controlEvents {
    if (!controlEvents) return;
    
    NSMutableArray *targets = [self _sk_allUIControlBlockTargets];
    NSMutableArray *removes = [NSMutableArray array];
    for (_SKUIControlBlockTarget *target in targets) {
        if (target.events & controlEvents) {
            UIControlEvents newEvent = target.events & (~controlEvents);
            if (newEvent) {
                [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
                target.events = newEvent;
                [self addTarget:target action:@selector(invoke:) forControlEvents:target.events];
            } else {
                [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
                [removes addObject:target];
            }
        }
    }
    [targets removeObjectsInArray:removes];
}
- (NSMutableArray *)_sk_allUIControlBlockTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}
@end
