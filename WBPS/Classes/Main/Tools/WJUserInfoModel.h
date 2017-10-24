//
//  WJUserInfoModel.h
//  Borderless
//
//  Created by Mr_怪蜀黍 on 16/11/21.
//  Copyright © 2016年 LW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJUserInfoModel : NSObject<NSCoding>

/** 用户信息 */
+ (instancetype)sharedUserInfo;
/** 设置用户信息 */
+ (void)setUserInfoModelWithDict:(NSDictionary *)dict;

+(void)setTeacherInfoWithDict:(NSMutableDictionary *)dict;
/** 用户识别码 */
@property (nonatomic, copy) NSString *accessToken;
/** 支付宝账号 */
@property (nonatomic, copy) NSString *alipayAccount;
/** 余额，单位为本国货币 */
@property (nonatomic, copy) NSString *balance;
/** 当前国家与美元的货币转换率 */
@property (nonatomic, copy) NSString *coinRate;
/** paypal账户，为空则是未绑定 */
@property (nonatomic, copy) NSString *paypalAccount;

/** 老师Id，当只有学生角色时，为0 */
@property (nonatomic, copy) NSString *teacherId;
/** 时区 */
@property (nonatomic, copy) NSString *timeZone;
/** 如果为0 则为未选择货币类型 */
@property (nonatomic, copy) NSString *subUserId;
/** 货币类型  1人民币  2美金*/
@property (nonatomic, copy) NSString *currencyType;
/** 时区名 */
@property (nonatomic, copy) NSString *timeZoneName;
/** 头像 */
@property (nonatomic, copy) NSString *userAvatarUrl;
/** 昵称 */
@property (nonatomic, copy) NSString *userNickname;
/** 1为男，2为女 */
@property (nonatomic, copy) NSString* userSex;
/** 收入 */
@property (nonatomic, copy) NSString* totalHarvestValue;
/** 用户ID */
@property (nonatomic, copy) NSString* userId;
/** 手机账号 */
@property (nonatomic , copy)NSString *userPhone;
/** 邮箱账号 */
@property (nonatomic , copy)NSString *userMail;
/**语言 图片 */
@property (nonatomic , copy)NSString *languageUrl;
/** 密码 */
@property (nonatomic, copy) NSString *userPassword;
/** 环信登录密码  登录账户为 手机号 */
@property (nonatomic, copy) NSString *easemobPwd;
/** 切换Id,Tab为 1时切换到学生端，2时切换到教室端，3时我要逛逛 */
@property (nonatomic, copy) NSString *tab;
/** 环信登录密码  登录账户为 手机号 */
@property (nonatomic, copy) NSString *switchStatus;
/**是否推广*/
@property (nonatomic, assign) BOOL isPromotion;

/****************教师*******************/

/** 老师对象，只有当teacherId不为空时，才会返回老师对象 */
@property (nonatomic, strong) NSMutableDictionary *teacher;

/** 教师是否在线 */
@property (nonatomic, assign) BOOL isOnline;

/** 用户是否登录 */
@property (nonatomic, assign) BOOL isLogin;

@end
