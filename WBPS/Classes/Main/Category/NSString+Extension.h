//
//  NSString+Extension.h
//  QiongLiao
//
//  Created by 董立峥 on 15/9/10.
//  Copyright (c) 2015年 WBKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/** 获取对应的距离描述 */
- (NSString *)distanceDiscribe;
/** 获取对应的时间描述 */
- (NSString *)timeDiscribe;
/** 获取对应的时间描述(1天前) */
- (NSString *)timeForDayDiscribe;
/** 获取对应的时间描述(20小时30分钟) */
- (NSString *)timeForDayAndHourDiscribe;
/** 根据秒数获取对应的时间描述(1天前) */
- (NSString *)timeForDayWithSecond:(NSString *)second;

/** 格式化一个字符串为日期格式 */
+(NSString *)stringByDateString:(NSDate *)date;

/** 格式化字符串 */
+(NSString *)stringByString:(NSString *)string;




@end
