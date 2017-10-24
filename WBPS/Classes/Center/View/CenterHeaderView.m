
//
//  CenterHeaderView.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/25.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "CenterHeaderView.h"

#import "CenterHeaderBottomView.h"

@interface CenterHeaderView ()
/** 背景图片 */
@property (nonatomic,strong)UIImageView * bgImage;

/** 用户名字 */
@property (nonatomic,strong)UILabel * userNameLabel;
/** 审核状态 */
@property (nonatomic,strong)UILabel * checkStateLabel;
/** 车牌号 */
@property (nonatomic,strong)UILabel *carNumbeLabelr;
/** 车辆权限类型 */
@property (nonatomic,strong)UILabel * typeLabel;
/** 手机号码 */
@property (nonatomic,strong)UILabel * phoneNumber;
/** 重新认证 */
@property (nonatomic,strong)UIButton * againButton;
/** 总接单数 */
@property (nonatomic,strong)CenterHeaderBottomView * allNumber;
/** 评价级别 */
@property (nonatomic,strong)CenterHeaderBottomView * estimateNumber;
/** 总路程 */
@property (nonatomic,strong)CenterHeaderBottomView * allJourney;

@end
@implementation CenterHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubViewAutoLayout];
    }
    return self;
}
/** 设置数据 */
- (void)setData{
    UIImage * image = [UIImage imageNamed:@"icon_头像.png"];
    /** 头像URL路径 */
    NSString * titleImageUrl = [kImageBaseUrl stringByAppendingString:[UserModel sharedUserInfo].headimepath];
    NSURL * url = [NSURL URLWithString:titleImageUrl];
    [self.userTitleImage sd_setImageWithURL:url placeholderImage:image];

    self.userNameLabel.text = [UserModel sharedUserInfo].username;
    self.carNumbeLabelr.text = [UserModel sharedUserInfo].vehicleno;
    if ([[UserModel sharedUserInfo].checkstate intValue]==0){
        self.checkStateLabel.text = @"待审核";
    }else if ([[UserModel sharedUserInfo].checkstate intValue]==1){
        self.checkStateLabel.text = @"审核通过";
    }else{
        self.checkStateLabel.text = @"审核不通过";
    }
    self.typeLabel.text = @"全市通";
    self.phoneNumber.text = [UserModel sharedUserInfo].usermb;
    self.allNumber.valueLabel.text = [UserModel sharedUserInfo].fetchcount;
    self.estimateNumber.valueLabel.text = [UserModel sharedUserInfo].score;
    self.allJourney.valueLabel.text = [UserModel sharedUserInfo].glssum;

}

#pragma mark - 点击方法
/** 点击重新认证按钮 */
- (void)clickbutton{
    if ([self.delegate respondsToSelector:@selector(clickAgainButton)]) {
        [self.delegate clickAgainButton];
    }
}
/** 点击头像 */
- (void)clickTitleImage{
    NSLog(@"点击了头像")
    if ([self.delegate respondsToSelector:@selector(selectTitleImage)]) {
        [self.delegate selectTitleImage];
    }
}

#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(135);
    }];
    
    [weakself.userTitleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17);
        make.top.offset(20);
        make.width.height.offset(60);
    }];
    
    [weakself.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.userTitleImage.mas_right).offset(10);
        make.top.equalTo(weakself.userTitleImage.mas_top).offset(2);
    }];
    
    [weakself.checkStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.userNameLabel.mas_centerY);
        make.left.equalTo(weakself.userNameLabel.mas_right).offset(20);
    }];
    
    [weakself.carNumbeLabelr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.userNameLabel.mas_left);
        make.top.equalTo(weakself.userNameLabel.mas_bottom).offset(10);
    }];
    
    UILabel * line1 = [self makeLabel];
    line1.backgroundColor = White_Color;
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.carNumbeLabelr.mas_right).offset(5);
        make.width.offset(1);
        make.height.offset(15);
        make.centerY.equalTo(weakself.carNumbeLabelr.mas_centerY);
    }];
    
    [weakself.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1.mas_right).offset(5);
        make.centerY.equalTo(weakself.carNumbeLabelr.mas_centerY);
    }];

    UILabel *line2 = [self makeLabel];
    line2.backgroundColor = White_Color;
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.typeLabel.mas_right).offset(5);
        make.width.offset(1);
        make.height.offset(15);
        make.centerY.equalTo(weakself.carNumbeLabelr.mas_centerY);
    }];
    [weakself.phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line2.mas_right).offset(5);
        make.centerY.equalTo(weakself.carNumbeLabelr.mas_centerY);
    }];

    [weakself.againButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.userNameLabel.mas_left);
        make.top.equalTo(weakself.carNumbeLabelr.mas_bottom).offset(20);
        make.height.offset(20);
        make.width.offset(60);
    }];
    
    NSArray * bottomAry = @[weakself.allNumber,weakself.estimateNumber,weakself.allJourney];
    [bottomAry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [bottomAry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.height.offset(65);
    }];
    
}

