//
//  HomeTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/21.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "HomeTableCell.h"

@interface HomeTableCell ()

/** 北京View */
@property (nonatomic,strong)UIView * bgView;

/** 时间文本 */
@property (nonatomic,strong)UILabel * timeLabel;
/** 订单图片 */
@property (nonatomic,strong)UIImageView * orderImage;
/** 订单码文本 */
@property (nonatomic,strong)UILabel * orderCodeLabel;
/** 位置图片 */
@property (nonatomic,strong)UIImageView * locationImage;
/** 位置文本 */
@property (nonatomic,strong)UILabel * locationLabel;
/** 订单状态 */
@property (nonatomic,strong)UILabel * stateLabel;
/** 订单金额 */
@property (nonatomic,strong)UILabel * moneyLabel;
/** 订单回单票数详情 */
@property (nonatomic,strong)UILabel * orderInfo;

@end;


@implementation HomeTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = COLOR(243, 244, 245, 1);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setSubViewAutoLayout];
    }
    return self;
}
- (void)setModel:(TaskListModel *)model{
    _model = model;
    
    
    self.timeLabel.text = _model.orderdate;
    
    self.orderCodeLabel.text = _model.orderno;
    self.locationLabel.text = _model.address;
    
    NSString * money = [NSString stringWithFormat:@"￥%@",_model.account];
    NSMutableAttributedString * attString = [[NSMutableAttributedString alloc]initWithString:money];
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, 1)];
    self.moneyLabel.attributedText = attString;

    
    NSString * hdnum = _model.hdnum;
    NSString * detailnum = _model.detailnum;
    
    if ([hdnum isEqualToString:@""] || hdnum ==nil || hdnum ==NULL) {
        hdnum = @"0";
    }
    if ([detailnum isEqualToString:@""] || detailnum ==nil || detailnum ==NULL) {
        detailnum = @"0";
    }
    
    self.orderInfo.text = [NSString stringWithFormat:@"回单票数：%@ 共：%@票",hdnum,detailnum];

//    2：待完成
//    3：未完成
//    4：已完成
    if ([_model.mainstate isEqualToString:@"2"]) {
        self.stateLabel.text = @"待完成";
    }else if ([_model.mainstate isEqualToString:@"3"]){
        self.stateLabel.text = @"未完成";
    }else if ([_model.mainstate isEqualToString:@"4"]){
        self.stateLabel.text = @"已完成";
    }
    
}

#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    
    [weakself.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.top.offset(10);
        make.right.left.offset(0);
    }];
    
    [weakself.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(20);
    }];

    [weakself.orderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.equalTo(weakself.timeLabel.mas_bottom).offset(20);
        make.width.height.offset(20);
    }];
    
    [weakself.orderCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.orderImage.mas_right).offset(5);
        make.top.equalTo(weakself.orderImage.mas_top).offset(0);
    }];
    
    [weakself.locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.equalTo(weakself.orderImage.mas_bottom).offset(15);
        make.width.height.offset(20);
    }];
    
    [weakself.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.bottom.equalTo(weakself.locationLabel.mas_bottom);
    }];
    
    [weakself.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.locationImage.mas_right).offset(5);
        make.top.equalTo(weakself.locationImage.mas_top).offset(0);
        make.right.equalTo(weakself.moneyLabel.mas_left).priorityHigh(600);
    }];
    
    UILabel * lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = LineGray_Color;
    [self.bgView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.offset(1.5);
        make.bottom.offset(-40);
    }];
    
    [weakself.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.top.offset(20);
    }];

    [weakself.orderInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.bottom.offset(-10);
    }];
}

#pragma mark - 懒加载
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = White_Color;
        _bgView.layer.cornerRadius = 10;
        _bgView.layer.masksToBounds = YES;
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"2017.9.21 13:29 发布";
        _timeLabel.textColor = COLOR(175, 175, 175, 1);
        _timeLabel.font = [UIFont systemFontOfSize:18];
        [self.bgView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UIImageView *)orderImage{
    if (!_orderImage) {
        _orderImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"list"]];
        _orderImage.contentMode = UIViewContentModeScaleAspectFit;//
        [self.bgView addSubview:_orderImage];
    }
    return _orderImage;
}

- (UILabel *)orderCodeLabel{
    if (!_orderCodeLabel) {
        _orderCodeLabel = [[UILabel alloc]init];
        _orderCodeLabel.text = @"20170728085636331895";
        _orderCodeLabel.textColor = Black_Color;
        [self.bgView addSubview:_orderCodeLabel];
    }
    return _orderCodeLabel;
}

- (UIImageView *)locationImage{
    if (!_locationImage) {
        _locationImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loc"]];
        _locationImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.bgView addSubview:_locationImage];
    }
    return _locationImage;
}

- (UILabel *)locationLabel{
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc]init];
        _locationLabel.text = @"东莞大坪分拨中心";
        _locationLabel.textColor = Black_Color;
        _locationLabel.numberOfLines = 0;
        [self.bgView addSubview:_locationLabel];
    }
    return _locationLabel;
}

- (UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.text = @"待完成";
        _stateLabel.textColor = COLOR(0, 189, 198, 1);
        [self.bgView addSubview:_stateLabel];
    }
    return _stateLabel;
}

- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.textColor = Red_Color;
        _moneyLabel.font = [UIFont systemFontOfSize:30];
        NSMutableAttributedString * attString = [[NSMutableAttributedString alloc]initWithString:@"￥000"];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, 1)];
        _moneyLabel.attributedText = attString;
        [self.bgView addSubview:_moneyLabel];
    }
    return _moneyLabel;
}


- (UILabel *)orderInfo{
    if (!_orderInfo) {
        _orderInfo = [[UILabel alloc]init];
        _orderInfo.text = @"回单票数：0 共：0票";
        _orderInfo.textColor = Black_Color;
        [self.bgView addSubview:_orderInfo];
    }
    return _orderInfo;
}
@end
