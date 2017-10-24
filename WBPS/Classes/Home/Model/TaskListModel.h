//
//  TaskListModel.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/9.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskListModel : NSObject
/** 订单主键ID */
@property (nonatomic,copy)NSString * id;
/** 地址 */
@property (nonatomic,copy)NSString * address;
/** 账户 */
@property (nonatomic,copy)NSString * account;
/** 订单日期 */
@property (nonatomic,copy)NSString * orderdate;
/** 回单票数 */
@property (nonatomic,copy)NSString * hdnum;
/** 合计票数 */
@property (nonatomic,copy)NSString * detailnum;
/** 订单号 */
@property (nonatomic,copy)NSString * orderno;
/** 订单状态 */
@property (nonatomic,copy)NSString * mainstate;
/** 总条数记录 */
@property (nonatomic,copy)NSString * RecordCount;
/** 总页数 */
@property (nonatomic,copy)NSString * PageCount;

@end