#pragma mark - 懒加载
- (UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc]init];
        _bgImage.backgroundColor = COLOR(34, 114, 230, 1);
        [self addSubview:_bgImage];
    }
    return _bgImage;
}

- (UIImageView *)userTitleImage{
    if (!_userTitleImage) {
        _userTitleImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_头像.png"]];
        _userTitleImage.layer.cornerRadius = 30;
        _userTitleImage.layer.masksToBounds = YES;
        _userTitleImage.layer.borderWidth = 1;
        _userTitleImage.layer.borderColor = [UIColor whiteColor].CGColor;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTitleImage)];
        [_userTitleImage addGestureRecognizer:tap];
        _userTitleImage.userInteractionEnabled = YES;
        [self addSubview:_userTitleImage];
    }
    return _userTitleImage;
}

- (UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc]init];
        _userNameLabel.textColor = White_Color;
        _userNameLabel.font = [UIFont systemFontOfSize:18];
        _userNameLabel.text = @"王小二";
        [self addSubview:_userNameLabel];
    }
    return _userNameLabel;
}

- (UILabel *)checkStateLabel{
    if (!_checkStateLabel) {
        _checkStateLabel = [self makeLabel];
        _checkStateLabel.text = @"审核通过";
    }
    return _checkStateLabel;
}

- (UILabel *)carNumbeLabelr{
    if (!_carNumbeLabelr) {
        _carNumbeLabelr = [self makeLabel];
        _carNumbeLabelr.text = @"粤A00000";
    }
    return _carNumbeLabelr;
}

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [self makeLabel];
        _typeLabel.text = @"全市通";
    }
    return _typeLabel;
}

- (UILabel *)phoneNumber{
    if (!_phoneNumber) {
        _phoneNumber = [self makeLabel];
        _phoneNumber.text = @"15188367971";
    }
    return _phoneNumber;
}

- (UIButton *)againButton{
    if (!_againButton) {
        _againButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_againButton setTitle:@"重新认证" forState:UIControlStateNormal];
        _againButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [_againButton setTitleColor:COLOR(253, 197, 63, 1) forState:UIControlStateNormal];
        _againButton.layer.cornerRadius = 5;
        _againButton.layer.masksToBounds = YES;
        _againButton.layer.borderWidth = 0.3;
        _againButton.layer.borderColor = [UIColor whiteColor].CGColor;
        [_againButton addTarget:self action:@selector(clickbutton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_againButton];
    }
    return _againButton;
}

- (CenterHeaderBottomView *)allNumber{
    if (!_allNumber) {
        _allNumber = [[CenterHeaderBottomView alloc]init];
        _allNumber.hintLabel.text = @"接单总数";
        _allNumber.valueLabel.text = @"100";
        [self addSubview:_allNumber];
    }
    return _allNumber;
}
- (CenterHeaderBottomView *)estimateNumber{
    if (!_estimateNumber) {
        _estimateNumber = [[CenterHeaderBottomView alloc]init];
        _estimateNumber.hintLabel.text = @"服务评价";
        _estimateNumber.valueLabel.text = @"5";
        [self addSubview:_estimateNumber];
    }
    return _estimateNumber;
}
- (CenterHeaderBottomView *)allJourney{
    if (!_allJourney) {
        _allJourney = [[CenterHeaderBottomView alloc]init];
        _allJourney.hintLabel.text = @"总里程数(KM)";
        _allJourney.valueLabel.text = @"500";
        [self addSubview:_allJourney];
    }
    return _allJourney;
}

- (UILabel *)makeLabel{
    UILabel * label = [[UILabel alloc]init];
    label.textColor = White_Color;
    label.font = [UIFont systemFontOfSize:14];
    [self addSubview:label];
    return label;
}



@end
