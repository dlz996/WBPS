//
//  CenterBallView.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/25.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 车辆类型模型 */
#import "CarTypeModel.h"

@protocol CenterBallViewDelegate;
@protocol CenterBallViewDelegate <NSObject>

/**
 点击确定取消按钮调用代理方法

 @param index  1  确认     2  取消
 */
- (void)clickSelectType:(NSInteger)index selectObj:(NSString *)selectString;

@end
/** 弹出视图 */
@interface CenterBallView : UIView

@property (nonatomic,weak)id <CenterBallViewDelegate> delegate;
/**
     显示类型  1 全市通   2 同城运输 3 选择运送的城市  4 车辆的类型 5 车辆的容积  6 车辆的载重
 */
@property (nonatomic,assign) NSInteger type;
/** 车辆类型数组 */
@property (nonatomic,strong)NSMutableArray * carTypeArray;

@end
