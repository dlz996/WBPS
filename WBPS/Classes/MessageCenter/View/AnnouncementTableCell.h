//
//  AnnouncementTableCell.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/14.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnnouncementModel.h"
/** 公告Cell */
@interface AnnouncementTableCell : UITableViewCell
/** 数据模型 */
@property (nonatomic,strong)AnnouncementModel * model;

@end
