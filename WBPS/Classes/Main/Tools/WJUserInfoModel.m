//
//  WJUserInfoModel.m
//  Borderless
//
//  Created by Mr_怪蜀黍 on 16/11/21.
//  Copyright © 2016年 LW. All rights reserved.
//

#import "WJUserInfoModel.h"

@implementation WJUserInfoModel
+ (instancetype)sharedUserInfo {
    static WJUserInfoModel *userInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[WJUserInfoModel alloc] init];
    });
    return userInfo;
}

+ (void)setUserInfoModelWithDict:(NSDictionary *)dict{
    if (dict == nil){
        return;
    }
    if ([dict objectForKey:@"accessToken"]){
        [WJUserInfoModel sharedUserInfo].accessToken =[NSString stringWithFormat:@"%@",[dict objectForKey:@"accessToken"]];
    }
    if ([dict objectForKey:@"alipayAccount"]){
        [WJUserInfoModel sharedUserInfo].alipayAccount =[NSString stringWithFormat:@"%@",[dict objectForKey:@"alipayAccount"]];
    }
    if ([dict objectForKey:@"balance"]){
        [WJUserInfoModel sharedUserInfo].balance =[NSString stringWithFormat:@"%@",[dict objectForKey:@"balance"]];
    }
    
    if ([dict objectForKey:@"coinRate"]){
        [WJUserInfoModel sharedUserInfo].coinRate = [NSString stringWithFormat:@"%@",[dict objectForKey:@"coinRate"]];
    }
    if ([dict objectForKey:@"totalHarvestValue"]){
        [WJUserInfoModel sharedUserInfo].totalHarvestValue = [NSString stringWithFormat:@"%@",[dict objectForKey:@"totalHarvestValue"]];
    }
    if ([dict objectForKey:@"paypalAccount"]){
        [WJUserInfoModel sharedUserInfo].paypalAccount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"paypalAccount"]];
    }
    if ([dict objectForKey:@"teacher"]){
        [WJUserInfoModel sharedUserInfo].teacher = [dict objectForKey:@"teacher"];
    }
    if ([dict objectForKey:@"teacherId"]){
        [WJUserInfoModel sharedUserInfo].teacherId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"teacherId"]];
    }
    if ([dict objectForKey:@"timeZone"]){
        [WJUserInfoModel sharedUserInfo].timeZone = [NSString stringWithFormat:@"%@",[dict objectForKey:@"timeZone"]];
    }
    if ([dict objectForKey:@"userAvatarUrl"]){
        [WJUserInfoModel sharedUserInfo].userAvatarUrl =[NSString stringWithFormat:@"%@",[dict objectForKey:@"userAvatarUrl"]];
    }
    if ([dict objectForKey:@"userNickname"]){
        [WJUserInfoModel sharedUserInfo].userNickname = [NSString stringWithFormat:@"%@",[dict objectForKey:@"userNickname"]];
    }
    if ([dict objectForKey:@"userSex"]){
        [WJUserInfoModel sharedUserInfo].userSex = [NSString stringWithFormat:@"%@",[dict objectForKey:@"userSex"]];
    }
    if ([dict objectForKey:@"userPhone"]){
        [WJUserInfoModel sharedUserInfo].userPhone = [NSString stringWithFormat:@"%@",[dict objectForKey:@"userPhone"]];
    }
    if ([dict objectForKey:@"userPassword"]){
        [WJUserInfoModel sharedUserInfo].userPassword = [NSString stringWithFormat:@"%@",[dict objectForKey:@"userPassword"]];
    }
    if ([dict objectForKey:@"tab"]){
        [WJUserInfoModel sharedUserInfo].tab = [NSString stringWithFormat:@"%@",[dict objectForKey:@"tab"]];
    }
    if ([dict objectForKey:@"easemobPwd"]){
        [WJUserInfoModel sharedUserInfo].easemobPwd = [NSString stringWithFormat:@"%@",[dict objectForKey:@"easemobPwd"]];
    }
    if ([dict objectForKey:@"userId"]){
        [WJUserInfoModel sharedUserInfo].userId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"userId"]];
    }

    if ([dict objectForKey:@"languageUrl"]){
        [WJUserInfoModel sharedUserInfo].languageUrl =[NSString stringWithFormat:@"%@" ,[dict objectForKey:@"languageUrl"]];
    }
    if ([dict objectForKey:@"timeZoneName"]){
        [WJUserInfoModel sharedUserInfo].timeZoneName = [NSString stringWithFormat:@"%@",[dict objectForKey:@"timeZoneName"]];
    }
    
    if ([dict objectForKey:@"userMail"]){
        [WJUserInfoModel sharedUserInfo].userMail = [NSString stringWithFormat:@"%@",[dict objectForKey:@"userMail"]];
    }
    
    if ([dict objectForKey:@"currencyType"]){
        [WJUserInfoModel sharedUserInfo].currencyType = [NSString stringWithFormat:@"%@",[dict objectForKey:@"currencyType"]];
    }
    
    if ([dict objectForKey:@"subUserId"]){
        [WJUserInfoModel sharedUserInfo].subUserId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"subUserId"]];
    }
    if ([dict objectForKey:@"switchStatus"]){
        [WJUserInfoModel sharedUserInfo].switchStatus = [NSString stringWithFormat:@"%@",[dict objectForKey:@"switchStatus"]];
    }
    
    if ([dict objectForKey:@"isLogin"]){
        [WJUserInfoModel sharedUserInfo].isLogin = [dict objectForKey:@"isLogin"];
    }

    if ([dict objectForKey:@"isOnline"]){
        [WJUserInfoModel sharedUserInfo].isOnline = [dict objectForKey:@"isOnline"];
    }
    
    if ([dict objectForKey:@"isPromotion"]){
        [WJUserInfoModel sharedUserInfo].isPromotion = [dict objectForKey:@"isPromotion"];
    }
}


