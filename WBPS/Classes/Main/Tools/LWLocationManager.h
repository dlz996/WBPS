//
//  LWLocationManager.h
//  FortuneDonkey
//
//  Created by 董立峥 on 2017/3/3.
//  Copyright © 2017年 LW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

/**
 *  定位成功的回调
 */
typedef void(^locationSuccessBlock)(CLLocationCoordinate2D coordinate);

typedef void(^reverseGeocodeSuccessBlock)(AMapLocationReGeocode *regeocode);

typedef void(^errorBlock)(id error);

/**
 *  定位错误的回调
 */
typedef void(^locationErrorBlock)(NSError *error);

@interface LWLocationManager : NSObject

@property (nonatomic, strong) AMapLocationManager *manager;

+ (instancetype)sharedManager;



/**
 *  获取地理位置信息
 *
 *  @param success 请求成功回调
 *  @param regeocode   地理定位
 */
- (void)getLocationSuccess:(locationSuccessBlock)success
                 Regeocode:(reverseGeocodeSuccessBlock)regeocode error:(errorBlock)error;

/**更新地理位置**/
-(void)updateUserLocation;

@end
