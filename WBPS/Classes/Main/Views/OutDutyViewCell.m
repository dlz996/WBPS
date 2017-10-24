//
//  OutDutyViewCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/28.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "OutDutyViewCell.h"

@interface OutDutyViewCell ()
/** 数值 */
@property (nonatomic,strong)UILabel * valueLabel;
/** 分割线 */
@property (nonatomic,strong)UILabel * line;
@end

@implementation OutDutyViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setSubViewAutoLayout];
    }
    return self;
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.offset(45);
        make.right.offset(-45);
        make.height.offset(1);
    }];
    
    [weakself.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.line.mas_left);
        make.bottom.equalTo(weakself.line.mas_top).offset(-10);
    }];

    [weakself.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.line.mas_right);
        make.bottom.equalTo(weakself.line.mas_top).offset(-10);
    }];
    
}
#pragma mark - 懒加载
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"今日收入" atColor:White_Color atTextSize:16 atTextFontForType:@""];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [UILabel labelWithText:@"1000" atColor:White_Color atTextSize:24 atTextFontForType:@""];
        [self.contentView addSubview:_valueLabel];
    }
    return _valueLabel;
}
- (UILabel *)line{
    if (!_line) {
        _line = [UILabel labelWithText:@"" atColor:White_Color atTextSize:1 atTextFontForType:@""];
        _line.backgroundColor =White_Color;
        [self.contentView addSubview:_line];
    }
    return _line;
}

@end
