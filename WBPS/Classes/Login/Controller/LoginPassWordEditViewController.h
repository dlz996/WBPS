//
//  LoginPassWordEditViewController.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/26.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "BasicViewController.h"

@interface LoginPassWordEditViewController : BasicViewController
/**
 用来判断页面类型
 1.忘记密码
 2.新用户注册
 */
@property (nonatomic,assign)NSInteger viewType;

@end
