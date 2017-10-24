//
//  TaskInfoModel.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/10.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskInfoModel : NSObject

/** 回单要求 */
@property (nonatomic,copy)NSString * backqty;

/*  -------到货地信息----- */
/** 到货地省份 */
@property (nonatomic,copy)NSString * esheng;
/** 到货地城市 */
@property (nonatomic,copy)NSString * ecity;
/** 到货地区县 */
@property (nonatomic,copy)NSString * earea;
/** 到货地乡镇街道 */
@property (nonatomic,copy)NSString * etown;
/** 到货地详细地址 */
@property (nonatomic,copy)NSString * eaddress;
/** 到货地经度 */
@property (nonatomic,copy)NSString * elng;
/** 到货地纬度 */
@property (nonatomic,copy)NSString * elat;

/* -----接货地信息----- */
/** 接货地省份 */
@property (nonatomic,copy)NSString * bsheng;
/** 接货地城市 */
@property (nonatomic,copy)NSString * bcity;
/** 接货地区县 */
@property (nonatomic,copy)NSString * barea;
/** 接货地乡镇街道 */
@property (nonatomic,copy)NSString * btown;
/** 接货地详细地址 */
@property (nonatomic,copy)NSString * baddress;
/** 接货地经度 */
@property (nonatomic,copy)NSString * blng;
/** 接货地纬度 */
@property (nonatomic,copy)NSString * blat;


/** 运单号 */
@property (nonatomic,copy)NSString * unit;
/** 客户电话 */
@property (nonatomic,copy)NSString * consigneemb;
/** 提付款 */
@property (nonatomic,copy)NSString * accarrived;
/** 代收款 */
@property (nonatomic,copy)NSString * accdaishou;
/** 客户名称 */
@property (nonatomic,copy)NSString * consignee;
/** 标识列 */
@property (nonatomic,copy)NSString * id;
/** 备注说明 */
@property (nonatomic,copy)NSString * remark;
/** PC签收状态 */
@property (nonatomic,copy)NSString * tmsqs;
/** 加急 */
@property (nonatomic,copy)NSString * urgent;
/** 签收时间 */
@property (nonatomic,copy)NSString * qsdate;
/** 预约到达时间 */
@property (nonatomic,copy)NSString * downdate;
/** 订单金额 */
@property (nonatomic,copy)NSString * account;
/** 承运网点 */
@property (nonatomic,copy)NSString * outcyweb;
/** 货物名称 */
@property (nonatomic,copy)NSString * product;
/** 用作关联的唯一标识 */
@property (nonatomic,copy)NSString * gid;
/** 顺序号 */
@property (nonatomic,copy)NSString * rowid;
/** 件数 */
@property (nonatomic,copy)NSString * qty;
/** 订单签收图片编号 */
@property (nonatomic,copy)NSString * imagepid;
/** 主表的ID */
@property (nonatomic,copy)NSString * mainid;
/** 签收人身份证号 */
@property (nonatomic,copy)NSString * qsmancode;
/** 带人卸货 */
@property (nonatomic,copy)NSString * unload;
/** 签收人 */
@property (nonatomic,copy)NSString * qsman;
/** 支付状态 */
@property (nonatomic,copy)NSString * fktype;
/** 体积 */
@property (nonatomic,copy)NSString * volumn;
/** 上楼 */
@property (nonatomic,copy)NSString * upstairs;
/** 承运公司 */
@property (nonatomic,copy)NSString * outcygs;
/** 包装 */
@property (nonatomic,copy)NSString * packages;
/** 订单状态 */
@property (nonatomic,copy)NSString * orderstate;
/** 重量 */
@property (nonatomic,copy)NSString * weight;
/** 订单号 */
@property (nonatomic,copy)NSString * orderno;
/** 公里数 */
@property (nonatomic,copy)NSString * gls;


@end
