//
//  MessageTableCell.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/25.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
/** 消息Cell */
@interface MessageTableCell : UITableViewCell

@property (nonatomic,strong)MessageModel * model;
@end
