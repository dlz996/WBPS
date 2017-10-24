//
//  QLMD5.m
//  QiongLiao
//
//  Created by appleKaiFa on 15/12/29.
//  Copyright © 2015年 XQBoy. All rights reserved.
//

#import "QLMD5.h"
#import "CommonCrypto/CommonDigest.h"
@implementation QLMD5
+ (NSString *)MD5Encrypt:(NSString *)str
{
    const char *concat_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, (CC_LONG)strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
    
}

//另一种加密方法,没用到
+(NSString *) md5: (NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}


+ (NSString*)MD5WithData:(NSData *)data{
    
    const char* original_str = (const char *)[data bytes];
    
    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
    
    CC_MD5(original_str, strlen(original_str), digist);
    
    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
    
    for(int  i =0; i<CC_MD5_DIGEST_LENGTH;i++){
        
        [outPutStr appendFormat:@"%02x",digist[i]];// 小写 x 表示输出的是小写 MD5 ，大写 X 表示输出的是大写 MD5
        
    }
    
    
    
    // 也可以定义一个字节数组来接收计算得到的 MD5 值
    
    //    Byte byte[16];
    
    //    CC_MD5(original_str, strlen(original_str), byte);
    
    //    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
    
    //    for(int  i = 0; i<CC_MD5_DIGEST_LENGTH;i++){
    
    //        [outPutStr appendFormat:@"%02x",byte[i]];
    
    //    }
    
    //    [temp release];
    
    
    
    return [outPutStr lowercaseString];
    
    
    
}
@end
