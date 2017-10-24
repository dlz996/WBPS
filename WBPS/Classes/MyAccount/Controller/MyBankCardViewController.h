//
//  MyBankCardViewController.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/28.
//  Copyright © 2017年 董立峥. All rights reserved.
//


#import "BasicViewController.h"
/** 银行卡列表数据模型 */
#import "BankListModel.h"

typedef void(^returnCardInfo)(BankListModel * returnModel);


/** 我的银行卡 */
@interface MyBankCardViewController : BasicViewController

/**
     决定控制器内部操作      1.选择卡片，使用block返回数据  2.查看卡片，默认操作
 */
@property (nonatomic,assign)NSInteger type;

@property (nonatomic,copy)returnCardInfo returnCard;

@end
