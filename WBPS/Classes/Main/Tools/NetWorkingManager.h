//
//  NetWorkingManager.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/21.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "AFHTTPSessionManager.h"

/**
 *  请求成功回调
 */
typedef void(^successBlock)(id responseObject);
/**
 *  请求失败回调
 */
typedef void(^failureBlock)(NSError *error);
/**
 *  请求错误回调
 */
typedef void(^errorBlock)(id error);


@interface NetWorkingManager : AFHTTPSessionManager

/*
 单利控制器
 */
+(NetWorkingManager *)sharedManager;


/**
 *  封装POST请求
 *
 *  @param parameters 请求参数
 *  @param success    请求成功回调方法
 *  @param error      请求错误回调方法
 *  @param failure    请求失败回调方法
 */
- (void)POSTWithParameters:(NSMutableDictionary *)parameters
              success:(successBlock)success
                error:(errorBlock)error
              failure:(failureBlock)failure;


/**
 * 上传用户地理位置到服务器
 *
 * @param parameters 上传参数
 * @param success 请求成功回调
 * @param error 请求错误回调
 * @param failure 请求失败回调
 */
- (void)POSTUserLocationWithParameters:(NSMutableDictionary *)parameters
                               success:(successBlock)success
                                 error:(errorBlock)error
                               failure:(failureBlock)failure;


/**
 *  上传图片
 *
 *  @param imageArray 数据
 */
+ (void)POSTWithImageArray:(NSArray *)imageArray upDic:(NSMutableDictionary *)upDic fileName:(NSString *)serverFile
              success:(successBlock)success
                error:(errorBlock)error
              failure:(failureBlock)failure;


///** 上传多张图片 */
//+ (void)WJPOSTWithImageArrays:(NSMutableArray *)imageArrays upDic:(NSMutableDictionary *)upDic fileNames:(NSMutableArray *)serverFileArray success:(successBlock)success error:(errorBlock)error failure:(failureBlock)failure

/**
 *  拍照后图片旋转
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

/**压缩图片到100k*/
+(NSData *)imageData:(UIImage *)myimage;



/**
 组合一个请求的参数

 @param method 请求是查询数据还是操作数据
 @param proc 拼接URL
 @param pars 参数
 @return 返回一个组合好的字典
 */
+ (NSMutableDictionary *)combinationObj:(NSString *)method proc:(NSString *)proc pars:(NSMutableDictionary *)pars;


/**
 上传图片的数据组合

 @param method 请求类型
 @param proc 拼接的URL
 @param pars 参数
 @param userPhone 手机号码
 @return 组合好的字典
 */
+ (NSMutableDictionary *)combinationObj:(NSString *)method proc:(NSString *)proc pars:(NSMutableDictionary *)pars userPhone:(NSString *)userPhone;


@end
