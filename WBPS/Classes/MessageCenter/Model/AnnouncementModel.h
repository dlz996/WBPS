//
//  AnnouncementModel.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/16.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnouncementModel : NSObject

/** 通知时间 */
@property (nonatomic,copy)NSString * noticedate;
/** 通知的id */
@property (nonatomic,copy)NSString * id;
/** 通知的图片 */
@property (nonatomic,copy)NSString * noticeimg;
/** 点击通知的链接 */
@property (nonatomic,copy)NSString * noticeurl;
/**  */
@property (nonatomic,copy)NSString * RecordCount;
/** 通知标题 */
@property (nonatomic,copy)NSString * noticetitle;
/** 通知文本内容 */
@property (nonatomic,copy)NSString * noticecontent;
/**  */
@property (nonatomic,copy)NSString * PageCount;

@end
