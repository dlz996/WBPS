//
//  QLFactory.m
//  QiongLiao
//
//  Created by appleKaiFa on 15/9/6.
//  Copyright (c) 2015年 XQBoy. All rights reserved.
//

#import "QLFactory.h"

@implementation QLFactory

+ (UIButton *)buttonWithTitle:(NSString *)title type:(QLButtonType)type {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:FONT];
    switch (type) {
        case QLButtonTypeNormal:
            // 背景图
            break;
        case QLButtonTypeCorner:
            button.layer.cornerRadius = 10.0;
            // 背景图
            break;
        case QLButtonTypeSelect:
            [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
            [button setImage:[UIImage imageNamed:@"btn-circle-normal"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"btn-circle-select"] forState:UIControlStateSelected];
        default:
            break;
    }
    
    [button.layer masksToBounds];
    return button;
}

+ (UIImageView *)horizontalSeparateImageView {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = LineGray_Color;
    return imageView;
}

+ (UIImageView *)verticalSeparateImageView {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = LineGray_Color;
    return imageView;
}




@end
