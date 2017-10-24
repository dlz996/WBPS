//
//  RecordModel.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/12.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 提现记录model */
@interface RecordModel : NSObject
/** 自增ID */
@property (nonatomic,copy) NSString * id;
/** 用户ID */
@property (nonatomic,copy) NSString * userid;
/** 申请日期 */
@property (nonatomic,copy) NSString * billdate;
/** 开户人 */
@property (nonatomic,copy) NSString * bankman;
/** 银行卡号 */
@property (nonatomic,copy) NSString * bankcode;
/** 开户行 */
@property (nonatomic,copy) NSString * bankname;
/** 开户支行 */
@property (nonatomic,copy) NSString * bankid;
/** 提现金额 */
@property (nonatomic,copy) NSString * acc;
/** 提现备注 */
@property (nonatomic,copy) NSString * remark;
/** 审核人 */
@property (nonatomic,copy) NSString * applyman;
/** 审核日期 */
@property (nonatomic,copy) NSString * applydate;
/** 审核状态（0：已申请、1、提现成功） */
@property (nonatomic,copy) NSString * applystate;

@end
