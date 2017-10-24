//
//  MessageModel.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/16.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

/** 自增ID */
@property (nonatomic,copy)NSString * id;
/** 司机ID */
@property (nonatomic,copy)NSString * userid;
/** 消息标题 */
@property (nonatomic,copy)NSString * msgtitle;
/** 消息时间 */
@property (nonatomic,copy)NSString * msgdate;
/** 消息内容 */
@property (nonatomic,copy)NSString * msgcontent;

@end
