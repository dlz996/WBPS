//
//  SetingPopupTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/26.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "SetingPopupTableCell.h"

@implementation SetingPopupTableCell

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
    [weakself.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.equalTo(weakself.contentView.mas_centerY);
    }];
    
    [weakself.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.left.equalTo(weakself.contentView.mas_right).offset(-90);
    }];
    
    UILabel * label = [[UILabel alloc]init];
    label.backgroundColor = LineGray_Color;
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(1);
    }];
    
}


#pragma mark - 懒加载
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"未设定";
        _titleLabel.textColor = Black_Color;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.text = @"未设定";
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = COLOR(143, 144, 145, 1);
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

@end
