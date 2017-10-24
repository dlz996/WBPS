//
//  OrderInfoMapViewController.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/10.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "BasicViewController.h"
/** 任务详情模型 */
#import "TaskInfoModel.h"

/** 导航详情页 */
@interface OrderInfoMapViewController : BasicViewController

/** 导航管理类 */
@property (nonatomic, strong) AMapNaviDriveManager *Manager;

/** 是否是从订单详情列表进入     1 是   */
@property (nonatomic,assign)NSInteger type;
/** 任务详情 */
@property (nonatomic,strong)TaskInfoModel * model;
@end
