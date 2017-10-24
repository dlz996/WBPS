//
//  suspensionView.h
//  悬浮球
//
//  Created by 董立峥 on 2017/9/29.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  SuspensionViewDelegate;

@protocol SuspensionViewDelegate <NSObject>
/**
     点击悬浮球调用方法
 */
- (void)clickSuspensionView;

@end

@interface SuspensionView : UIView

@property (nonatomic,weak)id <SuspensionViewDelegate> delegate;
/** 车辆状态 默认空载 */
@property (nonatomic,copy)NSString * carStateType;

@end
