//
//  QLMD5.h
//  QiongLiao
//
//  Created by appleKaiFa on 15/12/29.
//  Copyright © 2015年 XQBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLMD5 : NSObject
/** 根据字符串获取MD5值 */
+ (NSString *)MD5Encrypt:(NSString *)str;
/** 根据NSData获取MD5值 */
+ (NSString*)MD5WithData:(NSData *)data;
+(NSString *) md5: (NSString *) inPutText;
@end
