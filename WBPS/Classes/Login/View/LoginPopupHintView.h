//
//  LoginPopupHintView.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/27.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginPoPupHintViewDelegate;

@protocol LoginPoPupHintViewDelegate <NSObject>

/**
     确定选择图片
 */
- (void)confirmSelectPhoto;

@end

@interface LoginPopupHintView : UIView

/**
 传入类型
 0 身份证
 1 驾驶证
 2 行驶证
 3 运营证
 */
@property (nonatomic,assign)NSInteger type;

@property (nonatomic,weak)id <LoginPoPupHintViewDelegate> delegate;

@end
