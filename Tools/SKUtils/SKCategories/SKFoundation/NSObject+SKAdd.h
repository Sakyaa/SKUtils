//
//  NSObject+SKAdd.h
//  SKToolsDemo
//
//  Created by Sakya on 2017/6/16.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SKAdd)
/**
      // no variable args
 [view performSelectorWithArgs:@selector(removeFromSuperView)];
 */
- (nullable id)performSelectorWithArgs:(SEL)sel, ...;


/**
 // no variable args
 [view performSelectorWithArgs:@selector(removeFromSuperView) afterDelay:2.0];
 */
- (void)performSelectorWithArgs:(SEL)sel afterDelay:(NSTimeInterval)delay, ...;
- (void)performSelector:(SEL)sel afterDelay:(NSTimeInterval)delay;
/**
 Swap two instance method's implementation in one class. Dangerous, be careful.
 
 @param originalSel   Selector 1.
 @param newSel        Selector 2.
 @return              YES if swizzling succeed; otherwise, NO.
 */
+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

/**
 Swap two class method's implementation in one class. Dangerous, be careful.
 
 @param originalSel   Selector 1.
 @param newSel        Selector 2.
 @return              YES if swizzling succeed; otherwise, NO.
 */
+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;

/**
 Returns the class name in NSString.
 */
+ (NSString *)className;

/**
 Returns the class name in NSString.
 
 @discussion Apple has implemented this method in NSObject(NSLayoutConstraintCallsThis),
 but did not make it public.
 */
- (NSString *)className;
@end

NS_ASSUME_NONNULL_END
