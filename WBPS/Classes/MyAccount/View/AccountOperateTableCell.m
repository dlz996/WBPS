
//
//  AccountOperateTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/25.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "AccountOperateTableCell.h"

@interface AccountOperateTableCell ()

@end

@implementation AccountOperateTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setSubViewAutoLayout];
    }
    return self;
}

#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.width.height.offset(20);
    }];
    
    [weakself.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.icon.mas_centerY);
        make.left.equalTo(weakself.icon.mas_right).offset(12);
    }];
    
    [weakself.moneyInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(weakself.icon.mas_centerY);
    }];
    
    UILabel * line = [[UILabel alloc]init];
    line.backgroundColor = LineGray_Color;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(1);
    }];
}

#pragma mark - 懒加载
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
    }
    return _icon;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = Black_Color;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UILabel *)moneyInfo{
    if (!_moneyInfo) {
        _moneyInfo = [[UILabel alloc]init];
        _moneyInfo.textColor = Red_Color;
        _moneyInfo.text = @"0.00";
        _moneyInfo.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_moneyInfo];
    }
    return _moneyInfo;
}

@end
