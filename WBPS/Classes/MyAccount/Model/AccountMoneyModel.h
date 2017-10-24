//
//  AccountMoneyModel.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/11.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 账户余额数据model */
@interface AccountMoneyModel : NSObject

@property (nonatomic,copy)NSString * id;
@property (nonatomic,copy)NSString * userid;
/** 被冻结金额 */
@property (nonatomic,copy)NSString * frozenacc;
/** 账户余额 */
@property (nonatomic,copy)NSString * acc;

@end
