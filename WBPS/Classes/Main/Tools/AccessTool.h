//
//  AccessTool.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/9.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessTool : NSObject

/** 保存用户信息 */
+ (void)saveUserInfo;

/** 加载用户信息 */
+ (void)loadUserInfo;

@end
