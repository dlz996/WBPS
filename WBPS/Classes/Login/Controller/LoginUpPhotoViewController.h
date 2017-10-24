//
//  LoginUpPhotoViewController.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/26.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "BasicViewController.h"

@interface LoginUpPhotoViewController : BasicViewController

/**
 判断视图属性，从哪里进入
 1 登录注册
 2 个人中心
 */
@property (nonatomic,assign)NSInteger viewType;
/** 用户输入的信息 */
@property (nonatomic,strong)NSMutableDictionary * attestationInfoDic;
/** 用户选择的车辆类型的ID */
@property (nonatomic,copy)NSString * carTypeID;

@end
