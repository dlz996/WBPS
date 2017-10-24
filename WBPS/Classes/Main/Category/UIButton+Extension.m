//
//  UIButton+Extension.m
//  text
//
//  Created by 董立峥 on 15/9/10.
//  Copyright (c) 2015年 WBKJ. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

/** 创建按钮，设置按钮文字，文字颜色默认灰色，文字大小默认12 */
+ (instancetype)buttonWithTitle:(NSString *)title atTarget:(id)target atAction:(SEL)action {
    return [self buttonWithTitle:title atTitleSize:0 atTitleColor:nil atTarget:target atAction:action];
}

/** 创建按钮，设置按钮文字与大小，文字颜色默认灰色 */
+ (instancetype)buttonWithTitle:(NSString *)title atTitleSize:(CGFloat)size atTarget:(id)target atAction:(SEL)action {
    return [self buttonWithTitle:title atTitleSize:size atTitleColor:nil atTarget:target atAction:action];
}

/** 创建按钮，设置按钮文字与文字颜色，文字大小默认12 */
+ (instancetype)buttonWithTitle:(NSString *)title atTitleColor:(UIColor *)color atTarget:(id)target atAction:(SEL)action {
    return [self buttonWithTitle:title atTitleSize:0 atTitleColor:color atTarget:target atAction:action];
}

/** 创建按钮，设置按钮文字、文字颜色与文字大小 */
+ (instancetype)buttonWithTitle:(NSString *)title atTitleSize:(CGFloat)size atTitleColor:(UIColor *)color atTarget:(id)target atAction:(SEL)action{
    CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:Title_Font size:(size ? : 12 )]];
    [button setTitleColor:(color ? : [UIColor grayColor]) forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    return button;
}

/** 创建带有图片与文字的按钮 */
+ (instancetype)buttonWithTitle:(NSString *)title atNormalImageName:(NSString *)normalImageName atSelectedImageName:(NSString *)selectedImageName atTarget:(id)target atAction:(SEL)action {
    
    CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:Black_Color forState:UIControlStateNormal];
    [button setImage:(normalImageName ? [UIImage imageNamed:normalImageName] : nil) forState:UIControlStateNormal];
    [button setImage:(selectedImageName ? [UIImage imageNamed:selectedImageName] : nil) forState:UIControlStateSelected];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [button.titleLabel setFont:[UIFont fontWithName:Title_Font size:14]];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/** 创建带有图片与文字的按钮 左文字右图片 */
+ (instancetype)buttonWithTitle:(NSString *)title atRightNormalImageName:(NSString *)ImageName atRightSelectedImageName:(NSString *)selectedImageName atTarget:(id)target atAction:(SEL)action {
    
    CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:Black_Color forState:UIControlStateNormal];
    [button setImage:(ImageName ? [UIImage imageNamed:ImageName] : nil) forState:UIControlStateNormal];
    [button setImage:(selectedImageName ? [UIImage imageNamed:selectedImageName] : nil) forState:UIControlStateSelected];
    CGFloat labelWidth = [button.titleLabel.text sizeWithFont:button.titleLabel.font].width;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -[UIImage imageNamed:ImageName].size.width, 0, [UIImage imageNamed:ImageName].size.width)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width, 0, -labelWidth-15)];
    [button.titleLabel setFont:[UIFont fontWithName:Title_Font size:14]];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/** 创建带有图片与文字的按钮 */
+ (instancetype)buttonWithTitle:(NSString *)title atBackgroundNormalImageName:(NSString *)BackgroundImageName atBackgroundSelectedImageName:(NSString *)BackgroundselectedImageName atTarget:(id)target atAction:(SEL)action {
    
    CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom];
    /** 设置标题 */
    [button setTitle:title forState:UIControlStateNormal];
    /** 设置字体颜色 */
    [button setTitleColor:Black_Color forState:UIControlStateNormal];
    /** 普通背景图 */
    [button setBackgroundImage:(BackgroundImageName ? [UIImage imageNamed:BackgroundImageName] : nil) forState:UIControlStateNormal];
    /** 选中背景图 */
    [button setBackgroundImage:(BackgroundselectedImageName ? [UIImage imageNamed:BackgroundselectedImageName] : nil) forState:UIControlStateSelected];
    /** 添加点击事件 */
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    /** 设置字体 */
    [button.titleLabel setFont:[UIFont fontWithName:Title_Font size:14]];
    return button;
}

@end
