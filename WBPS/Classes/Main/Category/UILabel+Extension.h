//
//  UILabel+Extension.h
//  text
//
//  Created by 董立峥 on 15/9/10.
//  Copyright (c) 2015年 WBKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UILabel (Extension)

/** 自定义文字大小与颜色 以及字体类型*/
+ (instancetype)labelWithText:(NSString *)text atColor:(UIColor *)color atTextSize:(CGFloat)size atTextFontForType:(NSString *)type;

@end
