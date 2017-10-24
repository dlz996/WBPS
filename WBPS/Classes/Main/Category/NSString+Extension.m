//
//  NSString+Extension.m
//  QiongLiao
//
//  Created by 董立峥 on 15/9/10.
//  Copyright (c) 2015年 WBKJ. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSString *)distanceDiscribe {
    NSInteger distanceNum = self.integerValue;
    NSString *distanceDiscribe = nil;
    if (distanceNum <= 1000) {
        distanceDiscribe = [NSString stringWithFormat:@"%ldm",(long)distanceNum];
    }else{
        NSInteger k = distanceNum /1000;
        NSInteger m = distanceNum %1000;
        distanceDiscribe = [NSString stringWithFormat:@"%ld.%ldkm",(long)k,(long)m];
    }
    return distanceDiscribe;
}

- (NSString *)timeDiscribe {
    /** 当前时间 */
    NSDate *nowDate = [NSDate date];
    /** 目标时间 */
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *addDate = [formatter dateFromString:self];
    NSTimeInterval secondInterval = [nowDate timeIntervalSinceDate:addDate];
    NSTimeInterval minuteInterval = secondInterval / 60;
    NSTimeInterval hourInterval = minuteInterval / 24;
    
    NSString *timeDiscribe = nil;
    
    if (minuteInterval <= 5) {
        timeDiscribe = @"刚刚";
    }else if (minuteInterval > 5 && minuteInterval <= 60) {
        timeDiscribe = [NSString stringWithFormat:@"%.0f分钟前",minuteInterval];
    }else if (hourInterval < 24) {
        timeDiscribe = [NSString stringWithFormat:@"%.0f小时前",hourInterval];
    }else {
        timeDiscribe = [NSDate stringConvertWithDateString:self formatter:@"MM-dd"];
    }
    
    return timeDiscribe;
}

- (NSString *)timeForDayDiscribe
{
    /** 当前时间 */
    NSDate *nowDate = [NSDate date];
    /** 目标时间 */
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *addDate = [formatter dateFromString:self];
    NSTimeInterval secondInterval = [nowDate timeIntervalSinceDate:addDate];
    NSTimeInterval minuteInterval = secondInterval / 60;
    NSTimeInterval hourInterval = minuteInterval / 60;
    NSTimeInterval dayInterval = secondInterval / (24 *3600);
    NSString *timeForDayDiscribe = nil;
    if (minuteInterval <= 5) {
        timeForDayDiscribe = @"刚刚";
    }else if (minuteInterval > 5 && minuteInterval <= 60) {
        timeForDayDiscribe = [NSString stringWithFormat:@"%.0f分钟前",minuteInterval];
    }else if (hourInterval < 24) {
        timeForDayDiscribe = [NSString stringWithFormat:@"%.0f小时前",hourInterval];
    }else if(dayInterval >= 1){
        timeForDayDiscribe = [NSString stringWithFormat:@"%.0f天前",dayInterval];
    }
    
    return timeForDayDiscribe;
    
}

- (NSString *)timeForDayWithSecond:(NSString *)second
{
    NSDate *nowDate = [NSDate date];
    
    NSTimeInterval time = [nowDate timeIntervalSince1970];
    
    NSTimeInterval secondInterval =time-second.integerValue;
    NSTimeInterval minuteInterval = secondInterval / (60 *1000);
    NSTimeInterval hourInterval = minuteInterval / 60;
    NSTimeInterval dayInterval = secondInterval / (24 *3600*1000);
    NSString *timeForDayDiscribe = nil;
    if (minuteInterval <= 5) {
        timeForDayDiscribe = @"刚刚";
    }else if (minuteInterval > 5 && minuteInterval <= 60) {
        timeForDayDiscribe = [NSString stringWithFormat:@"%.0f分钟前",minuteInterval];
    }else if (hourInterval < 24) {
        timeForDayDiscribe = [NSString stringWithFormat:@"%.0f小时前",hourInterval];
    }
    else if (dayInterval>=1){
        timeForDayDiscribe = [NSString stringWithFormat:@"%.0f天前",dayInterval];

    }
   
    return timeForDayDiscribe;
    
}


-(NSString *)timeForDayAndHourDiscribe
{
    /** 当前时间 */
    NSDate *nowDate = [NSDate date];
    /** 目标时间 */
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *addDate = [formatter dateFromString:self];
    NSTimeInterval secondInterval = [nowDate timeIntervalSinceDate:addDate];
    NSTimeInterval minuteInterval = secondInterval / 60;
    NSTimeInterval hourInterval = minuteInterval / 60;
    NSTimeInterval surpluMinuteInterval = minuteInterval - 60 *hourInterval;
    NSTimeInterval dayInterval = secondInterval / (24 *3600);
    NSString *timeForDayAndHourDiscribe = nil;
    if (minuteInterval == 0) {
        timeForDayAndHourDiscribe = @"已经结束";
    }else if (minuteInterval <60){
        timeForDayAndHourDiscribe = [NSString stringWithFormat:@"距离结束还有%.0f分钟",minuteInterval];
    }else if (hourInterval < 24) {
        timeForDayAndHourDiscribe = [NSString stringWithFormat:@"距离结束还有%.0f小时%.0f分钟",hourInterval,surpluMinuteInterval];
    }else if(dayInterval >= 1){
        timeForDayAndHourDiscribe = [NSString stringWithFormat:@"距离结束还有%.0f天",dayInterval];
    }
    
    return timeForDayAndHourDiscribe;
    
}

+(NSString *)stringByDateString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSString *currentDateString = [dateFormatter stringFromDate:date];
    //输出currentDateString

    return currentDateString;
}
+(NSString *)stringByString:(NSString *)string{
    NSString *formatting = [string stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
    formatting = [formatting stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
    formatting = [formatting stringByReplacingOccurrencesOfString:@"日" withString:@""];
    
    return formatting;
}

@end
