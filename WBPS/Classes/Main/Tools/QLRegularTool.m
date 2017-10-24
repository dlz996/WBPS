//
//  QLRegularTool.m
//  QiongLiao
//
//  Created by appleKaiFa on 15/9/17.
//  Copyright (c) 2015年 XQBoy. All rights reserved.
//

#import "QLRegularTool.h"

@implementation QLRegularTool

+ (BOOL)isValidateCreditCard:(NSString *)cardNo {
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;  
    if((allsum % 10) == 0)  
        return YES;  
    else  
        return NO;
}

/*邮箱验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateMobile:(NSString *)mobile{
    //手机号以11，12，13，14，15，17，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((11[0,0-9])|(12[0,0-9])|(13[0-9])|(14[0,0-9])|(15[^4,\\D])|(17[0,0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


/*车牌号验证 MODIFIED BY HELENSONG*/
+(BOOL)validateCarNo:(NSString *)carNo{

    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    
//    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
//    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    
    return [carTest evaluateWithObject:carNo];
}


/*数字验证*/
+(BOOL)isValidateNum:(NSString *)number{
    NSString *numRegex = @"^[0-9]*$";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numRegex];
    return [numTest evaluateWithObject:number];
}


/*用户名验证*/
+(BOOL)isValidateLoginNum:(NSString *)loginNum{
    NSString *num = @"^[A-Z][A-Z0-9_]{0,19}$";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",num];
    return [numTest evaluateWithObject:loginNum];
}


/*密码验证 包含（大小写字母、数字、下划线以及特殊符号）*/
+(BOOL)isValidatePassword:(NSString *)passWord{
    NSString *word = @"^[A-Za-z0-9_]+$";
    NSPredicate *wordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",word];
    return [wordTest evaluateWithObject:passWord];
}


/*验证联通号码*/
+(BOOL)isValidateUnionNumber:(NSString *)number{
    NSString *num = @"^1(3[0-2]|4[5]|5[56]|8[56])\\d{8}$";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",num];
    return [numTest evaluateWithObject:number];
}


/*大写字母验证*/
+(BOOL)isValidateUpAlphabet:(NSString *)alphabet{
    NSString *alph = @"^[A-Z]+$";
    NSPredicate *alphTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",alph];
    return [alphTest evaluateWithObject:alphabet];
}


/*小写字母验证*/
+(BOOL)isValidateLowAlphabet:(NSString *)alphabet{
    NSString *alph = @"^[a-z]+$";
    NSPredicate *alphTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",alph];
    return [alphTest evaluateWithObject:alphabet];
}


/*中英文字母、数字和下划线*/
+(BOOL)isValidateCnDigitEn_:(NSString *)string{
    NSString * regularExpression = @"^[\\u4e00-\\u9fa5A-Za-z0-9_]+$";
    NSPredicate * testPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularExpression];
    return [testPredicate evaluateWithObject:string];
}


/*英文字母、数字*/
+(BOOL)isValidateDigitEn:(NSString *)ch{
    NSString *sym = @"^[A-Za-z0-9]+$";
    NSPredicate *symTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",sym];
    return [symTest evaluateWithObject:ch];
}


/*中文*/
+(BOOL)isChinese:(NSString *)string{
    NSString * regExp = @"^[\\u4e00-\\u9fa5]+$";
    NSPredicate * testPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExp];
    return [testPredicate evaluateWithObject:string];
}


/*国内电话号码*/
+(BOOL)isChinesePhoneNumber:(NSString *)number{
    NSString * regExp = @"^(\\d{3,4}-\\d{7,8}(-\\d{3,4})?$";
    NSPredicate * testPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExp];
    return [testPredicate evaluateWithObject:number];
}


/*手机号码、国内电话号码*/
+(BOOL)isChineseMobileAndPhoneNumber:(NSString *)number{
    NSString * regularExpression = @"^(\\d{3,4}-\\d{7,8}(-\\d{1,4})?)|(1[1,2,3,4,5,7,8]\\d{9})$";
    NSPredicate * testPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularExpression];
    return [testPredicate evaluateWithObject:number];
}


/*URL  http 协议的URL*/
+(BOOL) isCorrectURL:(NSString *)url{
    NSString * regExp = @"^http://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?";
    NSPredicate * testPrdct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExp];
    return [testPrdct evaluateWithObject:url];
}

