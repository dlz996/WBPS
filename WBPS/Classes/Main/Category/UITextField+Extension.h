//
//  UITextField+Extension.h
//  QiongLiao
//
//  Created by 董立峥 on 15/9/10.
//  Copyright (c) 2015年 WBKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)

+ (instancetype)textFieldWithText:(NSString *)text;
+ (instancetype)textFieldWithPlaceholder:(NSString *)placeholder;
+ (instancetype)textFieldWithText:(NSString *)text atTextColor:(UIColor *)color;
+ (instancetype)textFieldWithText:(NSString *)text atPlaceholder:(NSString *)placeholder;
+ (instancetype)textFieldWithText:(NSString *)text atTextColor:(UIColor *)color atTextSize:(CGFloat)size;
+ (instancetype)textFieldWithText:(NSString *)text atPlaceholder:(NSString *)placeholder atColor:(UIColor *)color;
/**
 *  创建UITextField
 *
 *  @param text        文字
 *  @param placeholder 占位符
 *  @param color       字体颜色
 *  @param size        字体大小
 *
 *  @return 返回创建的textField
 */
+ (instancetype)textFieldWithText:(NSString *)text atPlaceholder:(NSString *)placeholder atColor:(UIColor *)color atTextSize:(CGFloat)size;
@end
