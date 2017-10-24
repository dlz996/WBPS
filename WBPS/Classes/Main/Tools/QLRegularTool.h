//
//  QLRegularTool.h
//  QiongLiao
//
//  Created by appleKaiFa on 15/9/17.
//  Copyright (c) 2015年 XQBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLRegularTool : NSObject
/** 银行卡号验证 */
+(BOOL)isValidateCreditCard:(NSString *)cardNo;

/*邮箱验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateEmail:(NSString *)email;

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateMobile:(NSString *)mobile;

/*车牌号验证 MODIFIED BY HELENSONG*/
+(BOOL)validateCarNo:(NSString *)carNo;

/*数字验证*/
+(BOOL)isValidateNum:(NSString *)number;

/*用户名验证*/
+(BOOL)isValidateLoginNum:(NSString *)loginNum;

/*密码验证*/
+(BOOL)isValidatePassword:(NSString *)passWord;

/*验证联通号码*/
+(BOOL)isValidateUnionNumber:(NSString *)number;

/*大写字母验证*/
+(BOOL)isValidateUpAlphabet:(NSString *)alphabet;

/*小写字母验证*/
+(BOOL)isValidateLowAlphabet:(NSString *)alphabet;

/*中英文字母、数字和下划线*/
+ (BOOL) isValidateCnDigitEn_:(NSString *)string;

/*英文字母、数字*/
+(BOOL)isValidateDigitEn:(NSString *)ch;

/*中文*/
+(BOOL) isChinese:(NSString *)string;

/*国内电话号码*/
+(BOOL) isChinesePhoneNumber:(NSString *)number;

/*手机号码、国内电话号码 */
+(BOOL) isChineseMobileAndPhoneNumber:(NSString *)number;

/*URL*/
+(BOOL) isCorrectURL:(NSString *)url;

/*URL  商品详情页的URL*/
+(BOOL) isProductURL:(NSString *)url;

/*IDcard (15或18位)*/
+(BOOL)isIDcardNumber:(NSString *)IDNumber;

/*第二代身份证号18位*/
+(BOOL)isTheSecond_generationIDCard:(NSString *)IDNumber;

/*15位身份证号*/
+(BOOL)isOldIDCard:(NSString *)IDNumber;

/*英文字母、数字和下划线*/
+(BOOL)isLettersDigitEn_:(NSString *)string;

/**判断字符串是否是整型*/
+(BOOL)isPureInt:(NSString*)string;

/*计算字符串的size*/
+(CGSize)convertToString:(NSString*)string stringFont:(CGFloat)font wide:(CGFloat)wide high:(CGFloat)high;

/**按要求截取字符串*/
+(NSString *)stringAtIndexByCount:(NSString *)string withCount:(NSInteger)count;

/**计算中英混合字符串的长度*/
+ (NSInteger)getToInt:(NSString*)strtemp;

//判断是否有emoji
+ (BOOL)stringContainsEmoji:(NSString *)string;


@end
