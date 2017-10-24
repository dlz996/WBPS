//
//  SetingSwithTableCell.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/26.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetingSwithTableCellDelegate;

@protocol SetingSwithTableCellDelegate <NSObject>


/**
 当开关状态改变的时候调用的方法

 @param indexPath 改变的下标
 @param state 改变的内容
 */
- (void)switchValueChangeWithIndexPath:(NSIndexPath *)indexPath  withState:(NSString *)state;

@end

@interface SetingSwithTableCell : UITableViewCell

/** 标题 */
@property (nonatomic,strong)UILabel * titleLabel;
/** 开关按钮 */
@property (nonatomic,strong)UISwitch * switchBtn;
/** 当前cell所在下标 */
@property (nonatomic,assign)NSIndexPath * cellIndexPath;
/** 开光状态 */
@property (nonatomic,copy)NSString * switchState;

@property (nonatomic,weak)id <SetingSwithTableCellDelegate> delegate;

@end
