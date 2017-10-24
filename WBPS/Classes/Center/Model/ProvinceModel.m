//
//  ProvinceModel.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/9.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel
- (instancetype) initWithDict:(NSDictionary *)dic{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype) provinceWithDict:(NSDictionary *)dic{
    return [[self alloc] initWithDict:dic];
}

+ (NSArray *) provinces{
    NSArray *sourceArr=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil]];
    NSMutableArray *desArr=[NSMutableArray array];
    //循环遍历字典数组，字典转模型
    for (NSDictionary *dic in sourceArr) {
        //每一个字典对应着一个模型对象
        ProvinceModel *provincer=[ProvinceModel provinceWithDict:dic];
        [desArr addObject:provincer];
    }
    return desArr;
}

@end
