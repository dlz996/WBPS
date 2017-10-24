//
//  MoreListTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/26.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "MoreListTableCell.h"

@implementation MoreListTableCell

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
        make.left.offset(17);
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.width.height.offset(SCRYFrom6(20));
    }];
    
    [weakself.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.left.equalTo(weakself.icon.mas_right).offset(20);
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
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = Black_Color;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
