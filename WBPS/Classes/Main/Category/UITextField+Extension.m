//
//  UITextField+Extension.m
//  QiongLiao
//
//  Created by 董立峥 on 15/9/10.
//  Copyright (c) 2015年 WBKJ. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)
+ (instancetype)textFieldWithText:(NSString *)text {
    return [self textFieldWithText:text atPlaceholder:nil atColor:nil atTextSize:0];
}

+ (instancetype)textFieldWithPlaceholder:(NSString *)placeholder {
    return [self textFieldWithText:nil atPlaceholder:placeholder atColor:nil atTextSize:0];
}

+ (instancetype)textFieldWithText:(NSString *)text atTextColor:(UIColor *)color {
    return [self textFieldWithText:text atPlaceholder:nil atColor:color atTextSize:0];
}
+ (instancetype)textFieldWithText:(NSString *)text atPlaceholder:(NSString *)placeholder {
    return [self textFieldWithText:text atPlaceholder:placeholder atColor:nil atTextSize:0];
}
+ (instancetype)textFieldWithText:(NSString *)text atTextColor:(UIColor *)color atTextSize:(CGFloat)size {
    return [self textFieldWithText:text atPlaceholder:nil atColor:color atTextSize:size];
}
+ (instancetype)textFieldWithText:(NSString *)text atPlaceholder:(NSString *)placeholder atColor:(UIColor *)color {
    return [self textFieldWithText:text atPlaceholder:placeholder atColor:color atTextSize:0];
}
+ (instancetype)textFieldWithText:(NSString *)text atPlaceholder:(NSString *)placeholder atColor:(UIColor *)color atTextSize:(CGFloat)size {
    
    UITextField *textField = [[UITextField alloc] init];
    textField.text = text ? : nil;
    
    if (placeholder) {
        
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSFontAttributeName : FONTS(13),NSForegroundColorAttributeName : FontGray_Color}];
    }

    textField.textColor =  color ? : Black_Color;
    textField.font = [UIFont systemFontOfSize:size ? : 13];
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

@end
