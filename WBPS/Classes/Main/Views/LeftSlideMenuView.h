//
//  LeftSlideMenuView.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/22.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideMenuHeaderView.h"

@protocol LeftSlideMenuViewDelegate;

@protocol LeftSlideMenuViewDelegate <NSObject>
/**
     点击菜单黑色部分调用方法
 */
- (void)clickLeftBlackView;


/**
 点击左侧菜单调用方法

 @param row   0. 我的账户  1.消息中心   2.接单设置    3.更多    4.点击header位置
 */
- (void)clickMenuSelect:(NSInteger)row;

@end

/** 侧滑菜单视图 */
@interface LeftSlideMenuView : UIView

@property (nonatomic,weak)id <LeftSlideMenuViewDelegate> delegate;
/** 头视图 */
@property (nonatomic,strong)LeftSlideMenuHeaderView * headerView;

@end
