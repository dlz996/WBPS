//
//  LoginUpPhotoTableCell.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/26.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginUpPhotoCellDelegate;

@protocol LoginUpPhotoCellDelegate <NSObject>

/**
 点击标题图片调用方法

 @param indexPath   点击Cell的下标
 */
- (void)clickCellTitleImage:(NSIndexPath *)indexPath;

/**
 输入框内值改变后调用的方法

 @param indexPath 改变的TextField的下标
 */
- (void)textFieldValueChange:(NSIndexPath *)indexPath textChange:(NSString *)text;


@end

@interface LoginUpPhotoTableCell : UITableViewCell

@property (nonatomic,weak)id <LoginUpPhotoCellDelegate> delegate;

/** 当前响应的Cell的下标 */
@property (nonatomic,assign)NSIndexPath * indexPath;
/** 证件图片 */
@property (nonatomic,strong)UIImageView * titleImage;
/** 提示标题 */
@property (nonatomic,strong)UILabel * titleLabel;
/** 输入框 */
@property (nonatomic,strong)UITextField * textField;
/** 图片链接 */
@property (nonatomic,copy)NSString * imageUrl;
@end
