//
//  CarTypeModel.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/11.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 车辆类型数据模型 */
@interface CarTypeModel : NSObject

/** 可载体积 */
@property (nonatomic,copy)NSString * volumn;
/** 载重 */
@property (nonatomic,copy)NSString * weight;
/** 高度 */
@property (nonatomic,copy)NSString * height;
/** 车辆ID */
@property (nonatomic,copy)NSString * id;
/** 长度 */
@property (nonatomic,copy)NSString * lenth;
/** 宽度 */
@property (nonatomic,copy)NSString * width;
/** 车辆名字 */
@property (nonatomic,copy)NSString * vehiclemodel;
/** 车辆类型 */
@property (nonatomic,copy)NSString * vehicletype;

@end
