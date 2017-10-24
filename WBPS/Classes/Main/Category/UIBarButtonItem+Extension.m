//
//  UIBarButtonItem+Extension.m
//  text
//
//  Created by 董立峥 on 15/9/10.
//  Copyright (c) 2015年 WBKJ. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)itemWithImageName:(NSString *)imageName atTarget:(id)target atAction:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)itemWithTitle:(NSString *)title atTarget:(id)target atAction:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:target action:action];
    NSMutableDictionary *attrDict = @{}.mutableCopy;
    attrDict[NSFontAttributeName] = FONTS(15);
    [item setTitleTextAttributes:attrDict forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrDict forState:UIControlStateHighlighted];
    return item;
}

@end
