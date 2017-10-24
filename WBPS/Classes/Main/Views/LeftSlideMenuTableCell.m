//
//  LeftSlideMenuTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/22.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "LeftSlideMenuTableCell.h"

@implementation LeftSlideMenuTableCell

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
    [weakself.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.bottom.offset(0);
        make.width.height.offset(20);
    }];
    
    [weakself.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.iconView.mas_right).offset(20);
        make.centerY.equalTo(weakself.iconView.mas_centerY);
    }];
}

#pragma mark - 懒加载
- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_iconView];
    }
    return _iconView;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = Black_Color;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

@end
