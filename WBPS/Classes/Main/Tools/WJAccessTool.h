//
//  WJAccessTool.h
//  Borderless
//
//  Created by Mr_怪蜀黍 on 16/11/21.
//  Copyright © 2016年 LW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJAccessTool : NSObject
/** 保存用户信息数据 */
+ (void)saveUserInfo;
/** 读取用户数据 */
+ (void)loadUserInfo;

/** 保存整型数据 */
+ (void)saveIntgerValueWith:(NSInteger)value key:(NSString *)key;
/** 读取整型数据 */
+ (NSInteger)loadIntgerValueWithKey:(NSString *)key;
@end
