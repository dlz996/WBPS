//
//  QLFactory.h
//  QiongLiao
//
//  Created by appleKaiFa on 15/9/6.
//  Copyright (c) 2015年 XQBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    QLButtonTypeNormal, // 普通样式
    QLButtonTypeCorner, // 圆角
    QLButtonTypeSelect // 选择按钮
} QLButtonType;

@interface QLFactory : NSObject


+ (UIButton *)buttonWithTitle:(NSString *)title type:(QLButtonType)type;


/** 水平分隔线 */
+ (UIImageView *)horizontalSeparateImageView;

/** 垂直分隔线 */
+ (UIImageView *)verticalSeparateImageView;

@end
