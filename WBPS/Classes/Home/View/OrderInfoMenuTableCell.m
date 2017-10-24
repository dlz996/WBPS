//
//  OrderInfoMenuTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/22.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "OrderInfoMenuTableCell.h"

@implementation OrderInfoMenuTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        WS(weakself);
        [weakself.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakself.contentView.mas_centerX);
            make.centerY.equalTo(weakself.contentView.mas_centerY);
        }];
    }
    return self;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = Black_Color;
        _contentLabel.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

@end
