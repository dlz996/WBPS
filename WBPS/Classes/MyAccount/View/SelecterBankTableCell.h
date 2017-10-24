//
//  SelecterBankTableCell.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/14.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelecterBankTableCell : UITableViewCell
/** 银行icon */
@property (nonatomic,strong)UIImageView * icon;
/** 银行名字 */
@property (nonatomic,strong)UILabel * bankName;
@end
