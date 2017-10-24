//
//  HomeTableCell.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/21.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskListModel.h"
/** 首页Cell */
@interface HomeTableCell : UITableViewCell

/** 类型 */
@property (nonatomic,copy)NSString * type;

@property (nonatomic,strong)TaskListModel * model;


@end
