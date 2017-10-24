//
//  AccountOperateTableCell.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/25.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountMoneyModel.h"
@interface AccountOperateTableCell : UITableViewCell

@property (nonatomic,strong)UIImageView *icon;
@property (nonatomic,strong)UILabel * contentLabel;
@property (nonatomic,strong)UILabel * moneyInfo;
@property (nonatomic,strong)AccountMoneyModel *model;
@end
