//
//  ProvinceModel.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/9.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceModel : NSObject

/**
 *  省份对应的所有城市
 */
@property (strong, nonatomic) NSArray *cities;
/**
 *  省份的名字
 */
@property (copy, nonatomic) NSString *name;

+(instancetype)provinceWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

+(NSArray *)provinces;

@end
