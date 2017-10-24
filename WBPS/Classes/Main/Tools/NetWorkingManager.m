//
//  NetWorkingManager.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/21.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "NetWorkingManager.h"

@implementation NetWorkingManager
#pragma mark --  使用单例、GCD一次创建
+(NetWorkingManager *)sharedManager
{
    
    static NetWorkingManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [NetWorkingManager manager];
        // .设置证书模式
//        NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"lcf.talkmoney.cn" ofType:@"cer"];
//        NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
//
//        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[[NSSet alloc] initWithObjects:cerData, nil]];

        // 客户端是否信任非法证书
//        manager.securityPolicy.allowInvalidCertificates = YES;
        // 是否在证书域字段中验证域名
//        [manager.securityPolicy setValidatesDomainName:NO];
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", nil]];
        
    });
    return manager;
}
/** POST请求 */
-(void)POSTWithParameters:(NSMutableDictionary *)parameters success:(successBlock)success error:(errorBlock)error failure:(failureBlock)failure
{
    [[NetWorkingManager sharedManager] POST:kBaseURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideActivityIndicator];
        NSLog(@"请求成功------>>>>%@",responseObject);
        NSString * resultCode = responseObject[@"result"];
        if ([resultCode isEqualToString:@"0"]) {
            if (success) {
                success(responseObject);
            }
        }else{
            if (error) {
                [MBProgressHUD showError:responseObject[@"msg"]];
                error(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"请求失败,请稍后再试"];
        [MBProgressHUD hideActivityIndicator];
        NSLog(@"请求失败------>>>>%@",error);
        if (failure) { // 请求错误,一处理
            failure(error);
        }
    }];
}
/** 上传用户地理坐标 */
- (void)POSTUserLocationWithParameters:(NSMutableDictionary *)parameters success:(successBlock)success error:(errorBlock)error failure:(failureBlock)failure{
    
    [[NetWorkingManager sharedManager] POST:kBaseURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideActivityIndicator];
        NSLog(@"请求成功------>>>>%@",responseObject);
        NSString * resultCode = responseObject[@"result"];
        if ([resultCode isEqualToString:@"0"]) {
            if (success) {
                success(responseObject);
            }
        }else{
            if (error) {

                error(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSLog(@"请求失败------>>>>%@",error);
        if (failure) { // 请求错误,一处理
            failure(error);
        }
    }];
}

/** 上传单张图片 */
+(void)POSTWithImageArray:(NSArray *)imageArray upDic:(NSMutableDictionary *)upDic fileName:(NSString *)serverFile success:(successBlock)success error:(errorBlock)error failure:(failureBlock)failure
{
    NSLog(@"上传参数---->>>%@",upDic)
    [[NetWorkingManager sharedManager] POST:kBaseURL parameters:upDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组
        for (int i = 0; i < imageArray.count; i++) {
            UIImage *image = imageArray[i];
            NSData *imageData = [self imageData:image];
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:serverFile fileName:fileName mimeType:@"image/jpeg"]; //
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideActivityIndicator];
        NSLog(@"请求成功------>>>>%@",responseObject);
        NSString * resultCode = responseObject[@"result"];
        if ([resultCode isEqualToString:@"0"]) {
            if (success) {
                success(responseObject);
            }
        }else{
            if (error) {
                [MBProgressHUD showError:responseObject[@"msg"]];
                error(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideActivityIndicator];
//        [MBProgressHUD showError:@"请求失败,请稍后再试"];
        if (failure) { // 请求错误,统一处理
            failure(error);
        }
    }];
}
/** 上传多张图片 */
+ (void)WJPOSTWithImageArrays:(NSMutableArray *)imageArrays upDic:(NSMutableDictionary *)upDic fileNames:(NSMutableArray *)serverFileArray success:(successBlock)success error:(errorBlock)error failure:(failureBlock)failure{
    
    
    [[NetWorkingManager sharedManager] POST:kBaseURL  parameters:upDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组
        
        for (int i=0; i<imageArrays.count; i++) {
            UIImage *image = imageArrays[i];
            NSData *imageData = [self imageData:image];
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:serverFileArray[i] fileName:fileName mimeType:@"image/jpeg"]; //
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideActivityIndicator];
        NSNumber *resultCode = responseObject[@"status"];
        if ([resultCode  isEqual:@200]) { // code == 200,请求成功
            if (success) {
                success(responseObject);
            }
        }else {//code != 200,请求失败或者其他状态
            
            [MBProgressHUD showError:responseObject[@"message"]];
            NSLog(@"%@",responseObject[@"message"]);
            if (error) {
                error(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideActivityIndicator];
        [MBProgressHUD showError:@"请求失败,请稍后再试"];
        if (failure) { // 请求错误,统一处理
            failure(error);
        }
    }];
}



//拍照后图片旋转
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

//压缩图片
+(NSData *)imageData:(UIImage *)myimage

{
    NSData *data=UIImageJPEGRepresentation(myimage, 0.1);
    
    if (data.length>100*1024) {
        
        if (data.length>1024*1024) {//1M以及以上
            
            data=UIImageJPEGRepresentation(myimage, 0.1);
            
        }else if (data.length>512*1024) {//0.5M-1M
            
            data=UIImageJPEGRepresentation(myimage, 0.5);
            
        }else if (data.length>200*1024) {//0.25M-0.5M
            
            data=UIImageJPEGRepresentation(myimage, 0.9);
        }
    }
    return data;
    
}
/**
 组合一个请求的参数
 
 @param method 请求是查询数据还是操作数据
 @param proc 拼接URL
 @param pars 参数
 @return 返回一个组合好的字典
 */
+ (NSMutableDictionary *)combinationObj:(NSString *)method proc:(NSString *)proc pars:(NSMutableDictionary *)pars{
    NSArray * ary = [pars allKeys];
    NSString * objAry = @"{\"pars\":[{";
    for (int i=0; i<ary.count; i++) {
        NSString * keyStr = ary[i];
        NSString * key = [NSString stringWithFormat:@"%@%@%@%@",@"\"",keyStr,@"\"",@":"];
        NSString * valueStr = pars[keyStr];
        NSString * value =  [NSString stringWithFormat:@"%@%@%@%@",@"\"",valueStr,@"\"",@","];
        if (i==0) {
            objAry = [objAry stringByReplacingOccurrencesOfString:@"," withString:@""];
        }
        objAry = [NSString stringWithFormat:@"%@%@",objAry,key];
        objAry = [NSString stringWithFormat:@"%@%@",objAry,value];
    }
    objAry = [NSString stringWithFormat:@"%@%@",objAry,@"}],"];
    
    NSString * url = @"\"proc\":\"";
    NSString * urlValue = proc;
    objAry = [NSString stringWithFormat:@"%@%@%@%@",objAry,url,urlValue,@"\","];
    
    NSString * type = @"\"method\":\"";
    NSString * typeValue = method;
    NSString * typeLast = @"\"}";
    objAry = [NSString stringWithFormat:@"%@%@%@%@",objAry,type,typeValue,typeLast];
    NSLog(@"打印拼接后的字符串--->>>%@",objAry);
    
    NSMutableDictionary * returnDic = @{}.mutableCopy;
    [returnDic setObject:objAry forKey:@"pars"];
    return returnDic;
}

/** 数据处理 */
+ (NSMutableDictionary *)combinationObj:(NSString *)method proc:(NSString *)proc pars:(NSMutableDictionary *)pars userPhone:(NSString *)userPhone{
    NSArray * ary = [pars allKeys];
    NSString * objAry = @"{\"pars\":[{";
    for (int i=0; i<ary.count; i++) {
        NSString * keyStr = ary[i];
        NSString * key = [NSString stringWithFormat:@"%@%@%@%@",@"\"",keyStr,@"\"",@":"];
        NSString * valueStr = pars[keyStr];
        NSString * value =  [NSString stringWithFormat:@"%@%@%@%@",@"\"",valueStr,@"\"",@","];
        if (i==0) {
            objAry = [objAry stringByReplacingOccurrencesOfString:@"," withString:@""];
        }
        objAry = [NSString stringWithFormat:@"%@%@",objAry,key];
        objAry = [NSString stringWithFormat:@"%@%@",objAry,value];
    }
    objAry = [NSString stringWithFormat:@"%@%@",objAry,@"}],"];
    
    NSString * url = @"\"proc\":\"";
    NSString * urlValue = proc;
    objAry = [NSString stringWithFormat:@"%@%@%@%@",objAry,url,urlValue,@"\","];
    
    NSString * phone = @"\"usermb\":\"";
    objAry = [NSString stringWithFormat:@"%@%@%@%@",objAry,phone,userPhone,@"\","];
    
    NSString * type = @"\"method\":\"";
    NSString * typeValue = method;
    NSString * typeLast = @"\"}";
    objAry = [NSString stringWithFormat:@"%@%@%@%@",objAry,type,typeValue,typeLast];
    NSLog(@"打印拼接后的字符串--->>>%@",objAry);
    
    NSMutableDictionary * returnDic = @{}.mutableCopy;
    [returnDic setObject:objAry forKey:@"pars"];
    return returnDic;
}


@end
