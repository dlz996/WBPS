//
//  AbnormalViewController.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/13.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "BasicViewController.h"

/** 异常控制器 */
@interface AbnormalViewController : BasicViewController
/** 视图类型  1 异常  2 事故 */
@property (nonatomic,assign)NSInteger viewType;

/** 主订单ID */
@property (nonatomic,copy)NSString * mainOrderID;

/** 子订单ID */
@property (nonatomic,copy)NSString * subOrderID;

@end
