//
//  UIBarButtonItem+Extension.h
//  text
//
//  Created by 董立峥 on 15/9/10.
//  Copyright (c) 2015年 WBKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/** 根据图片名创建barButtonItem */
+ (instancetype)itemWithImageName:(NSString *)imageName atTarget:(id)target atAction:(SEL)action;

/** 根据title创建barButtonItem */
+ (instancetype)itemWithTitle:(NSString *)title atTarget:(id)target atAction:(SEL)action;

@end
