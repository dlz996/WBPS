//
//  CenterHeaderView.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/25.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CenterHeaderDelegate;

@protocol CenterHeaderDelegate <NSObject>

/**
     点击重新认证按钮
 */
- (void)clickAgainButton;

/**
      点击头像调用方法
 */
- (void)selectTitleImage;

@end

/** 个人中心头视图 */
@interface CenterHeaderView : UIView

/** 用户头像 */
@property (nonatomic,strong)UIImageView * userTitleImage;

@property (nonatomic,weak)id <CenterHeaderDelegate> delegate;

/** 设置数据的方法 */
- (void)setData;


@end
