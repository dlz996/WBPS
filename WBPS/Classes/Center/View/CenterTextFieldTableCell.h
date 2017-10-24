//
//  CenterTextFieldTableCell.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/25.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CenterTextFieldTableCellDelegate;

@protocol CenterTextFieldTableCellDelegate<NSObject>

/**
 输入框内值改变后调用的方法
 
 @param indexPath 改变的TextField的下标
 */
- (void)textFieldValueChange:(NSIndexPath *)indexPath textChange:(NSString *)text;

@end

/** 有输入框的Cell */
@interface CenterTextFieldTableCell : UITableViewCell
/** 标题 */
@property (nonatomic,strong)UILabel * titleLabel;
/** 输入内容 */
@property (nonatomic,strong)UITextField * textField;
/** 下标 */
@property (nonatomic,assign)NSIndexPath * cellIndexPath;

@property (nonatomic,weak)id <CenterTextFieldTableCellDelegate> delegate;


@end
