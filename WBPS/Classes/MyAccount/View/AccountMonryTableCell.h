//
//  AccountMonryTableCell.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/25.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AccountMoneyModel.h"
/** 显示钱的Cell */
@interface AccountMonryTableCell : UITableViewCell

@property (nonatomic,strong)AccountMoneyModel * model;

@end
