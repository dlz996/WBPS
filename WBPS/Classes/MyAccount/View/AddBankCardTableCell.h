//
//  AddBankCardTableCell.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/28.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddBankCardTableCellDelegate;

@protocol AddBankCardTableCellDelegate <NSObject>

/**
 输入框内值改变后调用的方法
 
 @param indexPath 改变的TextField的下标
 */
- (void)textFieldValueChange:(NSIndexPath *)indexPath textChange:(NSString *)text;

@end

/** 添加银行卡Cell */
@interface AddBankCardTableCell : UITableViewCell
/** 当前Cell所处位置 */
@property (nonatomic,assign)NSIndexPath * indexPath;

/** 提示标题 */
@property (nonatomic,strong)UILabel * titleLabel;
/** 文本输入框 */
@property (nonatomic,strong)UITextField * textField;
/** 提示文字 */
@property (nonatomic,strong)UILabel * hintLabel;

/** 代理方法 */
@property (nonatomic,weak)id <AddBankCardTableCellDelegate> delegate;

@end
