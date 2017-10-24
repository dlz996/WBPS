//
//  NSDate+Extension.m
//  QiongLiao
//
//  Created by 董立峥 on 15/9/10.
//  Copyright (c) 2015年 WBKJ. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (NSString *)stringConvertWithDate:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)stringConvertWithNowDate
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *nowDateString = [dateFormatter stringFromDate:currentDate];
    return nowDateString;
}

+ (NSInteger)calculateAgeFormDate:(NSDate *)formDate toDate:(NSDate *)toDate {
    
    NSCalendar *userCalendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [userCalendar components:NSCalendarUnitYear fromDate:formDate toDate:toDate options:NSCalendarWrapComponents];
    
    NSInteger year =  [components year];
    
    return year;
}

+ (NSString *)gainYearWithDate:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY";
    NSString *yearString = [formatter stringFromDate:date];
    
    return yearString;
}

+ (NSString *)gainMonthWithDate:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM";
    NSString *monthString = [formatter stringFromDate:date];
    
    return monthString;
}
+ (NSString *)gainDayWithDate:(NSDate *)date {
 
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd";
    NSString *dayString = [formatter stringFromDate:date];
    
    return dayString;
}

/** 获取时间的时 */
+ (NSString *)gainHourWithDate:(NSDate *)date;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH";
    NSString *hourString = [formatter stringFromDate:date];
    
    return hourString;
}
/** 获取时间的分 */
+ (NSString *)gainMinuteWithDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"mm";
    NSString *minuteString = [formatter stringFromDate:date];
    
    return minuteString;
}

/** 获取时间的秒 */
+ (NSString *)gainSecondWithDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"ss";
    NSString *minuteString = [formatter stringFromDate:date];
    
    return minuteString;
}


+ (NSString *)stringConvertWithDateString:(NSString *)dateString formatter:(NSString *)formatter {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"YYYY-MM-dd HH-mm-ss";
    
    NSDate *date = [dateFormatter dateFromString:dateString];

    NSDateFormatter *customDateFormatter = [[NSDateFormatter alloc] init];
    
    customDateFormatter.dateFormat = formatter;
    
    return [customDateFormatter stringFromDate:date];
}

+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month

{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setMonth:month];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    return mDate;
    
}

+(NSDate *)dateConvertWithDateString:(NSString *)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH-mm-ss"];
    
    NSDate*confromTimesp = [NSDate dateWithTimeIntervalSince1970:string.integerValue];
    //NSString*confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimesp;
}

+(NSString *)stringChangConvertWithDate:(NSDate *)date
{
    NSTimeInterval time = [date timeIntervalSince1970];
    long long int timeDate = (long long int)time;
    NSString *dataString = [NSString stringWithFormat:@"%lld",timeDate];
    return dataString;
}

+(NSDate *)dateChangConvertWithDateString:(NSString *)dateString
{
    
    // 日期格式化类
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    // 设置日期格式 为了转换成功
    
    format.dateFormat = @"yyyy-MM-dd";
    
    // NSString * -> NSDate *
    
    NSDate *data = [format dateFromString:dateString];
    //转换成字符串
   // NSString *newString = [format stringFromDate:data];
    return data;
}

+(NSString *)timeConvertWithSecond:(NSString *)timeString
{
    NSInteger hour = timeString.integerValue/3600;
    NSInteger min = (timeString.integerValue%3600)/60;
    NSInteger second = (timeString.integerValue%3600)%60;
    NSString* hourStr = @"";
    NSString* minStr = @"";
    NSString* secondStr = @"";
    if (hour < 10) {
        hourStr = [NSString stringWithFormat:@"0%ld",hour];
    }else{
        hourStr = [NSString stringWithFormat:@"%ld",hour];
    }
    if (min < 10) {
        minStr = [NSString stringWithFormat:@"0%ld",min];
    }else {
        minStr = [NSString stringWithFormat:@"%ld",min];
    }
    if (second < 10) {
        secondStr = [NSString stringWithFormat:@"0%ld",second];
    }else {
        secondStr = [NSString stringWithFormat:@"%ld",second];
    }

    
    NSString *dataString = [NSString stringWithFormat:@"%@:%@'%@\"",hourStr,minStr,secondStr];
    return dataString;
}

+(NSInteger )calculateStarDate:(NSDate *)starDate endDate:(NSDate *)endDate
{
    //创建日期格式化对象
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    //取两个日期对象的时间间隔：
    
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    
    NSTimeInterval time=[endDate timeIntervalSinceDate:starDate];
    
    
    NSInteger days=((NSInteger)time)/(3600*24);
    
    //int hours=((int)time)%(3600*24)/3600;
    
    //NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    
    return days;
    
}

@end
