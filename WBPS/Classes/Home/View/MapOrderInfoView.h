//
//  MapOrderInfoView.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/27.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskInfoModel.h"

@protocol MapOrderInfoViewDelegate;

@protocol MapOrderInfoViewDelegate <NSObject>


/**
 点击订单详情页面导航  到达目的地按钮调用的方法

 @param type 1 导航  2 到达目的地、签收  3  异常   4切换路线
 */
- (void)clickBottomButton:(NSInteger)type;

@end

@interface MapOrderInfoView : UIView

/** 操作按钮 */
@property (nonatomic,strong)UIButton * typeButton;

@property (nonatomic,strong)TaskInfoModel * model;

@property (weak,nonatomic)id <MapOrderInfoViewDelegate> delegate;

@end
