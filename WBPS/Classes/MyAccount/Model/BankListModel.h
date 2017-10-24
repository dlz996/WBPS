//
//  BankListModel.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/14.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 银行卡列表页数据模型 */
@interface BankListModel : NSObject

/** 用户gid */
@property (nonatomic,copy)NSString * userid;
/** 开户支行 */
@property (nonatomic,copy)NSString * bankid;
/** 身份证号号码 */
@property (nonatomic,copy)NSString * cardid;
/** 标识列 */
@property (nonatomic,copy)NSString * id;
/** 开户行 */
@property (nonatomic,copy)NSString * bankname;
/** 银行卡号 */
@property (nonatomic,copy)NSString * bankcode;
/** 户名 */
@property (nonatomic,copy)NSString * bankman;
/** 手机号 */
@property (nonatomic,copy)NSString * phonenumber;



@end
