//
//  UserModel.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/9.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>

/** 用户信息 */
+ (instancetype)sharedUserInfo;
/** 设置用户信息 */
+ (void)setUserInfoModelWithDict:(NSDictionary *)dict;

/**  公司ID*/
@property (nonatomic,copy) NSString * companyid;

@property (nonatomic,copy) NSString * lastpointdate;
/** 账户余额 */
@property (nonatomic,copy) NSString * CapitalAccount;
/** 汽车品牌 */
@property (nonatomic,copy) NSString * vehiclebrand;
/** 密码 */
@property (nonatomic,copy) NSString * pwd;
/** 标识ID */
@property (nonatomic,copy) NSString * id;
/** 用户ID */
@property (nonatomic,copy) NSString * userid;
/** 用户token */
@property (nonatomic,copy) NSString * token;
/** 用户姓名 */
@property (nonatomic,copy) NSString * username;
/** 用户手机号 */
@property (nonatomic,copy) NSString * usermb;
/** 用户头像链接路径 */
@property (nonatomic,copy) NSString * headimepath;
/** 用户类型 */
@property (nonatomic,copy) NSString * usertype;
/** 审核状态 */
@property (nonatomic,copy) NSString * checkstate;

/** 服务评分 */
@property (nonatomic,copy)NSString * score;
/** 总里程数 */
@property (nonatomic,copy)NSString * glssum;
/** 接单总数 */
@property (nonatomic,copy)NSString * fetchcount;

/** 经度 */
@property (nonatomic,copy) NSString * lng;
/** 维度 */
@property (nonatomic,copy) NSString * lat;
/** 审核不通过原因 */
@property (nonatomic,copy) NSString * checkremark;
/** 车辆识别证号 */
@property (nonatomic,copy) NSString * clsbzcode;
/** 行驶证号 */
@property (nonatomic,copy) NSString * xszcode;
/** 营运证号 */
@property (nonatomic,copy) NSString * yycode;
/** 车号 */
@property (nonatomic,copy) NSString * vehicleno;
/** 用户身份证号 */
@property (nonatomic,copy) NSString * idcode;

/** 驾驶证 */
@property (nonatomic,copy) NSString * jszcode;
/** 所属省 */
@property (nonatomic,copy) NSString * sheng;
/** 所属城市 */
@property (nonatomic,copy) NSString * city;
/** 所属城区 */
@property (nonatomic,copy) NSString * area;
/** 地址门牌号 */
@property (nonatomic,copy) NSString * addr;
/** 配送范围 */
@property (nonatomic,copy) NSString * earea;

/** 车辆现在状态 */
@property (nonatomic,copy) NSString * loadstate;

/** 剩余可盛放体积 */
@property (nonatomic,copy) NSString * freevolumn;
/** 可盛放体积 */
@property (nonatomic,copy) NSString * volumn;
/** 车辆载重 */
@property (nonatomic,copy) NSString * weight;
/** 车辆剩余载重 */
@property (nonatomic,copy) NSString * freeweight;
/** 车型ID */
@property (nonatomic,copy) NSString * vehicletypeid;
/** 接专车单 */
@property (nonatomic,copy) NSString * zc;
/** 接拼车单 */
@property (nonatomic,copy) NSString * pc;
/** 运输类型 */
@property (nonatomic,copy) NSString * ystype;
/** 接单范围公里数 */
@property (nonatomic,copy) NSString * gls;
/** 驾驶证截止期 */
@property (nonatomic,copy) NSString * jszenddate;

/**  */
@property (nonatomic,copy) NSString * gid;

/** 查询用户的ID */
@property (nonatomic,copy) NSString * imagepid;


@property (nonatomic,copy) NSString * town;
@property (nonatomic,copy) NSString * id1;
@property (nonatomic,copy) NSString * lastdate;
@property (nonatomic,copy) NSString * WTTXAccount;
@property (nonatomic,copy) NSString * chaufferstate;
@property (nonatomic,copy) NSString * parentid;
@property (nonatomic,copy) NSString * gid1;

@end
