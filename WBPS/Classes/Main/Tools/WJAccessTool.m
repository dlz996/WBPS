//
//  WJAccessTool.m
//  Borderless
//
//  Created by Mr_怪蜀黍 on 16/11/21.
//  Copyright © 2016年 LW. All rights reserved.
//

#import "WJAccessTool.h"

@implementation WJAccessTool
+ (void)saveUserInfo {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *userInfoPath = [path stringByAppendingPathComponent:@"userInfo.data"];
    
//    [NSKeyedArchiver archiveRootObject:[FDUserModel sharedUserInfo] toFile:userInfoPath];
}
+ (void)loadUserInfo {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *userInfoPath = [path stringByAppendingPathComponent:@"userInfo.data"];
    /** 读取信息 */
//    FDUserModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:userInfoPath];
//
//    [FDUserModel sharedUserInfo].accessToken = model.accessToken;
//    [FDUserModel sharedUserInfo].userId = model.userId;
//    [FDUserModel sharedUserInfo].skill = model.skill;
//    [FDUserModel sharedUserInfo].profession = model.profession;
//    [FDUserModel sharedUserInfo].avatarUrl = model.avatarUrl;
//    [FDUserModel sharedUserInfo].nickname = model.nickname;
//    [FDUserModel sharedUserInfo].weChatAccount = model.weChatAccount;
//    [FDUserModel sharedUserInfo].alipayAccount = model.alipayAccount;
//    [FDUserModel sharedUserInfo].mail = model.mail;
//    [FDUserModel sharedUserInfo].workExper = model.workExper;
//    [FDUserModel sharedUserInfo].balance = model.balance;
//    [FDUserModel sharedUserInfo].isCertification = model.isCertification;
//    [FDUserModel sharedUserInfo].gender = model.gender;
//    [FDUserModel sharedUserInfo].birthday = model.birthday;
//    [FDUserModel sharedUserInfo].idCertificateUrl = model.idCertificateUrl;
//    [FDUserModel sharedUserInfo].idNumber = model.idNumber;
//    [FDUserModel sharedUserInfo].userName = model.userName;
//    [FDUserModel sharedUserInfo].surname = model.surname;
//    [FDUserModel sharedUserInfo].password = model.password;
//    [FDUserModel sharedUserInfo].phone = model.phone;
//    [FDUserModel sharedUserInfo].signature = model.signature;
//    [FDUserModel sharedUserInfo].longitude = model.longitude;
//    [FDUserModel sharedUserInfo].latitude = model.latitude;
//    [FDUserModel sharedUserInfo].distance = model.distance;
//    [FDUserModel sharedUserInfo].serveScore = model.serveScore;
//    [FDUserModel sharedUserInfo].dynamicCount = model.dynamicCount;
//    [FDUserModel sharedUserInfo].attentionCount = model.attentionCount;
//    [FDUserModel sharedUserInfo].fansCount = model.fansCount;
//    [FDUserModel sharedUserInfo].myCity = model.myCity;
//    [FDUserModel sharedUserInfo].isHashCar = model.isHashCar;
//    [FDUserModel sharedUserInfo].unWithdrawBalance = model.unWithdrawBalance;
//     [FDUserModel sharedUserInfo].totalCount = model.totalCount;
//     [FDUserModel sharedUserInfo].commentCount = model.commentCount;
}

+ (void)saveIntgerValueWith:(NSInteger)value key:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
}

+ (NSInteger)loadIntgerValueWithKey:(NSString *)key {
    return  [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

@end
