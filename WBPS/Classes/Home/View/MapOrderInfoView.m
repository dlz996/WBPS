//
//  MapOrderInfoView.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/27.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "MapOrderInfoView.h"

@interface MapOrderInfoView ()


/** 运单重量标题 */
@property (nonatomic,strong)UILabel * weightTitle;
/** 运单重量详情 */
@property (nonatomic,strong)UILabel * weightInfo;
/** 运单体积标题 */
@property (nonatomic,strong)UILabel * volumeTitle;
/** 运单体积详情 */
@property (nonatomic,strong)UILabel * volumeInfo;
/** 运单信息标题 */
@property (nonatomic,strong)UILabel * orderTitle;
/** 运单信息详情 */
@property (nonatomic,strong)UILabel * orderInfo;
/** 出发地标题 */
@property (nonatomic,strong)UILabel * startLocationTitle;
/** 出发地详情 */
@property (nonatomic,strong)UILabel * startLocationInfo;
/** 目的地标题 */
@property (nonatomic,strong)UILabel * aimLocationTitle;
/** 目的地详情 */
@property (nonatomic,strong)UILabel * aimLocationInfo;
/** 订单时间标题 */
@property (nonatomic,strong)UILabel * timeTitle;
/** 订单时间详情 */
@property (nonatomic,strong)UILabel * timeInfo;
/** 导航 */
@property (nonatomic,strong)UIButton * navigation;
/** 异常按钮 */
@property (nonatomic,strong)UIButton * abnormalButton;
/** 更改路线 */
@property (nonatomic,strong)UIButton * changeWay;

@end

@implementation MapOrderInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubViewAutoLayout];
    }
    return self;
}

#pragma mark - 设置数据
- (void)setModel:(TaskInfoModel *)model{
    _model = model;
    
    self.weightInfo.text =  [NSString stringWithFormat:@"%@公斤",_model.weight];
    self.volumeInfo.text =  [NSString stringWithFormat:@"%@立方米",_model.volumn];
    self.orderInfo.text = _model.product;
    
    self.startLocationInfo.text = [NSString stringWithFormat:@"%@%@%@%@%@",_model.bsheng,_model.bcity,_model.barea,_model.btown,_model.baddress];
    
    self.aimLocationInfo.text = [NSString stringWithFormat:@"%@%@%@%@%@",_model.esheng,_model.ecity,_model.earea,_model.etown,_model.eaddress];

    self.timeInfo.text = _model.downdate;

    if ([_model.orderstate isEqualToString:@"0"]) {
        [self.typeButton setTitle:@"出发" forState:UIControlStateNormal];
    }else if ([_model.orderstate isEqualToString:@"3"]){
        [self.typeButton setTitle:@"到达卸货地" forState:UIControlStateNormal];
    }else if([_model.orderstate isEqualToString:@"4"]){
        [self.typeButton setTitle:@"签收" forState:UIControlStateNormal];
    }
    
}

#pragma mark - 点击导航按钮
/** 导航按钮 */
- (void)clickNavigationButton{
    if ([self.delegate respondsToSelector:@selector(clickBottomButton:)]) {
        [self.delegate clickBottomButton:1];
    }
}
/** 点击完成、签收按钮 */
- (void)clickTypeButton{
    if ([self.delegate respondsToSelector:@selector(clickBottomButton:)]) {
        [self.delegate clickBottomButton:2];
    }
}
/** 点击异常按钮 */
- (void)clickAbnormalButton{
    if ([self.delegate respondsToSelector:@selector(clickBottomButton:)]) {
        [self.delegate clickBottomButton:3];
    }
}
/** 点击选择路线按钮 */
- (void)clickChangeWayButton{
    if ([self.delegate respondsToSelector:@selector(clickBottomButton:)]) {
        [self.delegate clickBottomButton:4];
    }
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    
    [weakself.weightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(30);
    }];
    
    [weakself.weightInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.weightTitle.mas_right);
        make.bottom.equalTo(weakself.weightTitle.mas_bottom).offset(-2);
    }];
    
    [weakself.volumeInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.bottom.equalTo(weakself.volumeTitle.mas_bottom).offset(-2);
    }];
    
    [weakself.volumeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.volumeInfo.mas_left);
        make.top.offset(30);
    }];
    
    [weakself.orderTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(weakself.weightTitle.mas_bottom).offset(10);
    }];
    
    [weakself.orderInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.orderTitle.mas_right);
        make.bottom.equalTo(weakself.orderTitle.mas_bottom).offset(-2);
    }];
    
    [weakself.startLocationTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.width.offset(82);
        make.top.equalTo(weakself.orderTitle.mas_bottom).offset(10);
    }];
    
    [weakself.startLocationInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.startLocationTitle.mas_right);
        make.top.equalTo(weakself.startLocationTitle.mas_top).offset(2);
        make.right.offset(-10);
    }];
    
    [weakself.aimLocationTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.width.offset(82);
        make.top.equalTo(weakself.startLocationInfo.mas_bottom).offset(10);
    }];
    [weakself.aimLocationInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.aimLocationTitle.mas_right);
        make.top.equalTo(weakself.aimLocationTitle.mas_top).offset(2);
        make.right.offset(-10);
    }];
    
    [weakself.timeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(weakself.aimLocationInfo.mas_bottom).offset(10);
    }];
    
    [weakself.timeInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.timeTitle.mas_right);
        make.bottom.equalTo(weakself.timeTitle.mas_bottom).offset(-2);
    }];
    
    [weakself.abnormalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.bottom.offset(-10);
        make.height.offset(45);
        make.width.offset(60);
    }];
    [weakself.changeWay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.abnormalButton.mas_right).offset(10);
        make.bottom.offset(-10);
        make.height.offset(45);
        make.width.offset(60);
    }];
    [weakself.navigation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.changeWay.mas_right).offset(10);
        make.bottom.offset(-10);
        make.height.offset(45);
        make.width.offset(60);
    }];
    
    [weakself.typeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.navigation.mas_right).offset(10);
        make.right.offset(-10);
        make.bottom.offset(-10);
        make.height.offset(45);
    }];
}

