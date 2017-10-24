//
//  LWLocationManager.m
//  FortuneDonkey
//
//  Created by 董立峥 on 2017/3/3.
//  Copyright © 2017年 LW. All rights reserved.
//

#import "LWLocationManager.h"


@implementation LWLocationManager


+ (LWLocationManager *)sharedManager {
    static LWLocationManager *localManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        localManager = [[LWLocationManager alloc]init];
    });
    return localManager;
}

-(instancetype)init
{
    if (self = [super init]) {
        self.manager = [[AMapLocationManager alloc]init];
        // 带逆地理信息的一次定位（返回坐标和地址信息）
        [self.manager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        //   定位超时时间，最低2s，此处设置为2s
       self.manager.locationTimeout =5;
        //   逆地理请求超时时间，最低2s，此处设置为2s
        self.manager.reGeocodeTimeout = 5;
    }
    return self;
}

-(void)getLocationSuccess:(locationSuccessBlock)success Regeocode:(reverseGeocodeSuccessBlock)regeocode error:(errorBlock)error
{
   
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请前往设置中心打开地理定位，以获取更好的体验" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        
    }
    [self.manager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocod, NSError *locationRrror) {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)locationRrror.code, locationRrror.localizedDescription);
            
            if (locationRrror.code == AMapLocationErrorLocateFailed)
            {
                if (error) {
                    error(locationRrror);
                }
                return;
            }
        }
        
        if (regeocode)
        {
            //经纬度
            if (success) {
                success(location.coordinate);
            }
            
            //地理信息
            if (regeocode) {
                regeocode(regeocod);
            }
//            [FDUserModel sharedUserInfo].myCity = regeocod.city;
            /** 存储用户信息模型 */
//            [WJAccessTool saveUserInfo];
            
        }
    }];

}

/**更新地理位置*/
-(void)updateUserLocation
{
    [self getLocationSuccess:^(CLLocationCoordinate2D coordinate) {
        
//        NSMutableDictionary *paraDict = @{}.mutableCopy;
////        [paraDict setObject:[FDUserModel sharedUserInfo].userId forKey:@"userId"];
//        [paraDict setObject:[FDUserModel sharedUserInfo].accessToken forKey:@"accessToken"];
//        [paraDict setObject:@(coordinate.longitude) forKey:@"longitude"];
//        [paraDict setObject:@(coordinate.latitude) forKey:@"latitude"];
//        [WJNetWorkManager WJPOSTWithUrl:kUpdateLocation Parameters:paraDict success:^(id responseObject) {
//            /** 更新用户信息模型数据 */
//            [FDUserModel setUserInfoModelWithDict:[responseObject objectForKey:@"data"]];
//
//            /** 存储用户信息模型 */
//            [WJAccessTool saveUserInfo];
//
//        } error:^(id error) {
//
//        } failure:^(NSError *error) {
//
//        }];
        
    } Regeocode:^(AMapLocationReGeocode *regeocode) {
        
    } error:^(id error) {
        
//        NSMutableDictionary *paraDict = @{}.mutableCopy;
//        [paraDict setObject:[FDUserModel sharedUserInfo].userId forKey:@"userId"];
//        [paraDict setObject:[FDUserModel sharedUserInfo].accessToken forKey:@"accessToken"];
//        [WJNetWorkManager WJPOSTWithUrl:kGetMyUserInfo Parameters:paraDict success:^(id responseObject) {
//            /** 更新用户信息模型数据 */
//            [FDUserModel setUserInfoModelWithDict:[responseObject objectForKey:@"data"]];
//
//            /** 存储用户信息模型 */
//            [WJAccessTool saveUserInfo];
//
//        } error:^(id error) {
//
//        } failure:^(NSError *error) {
//
//        }];
    }];
}

@end
