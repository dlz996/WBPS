//
//  MessageTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/25.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "MessageTableCell.h"

@interface MessageTableCell ()

@property (nonatomic,strong)UIView * bgView;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)UILabel * contenLabel;

@end

@implementation MessageTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR(243, 244, 245, 1);
        [self setSubViewAutoLayout];
    }
    return self;
}
#pragma mark - 设置数据
- (void)setModel:(MessageModel *)model{
    _model = model;
    self.titleLabel.text = _model.msgtitle;
    self.timeLabel.text = _model.msgdate;
    self.contenLabel.text = _model.msgcontent;
}

#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    
    [weakself.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(10);
        make.right.offset(-10);
        make.bottom.offset(0);
    }];
    
    [weakself.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(12);
        make.left.offset(10);
    }];
    
    [weakself.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.titleLabel.mas_bottom).offset(10);
        make.left.offset(10);
    }];
    
    [weakself.contenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(weakself.timeLabel.mas_bottom);
    }];
    
    
}
#pragma mark - 懒加载
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.layer.cornerRadius = 10;
        _bgView.layer.masksToBounds = YES;
        _bgView.backgroundColor = White_Color;
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"欢迎使用微步2.0版本";
        _titleLabel.textColor = Black_Color;
        [self.bgView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = COLOR(183, 184, 185, 1);
        _timeLabel.text = @"2017-09-24";
        _timeLabel.font = [UIFont systemFontOfSize:12];
        [self.bgView addSubview:_timeLabel];
    }
    return _timeLabel;
}
- (UILabel *)contenLabel{
    if (!_contenLabel) {
        _contenLabel = [UILabel labelWithText:@"" atColor:FontGray_Color atTextSize:15 atTextFontForType:@""];
        _contenLabel.numberOfLines = 0;
        [self.bgView addSubview:_contenLabel];
    }
    return _contenLabel;
}
@end
