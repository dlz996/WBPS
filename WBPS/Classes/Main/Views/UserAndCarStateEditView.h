//
//  UserAndCarStateEditView.h
//  悬浮球
//
//  Created by 董立峥 on 2017/9/30.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CarState) {
    NSCarStateOfEmpty,   //空载
    NSCarStateOfHalf,     //半载
    NSCarStateOfFull     //满载
};

@protocol UserAndCarStateEditViewDelegate;

@protocol UserAndCarStateEditViewDelegate <NSObject>
/**
 更改车辆状态调用的方法

 @param state 1 空载  2 半载  3 满载
 */
- (void)selectCarState:(NSInteger)state;


/**
 设置下班状态调用方法
 */
- (void)outDutyButton;

/**
 点击空白区域调用方法
 */
- (void)clickBlankView;

@end

@interface UserAndCarStateEditView : UIView
/** 车辆的状态 */
@property (nonatomic)CarState  carStateType;

@property (nonatomic,weak)id <UserAndCarStateEditViewDelegate>delegate;

@end
