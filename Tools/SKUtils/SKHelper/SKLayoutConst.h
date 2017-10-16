//
//  SKLayoutConst.h
//  SKToolsDemo
//
//  Created by Sakya on 2017/10/16.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#ifndef SKLayoutConst_h
#define SKLayoutConst_h

// iPhone X
#define  SK_iPhoneX (kScreen_Width == 375.f && kScreen_Height == 812.f ? YES : NO)

// Status bar height.
#define  SK_StatusBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height)

// Navigation bar height.
#define  SK_NavigationBarHeight  44.f

// Tabbar height.
#define  SK_TabbarHeight         (SK_iPhoneX ? (49.f+34.f) : 49.f)

// Tabbar safe bottom margin.
#define  SK_TabbarSafeBottomMargin         (SK_iPhoneX ? 34.f : 0.f)

// Status bar & navigation bar height./**常量－导航条高度*/
#define  HEIGHT_NAVIGATIONBAR_SYSTEM  (SK_iPhoneX ? 88.0f : 64.0f)

#define SK_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

#endif /* SKLayoutConst_h */
