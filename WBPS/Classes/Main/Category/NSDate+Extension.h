//
//  NSDate+Extension.h
//  QiongLiao
//
//  Created by 董立峥 on 15/9/10.
//  Copyright (c) 2015年 WBKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/** 将日期转为字符串 */
+ (NSString *)stringConvertWithDate:(NSDate *)date;

/** 计算两个时间的差值 */
+ (NSInteger)calculateAgeFormDate:(NSDate *)formDate toDate:(NSDate *)toDate;
/** 获取当前时间 */
+ (NSString *)stringConvertWithNowDate;

/** 获取时间的年 */
+ (NSString *)gainYearWithDate:(NSDate *)date;
/** 获取时间的月 */
+ (NSString *)gainMonthWithDate:(NSDate *)date;
/** 获取时间的日 */
+ (NSString *)gainDayWithDate:(NSDate *)date;
/** 获取时间的时 */
+ (NSString *)gainHourWithDate:(NSDate *)date;
/** 获取时间的分 */
+ (NSString *)gainMinuteWithDate:(NSDate *)date;
/** 获取时间的秒 */
+ (NSString *)gainSecondWithDate:(NSDate *)date;

/** 将时间字符串转为自定义的格式 */
+ (NSString *)stringConvertWithDateString:(NSString *)dateString formatter:(NSString *)formatter;

/**根据某一个日期,获取n个月后的日期*/
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;

/**字符串(秒) 转换成时间格式*/
+(NSDate *)dateConvertWithDateString:(NSString *)string;

/**时间转换成时间戳*/
+(NSString *)stringChangConvertWithDate:(NSDate *)date;

/**时间字符串转换成NSDate*/
+(NSDate *)dateChangConvertWithDateString:(NSString *)dateString;

+ (NSString *)timeConvertWithSecond:(NSString *)timeString;

/**计算两个时间相差的天数*/
+(NSInteger )calculateStarDate:(NSDate *)starDate endDate:(NSDate *)endDate;

@end
