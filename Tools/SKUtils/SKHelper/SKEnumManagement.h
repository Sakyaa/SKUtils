//
//  SKEnumManagement.h
//  SKToolsDemo
//
//  Created by Sakya on 2017/10/19.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#ifndef SKEnumManagement_h
#define SKEnumManagement_h

typedef NS_OPTIONS(NSInteger, SKTimeStyle) {
    
    SKTimeAllContainsNormalStyle = 0, //@"yyyy-MM-dd HH:mm:ss"
    SKTimeAllContainsSlashStyle = 1, //@"yyyy/MM-dd HH:mm:ss"
    SKTimeMonthDayHourSecondStyle = 2, //@"MM-dd HH:mm"
};

#endif /* SKEnumManagement_h */