/*URL  商品详情页的URL*/
+(BOOL) isProductURL:(NSString *)url{
    NSString * regExp = @"^http://(buy|shop).ccb.com/products/(\\w+)_(\\d+)?\\.jhtml(.*)?";
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExp];
    return [predicate evaluateWithObject:url];
}

/*兼容15 18位身份证号*/
+(BOOL)isIDcardNumber:(NSString *)IDNumber{
    NSString * regExp = @"^([1-9]\\d{5}(19|20)\\d{2}((0[1-9])|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}(\\d|x|X))|([1-9]\\d{5}\\d{2}((0[1-9])|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3})$";
    NSPredicate * testPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExp];
    return [testPredicate evaluateWithObject:IDNumber];
}


/*15位身份证号*/
+(BOOL)isOldIDCard:(NSString *)IDNumber{
    NSString * regExp = @"^([1-9]\\d{5}\\d{2}((0[1-9])|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3})$";
    NSPredicate * testPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHS %@",regExp];
    return [testPredicate evaluateWithObject:IDNumber];
}


/*18位身份证号*/
+(BOOL)isTheSecond_generationIDCard:(NSString *)IDNumber{
    NSString * regExp = @"^([1-9]\\d{5}(19|20)\\d{2}((0[1-9])|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}(\\d|x|X))$";
    NSPredicate * testPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHS %@",regExp];
    return [testPredicate evaluateWithObject:IDNumber];
}


/*英文字母、数字和下划线*/
+(BOOL)isLettersDigitEn_:(NSString *)string{
    NSString * regularExpression = @"^[A-Za-z0-9_]+$";
    NSPredicate * testPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularExpression];
    return [testPredicate evaluateWithObject:string];
}

/**判断字符串是否是整型*/
+(BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}

/**计算中英混合字符串的长度*/
+ (NSInteger)getToInt:(NSString*)strtemp
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [strtemp dataUsingEncoding:enc];
    return [da length];
}

/**计算字符串的size*/
+(CGSize)convertToString:(NSString*)string stringFont:(CGFloat)font wide:(CGFloat)wide high:(CGFloat)high
{
    /*
     第一种计算方式
     
    CGSize titleSize = [string boundingRectWithSize:CGSizeMake(wide, high) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return titleSize;
    */
    
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSRange allRange = [string rangeOfString:string];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:font]
                    range:allRange];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor blackColor]
                    range:allRange];
    

    CGSize size;
    
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(wide, high)
                                        options:options
                                        context:nil];
    rect.size.height+=2;// 加两个像素,防止emoji被切掉.
    size = rect.size;
    return size;
}

/**按要求截取字符串*/
+(NSString *)stringAtIndexByCount:(NSString *)string withCount:(NSInteger)count
{
    int i;
    int sum=0;
    for(i=0;i<[string length];i++)
    {
        unichar str = [string characterAtIndex:i];
        if(str < 256){
            sum+=1;
        }else {
            sum+=2;
        }
        if(sum>count){
            //当字符大于count时，剪取三个位置，显示省略号。否则正常显示
            NSString * str=[string substringWithRange:NSMakeRange(0,[self charAtIndexByCount:string withCount:count-2])];
            
            return [NSString stringWithFormat:@"%@..",str];
        }
    }
    return string;
}

//超过count时，截取字符
+(NSInteger)charAtIndexByCount:(NSString *)string withCount:(NSInteger)count
{
    int i;
    int sum=0;
    int count2=0;
    for(i=0;i<[string length];i++){
        unichar str = [string characterAtIndex:i];
        if(str < 256){
            sum+=1;
        }else {
            sum+=2;
        }
        count2++;
        if (sum>=count){
            break;
        }
    }
    if(sum>count){
        return count2-1;
    }
    else
        return count2;
}

//判断是否有emoji
+(BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar high = [substring characterAtIndex: 0];
                                
                                if (0xD800 <= high && high <= 0xDBFF) {
                                    const unichar low = [substring characterAtIndex: 1];
                                    const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                    
                                    if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                        returnValue = YES;
                                    }
                                    
                                    // Not surrogate pair (U+2100-27BF)
                                } else {
                                    if (0x2100 <= high && high <= 0x27BF){
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}


@end
