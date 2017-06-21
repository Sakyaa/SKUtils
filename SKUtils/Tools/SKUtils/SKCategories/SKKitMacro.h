//
//  SKKitMacro.h
//  SKToolsDemo
//
//  Created by Sakya on 17/6/11.
//  Copyright © 2017年 Sakya. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <pthread.h>


#ifndef SKKitMacro_h
#define SKKitMacro_h


//c c++
#ifdef __cplusplus
#define SK_EXTERN_C_BEGIN  extern "C" {
#define SK_EXTERN_C_END  }
#else
#define SK_EXTERN_C_BEGIN
#define SK_EXTERN_C_END
#endif


SK_EXTERN_C_BEGIN

#ifndef SK_SWAP // swap two value
#define SK_SWAP(_a_, _b_)  do { __typeof__(_a_) _tmp_ = (_a_); (_a_) = (_b_); (_b_) = _tmp_; } while (0)
#endif


/**
 Synthsize a weak  reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif


/**
 Returns a dispatch_wall_time delay from now.
 */
static inline dispatch_time_t dispatch_walltime_delay(NSTimeInterval second) {
    return dispatch_walltime(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC));
}

/**
 Returns a dispatch_wall_time from NSDate.
 */
static inline dispatch_time_t dispatch_walltime_date(NSDate *date) {
    NSTimeInterval interval;
    double second, subsecond;
    struct timespec time;
    dispatch_time_t milestone;
    
    interval = [date timeIntervalSince1970];
    subsecond = modf(interval, &second);
    time.tv_sec = second;
    time.tv_nsec = subsecond * NSEC_PER_SEC;
    milestone = dispatch_walltime(&time, 0);
    return milestone;
}
/**
 Submits a block for asynchronous execution on a main queue and returns immediately.
 */
static inline void dispatch_async_on_main_queue(void (^block)()) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}
/**
 Returns a dispatch_time delay from now.
 */
static inline dispatch_time_t dispatch_time_delay(NSTimeInterval second) {
    return dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC));
}
/**
  Submits a block for  execution on and a dispatch_time delay from now to carry out
 */
static inline void dispatch_time_delay_event(NSTimeInterval second,void (^block)()) {
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), block);
    
}



SK_EXTERN_C_END
#endif /* SKKitMacro_h */
