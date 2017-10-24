//
//  SelecterBankViewController.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/12.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "BasicViewController.h"

typedef void(^SelecterBankName)(NSString *str);

@interface SelecterBankViewController : BasicViewController

/** 返回银行名称 */
@property (nonatomic,copy)SelecterBankName bankName;

@end
