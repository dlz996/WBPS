//
//  SetingPopupView.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/12.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetingPopupViewDelegate;

@protocol SetingPopupViewDelegate <NSObject>

/**
 点击弹窗页面调用方法
 
 @param index  弹窗的类型   1 接收范围  2 目的地区域 3 异常上报选择
 @param selectString 返回的字符串
 */
- (void)clickSelectButton:(NSInteger)index selectObj:(NSString *)selectString;

@end


@interface SetingPopupView : UIView

@property (nonatomic,weak)id <SetingPopupViewDelegate> delegate;
/**  弹窗的类型  1 接收范围  2 目的地区域 */
@property (nonatomic,assign)NSInteger type;

@end
