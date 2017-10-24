//
//  SignOrderViewController.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/28.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "BasicViewController.h"
#import "TaskInfoModel.h"

/** 签收控制器 */
@interface SignOrderViewController : BasicViewController
/** 订单详情数据模型 */
@property (nonatomic,strong)TaskInfoModel * model;

@end