- (id)initWithCoder:(NSCoder *)deCoder {
    if (self = [super init]) {
        self.accessToken = [deCoder decodeObjectForKey:@"accessToken"];
        self.alipayAccount = [deCoder decodeObjectForKey:@"alipayAccount"];
        self.balance = [deCoder decodeObjectForKey:@"balance"];
        self.coinRate = [deCoder decodeObjectForKey:@"coinRate"];
        self.paypalAccount = [deCoder decodeObjectForKey:@"paypalAccount"];
        self.teacher = [deCoder decodeObjectForKey:@"teacher"];
        self.teacherId = [deCoder decodeObjectForKey:@"teacherId"];
        self.timeZone = [deCoder decodeObjectForKey:@"timeZone"];
        self.timeZoneName = [deCoder decodeObjectForKey:@"timeZoneName"];
        self.userAvatarUrl = [deCoder decodeObjectForKey:@"userAvatarUrl"];
        self.userNickname = [deCoder decodeObjectForKey:@"userNickname"];
        self.userSex = [deCoder decodeObjectForKey:@"userSex"];
        self.userPhone = [deCoder decodeObjectForKey:@"userPhone"];
        self.userMail = [deCoder decodeObjectForKey:@"userMail"];
        self.userPassword = [deCoder decodeObjectForKey:@"userPassword"];
        self.tab = [deCoder decodeObjectForKey:@"tab"];
        self.easemobPwd = [deCoder decodeObjectForKey:@"easemobPwd"];
        self.userId = [deCoder decodeObjectForKey:@"userId"];
        self.isOnline = [deCoder decodeBoolForKey:@"isOnline"];
        self.languageUrl = [deCoder decodeObjectForKey:@"languageUrl"];
        self.totalHarvestValue = [deCoder decodeObjectForKey:@"totalHarvestValue"];
        self.switchStatus = [deCoder decodeObjectForKey:@"switchStatus"];
        self.currencyType = [deCoder decodeObjectForKey:@"currencyType"];
        self.subUserId = [deCoder decodeObjectForKey:@"subUserId"];
        self.isLogin = [deCoder decodeBoolForKey:@"isLogin"];
        self.isPromotion = [deCoder decodeBoolForKey:@"isPromotion"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)enCoder {
    [enCoder encodeObject:_accessToken forKey:@"accessToken"];
    [enCoder encodeObject:_alipayAccount forKey:@"alipayAccount"];
    [enCoder encodeObject:_balance forKey:@"balance"];
    [enCoder encodeObject:_coinRate forKey:@"coinRate"];
    [enCoder encodeObject:_paypalAccount forKey:@"paypalAccount"];
    [enCoder encodeObject:_totalHarvestValue forKey:@"totalHarvestValue"];
    [enCoder encodeObject:_teacher forKey:@"teacher"];
    [enCoder encodeObject:_teacherId forKey:@"teacherId"];
    [enCoder encodeObject:_timeZone forKey:@"timeZone"];
    [enCoder encodeObject:_timeZoneName forKey:@"timeZoneName"];
    [enCoder encodeObject:_userAvatarUrl forKey:@"userAvatarUrl"];
    [enCoder encodeObject:_userNickname forKey:@"userNickname"];
    [enCoder encodeObject:_userSex forKey:@"userSex"];
    [enCoder encodeObject:_userPhone forKey:@"userPhone"];
    [enCoder encodeObject:_userMail forKey:@"userMail"];
    [enCoder encodeObject:_userPassword forKey:@"userPassword"];
    [enCoder encodeObject:_tab forKey:@"tab"];
    [enCoder encodeObject:_easemobPwd forKey:@"easemobPwd"];
    [enCoder encodeObject:_userId forKey:@"userId"];
    [enCoder encodeObject:_currencyType forKey:@"currencyType"];
    [enCoder encodeObject:_subUserId forKey:@"subUserId"];
    [enCoder encodeObject:_switchStatus forKey:@"switchStatus"];
    [enCoder encodeBool:_isOnline forKey:@"isOnline"];
    [enCoder encodeObject:_languageUrl forKey:@"languageUrl"];
    [enCoder encodeBool:_isLogin forKey:@"isLogin"];
    [enCoder encodeBool:_isPromotion forKey:@"isPromotion"];
}


+(void)setTeacherInfoWithDict:(NSMutableDictionary *)dict
{
    [WJUserInfoModel sharedUserInfo].teacher = dict;
}

@end
