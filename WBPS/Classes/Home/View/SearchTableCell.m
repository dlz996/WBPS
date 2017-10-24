//
//  SearchTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/13.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "SearchTableCell.h"

@interface SearchTableCell ()


@end


@implementation SearchTableCell

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
        make.centerY.equalTo(weakself.titleLabel.mas_centerY);
        make.left.equalTo(weakself.titleLabel.mas_right).offset(0);
    }];
    
}

#pragma mark - 懒加载
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithText:@"" atColor:FontGray_Color atTextSize:16 atTextFontForType:@""];
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}
- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [UILabel labelWithText:@"" atColor:COLOR(0, 95, 228, 1) atTextSize:16 atTextFontForType:@""];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
