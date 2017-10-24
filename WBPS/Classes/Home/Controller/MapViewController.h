//
//  MapViewController.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/27.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "BasicViewController.h"

#import "TaskInfoModel.h"

@interface MapViewController : BasicViewController

/** 订单号 */
@property (nonatomic,copy) NSString *orderNO;

@property (nonatomic,strong) TaskInfoModel * model;



@end
