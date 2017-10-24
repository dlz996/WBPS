//
//  AnnouncementTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/14.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "AnnouncementTableCell.h"

@interface AnnouncementTableCell ()

@property (nonatomic,strong)UIView * bgView;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)UIImageView * contentImage;
/** 文本内容 */
@property (nonatomic,strong)UILabel * contentLabel;
@end


@implementation AnnouncementTableCell

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
- (void)setModel:(AnnouncementModel *)model{
    _model = model;
    self.titleLabel.text = _model.noticetitle;
    
    NSURL * url = [NSURL URLWithString:_model.noticeimg];
    
    [self.contentImage sd_setImageWithURL:url placeholderImage:nil];
    self.timeLabel.text = _model.noticedate;
    
    self.contentLabel.text = _model.noticecontent;
    
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
    
    [weakself.contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(weakself.timeLabel.mas_bottom).offset(10);
        make.height.offset(120);
    }];
    
    [weakself.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(weakself.contentImage.mas_bottom).offset(10);
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

- (UIImageView *)contentImage{
    if (!_contentImage) {
        _contentImage = [[UIImageView alloc]init];
        _contentImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.bgView addSubview:_contentImage];
    }
    return _contentImage;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithText:@"" atColor:FontGray_Color atTextSize:15 atTextFontForType:@""];
        _contentLabel.numberOfLines = 0;
        [self.bgView addSubview:_contentLabel];
    }
    return _contentLabel;
}
@end
