//
//  NSTimer+SKAdd.h
//  SKToolsDemo
//
//  Created by Sakya on 2017/6/16.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (SKAdd)



/**
 Creates and returns a new NSTimer object and schedules it on the current run


 @param seconds <#seconds description#>
 @param block <#block description#>
 @param repeats <#repeats description#>
 @return <#return value description#>
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats;


/**
 Creates and returns a new NSTimer object initialized with the specified block.

 */
+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats;
@end
NS_ASSUME_NONNULL_END
