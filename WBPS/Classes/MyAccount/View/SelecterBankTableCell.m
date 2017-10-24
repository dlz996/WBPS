//
//  SelecterBankTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/14.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "SelecterBankTableCell.h"

@implementation SelecterBankTableCell

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
        make.left.offset(20);
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.width.height.offset(35);
    }];
    
    [weakself.bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.icon.mas_right).offset(30);
        make.centerY.equalTo(weakself.icon.mas_centerY);
    }];
    
    
    UIImageView * line = [UIImageView horizontalSeparateImageView];
    [weakself.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(1);
    }];
}

#pragma mark - 懒加载
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [UIImageView imageViewWithImageName:@""];
        [self.contentView addSubview:_icon];
    }
    return _icon;
}

- (UILabel *)bankName{
    if (!_bankName) {
        _bankName = [UILabel labelWithText:@"银行名字" atColor:Black_Color atTextSize:20 atTextFontForType:@""];
        [self.contentView addSubview:_bankName];
    }
    return _bankName;
}


@end
