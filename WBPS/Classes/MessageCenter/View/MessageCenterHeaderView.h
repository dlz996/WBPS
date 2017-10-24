//
//  MessageCenterHeaderView.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/14.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MessageCenterHeaderDelegate;

@protocol MessageCenterHeaderDelegate <NSObject>

/**
 点击头部按钮调用方法

 @param type 1 公告 2 消息
 */
- (void)changeView:(NSInteger)type;
@end

@interface MessageCenterHeaderView : UIView

@property (nonatomic,weak)id <MessageCenterHeaderDelegate>delegate;
/**
     设置选中按钮   1 公告  2消息
 */
@property (nonatomic,assign)NSInteger type;

@end
