//
//  DetailModel.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/12.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 收支明细数据模型 */
@interface DetailModel : NSObject
/** 标识ID */
@property (nonatomic,copy) NSString * id;
/** 发生金额 */
@property (nonatomic,copy) NSString * accfs;
/** 交易方式 */
@property (nonatomic,copy) NSString * acctype;
/** 操作类型 */
@property (nonatomic,copy) NSString * xmtype;
/** 备注 */
@property (nonatomic,copy) NSString * remark;
/** 发生前余额 */
@property (nonatomic,copy) NSString * baccfs;
/** 发生后余额 */
@property (nonatomic,copy) NSString * eaccfs;
/** 用户ID */
@property (nonatomic,copy) NSString * userid;
/** 日期 */
@property (nonatomic,copy) NSString * billdate;

@end
