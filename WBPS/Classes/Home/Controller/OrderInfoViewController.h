//
//  OrderInfoViewController.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/21.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "BasicViewController.h"

@interface OrderInfoViewController : BasicViewController
/** 订单ID */
@property (nonatomic,copy) NSString * orderID;
/**
     订单是进行中还是已完成
     0 进行中 1 已完成
 */
@property (nonatomic,copy) NSString * type;
@end
