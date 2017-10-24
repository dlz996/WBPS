//
//  CertificateImageModel.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/17.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CertificateImageModel : NSObject
/** 图片类型ID */
@property (nonatomic,copy)NSString * imagetypeid;
/** 图片类型名字 */
@property (nonatomic,copy)NSString * imagetype;
/** 图片gid */
@property (nonatomic,copy)NSString * gid;
/** 图片路径 */
@property (nonatomic,copy)NSString * imagepath;
/** 图片 */
@property (nonatomic,copy)NSString * pid;
/** 上传时间 */
@property (nonatomic,copy)NSString * uploaddate;

@end