#pragma mark - 懒加载
- (UILabel *)weightTitle{
    if (!_weightTitle) {
        _weightTitle = [self makeTitleLabel:@"运单重量："];
    }
    return _weightTitle;
}
- (UILabel *)weightInfo{
    if (!_weightInfo) {
        _weightInfo = [self makeInfoLabel:@"1公斤"];
    }
    return _weightInfo;
}
- (UILabel *)volumeTitle{
    if (!_volumeTitle) {
        _volumeTitle = [self makeTitleLabel:@"运单体积："];
    }
    return _volumeTitle;
}
- (UILabel *)volumeInfo{
    if (!_volumeInfo) {
        _volumeInfo = [self makeInfoLabel:@"1立方米"];
    }
    return _volumeInfo;
}

- (UILabel *)orderTitle{
    if (!_orderTitle) {
        _orderTitle = [self makeTitleLabel:@"运单信息："];
    }
    return _orderTitle;
}
- (UILabel *)orderInfo{
    if (!_orderInfo) {
        _orderInfo = [self makeInfoLabel:@"家具1箱纸"];
    }
    return _orderInfo;
}
- (UILabel *)startLocationTitle{
    if (!_startLocationTitle) {
        _startLocationTitle = [self makeTitleLabel:@"出发地点："];
    }
    return _startLocationTitle;
}
- (UILabel *)startLocationInfo{
    if (!_startLocationInfo) {
        _startLocationInfo = [self makeInfoLabel:@"广东省广州市白云区石井街道石沙路294号"];
        _startLocationInfo.numberOfLines = 0;
    }
    return _startLocationInfo;
}

- (UILabel *)aimLocationTitle{
    if (!_aimLocationTitle) {
        _aimLocationTitle = [self makeTitleLabel:@"终点地点："];
    }
    return _aimLocationTitle;
}
- (UILabel *)aimLocationInfo{
    if (!_aimLocationInfo) {
        _aimLocationInfo = [self makeInfoLabel:@"广东省广州市诗经街道石沙路八方物流园D栋1-6号"];
        _aimLocationInfo.numberOfLines = 0;
    }
    return _aimLocationInfo;
}

- (UILabel *)timeTitle{
    if (!_timeTitle) {
        _timeTitle = [self makeTitleLabel:@"送达时间："];
    }
    return _timeTitle;
}
- (UILabel *)timeInfo{
    if (!_timeInfo) {
        _timeInfo = [self makeInfoLabel:@"未设定"];
    }
    return _timeInfo;
}
- (UIButton *)abnormalButton{
    if (!_abnormalButton) {
        _abnormalButton = [UIButton buttonWithTitle:@"异常" atTitleSize:18 atTitleColor:White_Color atTarget:self atAction:@selector(clickAbnormalButton)];
        _abnormalButton.layer.cornerRadius = 5;
        _abnormalButton.backgroundColor = COLOR(236, 84, 93, 1);
        [self addSubview:_abnormalButton];
    }
    return _abnormalButton;
}
- (UIButton *)changeWay{
    if (!_changeWay) {
        _changeWay = [UIButton buttonWithTitle:@"选择\n路线" atTitleSize:15 atTitleColor:White_Color atTarget:self atAction:@selector(clickChangeWayButton)];
        _changeWay.titleLabel.numberOfLines = 0;
        _changeWay.layer.cornerRadius = 5;
        _changeWay.backgroundColor = COLOR(34, 114, 230, 1);
        [self addSubview:_changeWay];
    }
    return _changeWay;
}
- (UIButton *)navigation{
    if (!_navigation) {
        _navigation = [UIButton buttonWithTitle:@"导航" atTitleSize:18 atTitleColor:White_Color atTarget:self atAction:@selector(clickNavigationButton)];
        _navigation.layer.cornerRadius = 5;
        _navigation.backgroundColor = COLOR(34, 114, 230, 1);
        [self addSubview:_navigation];
    }
    return _navigation;
}

- (UIButton *)typeButton{
    if (!_typeButton) {
        _typeButton = [UIButton buttonWithTitle:@"到达卸货地" atTitleSize:18 atTitleColor:White_Color atTarget:self atAction:@selector(clickTypeButton)];
        _typeButton.layer.cornerRadius = 5;
        _typeButton.backgroundColor = COLOR(34, 114, 230, 1);
        [self addSubview:_typeButton];
    }
    return _typeButton;
}

/** 创建标题文本 */
- (UILabel *)makeTitleLabel:(NSString *)title{
    UILabel * label = [UILabel labelWithText:title atColor:Black_Color atTextSize:16 atTextFontForType:@""];
    [self addSubview:label];
    return label;
}
/** 创建内容详情 */
- (UILabel *)makeInfoLabel:(NSString *)info{
    UILabel *label = [UILabel labelWithText:info atColor:Black_Color atTextSize:14 atTextFontForType:@""];
    [self addSubview:label];
    return label;
}


@end
