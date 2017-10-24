//
//  UserAndCarStateEditView.m
//  悬浮球
//
//  Created by 董立峥 on 2017/9/30.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "UserAndCarStateEditView.h"

@interface UserAndCarStateEditView ()

/** 外层线条View */
@property (nonatomic,strong)UIView * lineBorderView;
/** 外层View */
@property (nonatomic,strong)UIView * externalView;
/** 内层View */
@property (nonatomic,strong)UIView * inlayerView;
/** 下班按钮 */
@property (nonatomic,strong)UIButton * outDutyButton;
/** 空载按钮 */
@property (nonatomic,strong)UIButton * emptyValue;
/** 半载按钮 */
@property (nonatomic,strong)UIButton * halfValue;
/** 满载按钮 */
@property (nonatomic,strong)UIButton * fullValue;
/** 选中按钮 */
@property (nonatomic,strong)UIButton * selectButton;

@end

@implementation UserAndCarStateEditView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSelf)];
        [self addGestureRecognizer:tap];
        [self setSubViewAutoLayout];
    }
    return self;
}
#pragma mark - 赋值
/** 修改车辆状态 */
- (void)setCarStateType:(CarState)carStateType{
    _carStateType = carStateType;
    NSLog(@"打印现在的状态------>>>%ld",_carStateType);
//    NSCarStateOfEmpty,   //空载
//    NSCarStateOfHalf,     //半载
//    NSCarStateOfFull     //满载
    switch (_carStateType) {
        case NSCarStateOfEmpty:
            
            break;
        case NSCarStateOfHalf:
            
            break;
        case NSCarStateOfFull:
            
            break;
        default:
            break;
    }
    
    
//    NSArray * array = @[self.emptyValue,self.halfValue,self.fullValue];
//
//    for (UIButton *btn  in array) {
//        [btn setBackgroundColor:[UIColor colorWithRed:61/255.0 green:107/255.0 blue:157/255.0 alpha:1]];
//    }
//    UIButton * selectButton = (UIButton *)array[_carStateType -1];
//    [selectButton setBackgroundColor:[UIColor colorWithRed:212/255.0 green:143/255.0 blue:41/255.0 alpha:1]];

}

#pragma mark -点击事件
/** 点击车辆状态按钮 */
- (void)clickCarStateButton:(UIButton *)send{
    [self.selectButton setBackgroundColor:[UIColor colorWithRed:61/255.0 green:107/255.0 blue:157/255.0 alpha:1]];
    self.selectButton = send;

    [self.selectButton setBackgroundColor:[UIColor colorWithRed:212/255.0 green:143/255.0 blue:41/255.0 alpha:1]];

    if ([self.delegate respondsToSelector:@selector(selectCarState:)]) {
        [self.delegate selectCarState:send.tag];
    }
}
/** 下班调用方法 */
- (void)clickOutDutyButton{
    if ([self.delegate respondsToSelector:@selector(outDutyButton)]) {
        [self.delegate outDutyButton];
    }
}
/** 点击空白区域，让视图小时 */
- (void)clickSelf{
    if ([self.delegate respondsToSelector:@selector(clickBlankView)]) {
        [self.delegate clickBlankView];
    }
}


#pragma mark - 约束
- (void)setSubViewAutoLayout{
    __weak typeof(&*self) weakself = self;
    
    [weakself.lineBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.mas_centerX);
        make.centerY.equalTo(weakself.mas_centerY);
        make.width.height.offset(260);
    }];
    
    [weakself.externalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.lineBorderView.mas_centerY);
        make.centerX.equalTo(weakself.lineBorderView.mas_centerX);
        make.height.width.offset(250);
    }];
    
    [weakself.inlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.lineBorderView.mas_centerY);
        make.centerX.equalTo(weakself.lineBorderView.mas_centerX);
        make.height.width.offset(160);
    }];

    [weakself.outDutyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.lineBorderView.mas_centerY);
        make.centerX.equalTo(weakself.lineBorderView.mas_centerX);
        make.height.width.offset(60);
    }];
    
    [weakself.emptyValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.lineBorderView.mas_centerX);
        make.centerY.equalTo(weakself.inlayerView.mas_top);
        make.height.width.offset(70);
    }];
 
    [weakself.fullValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.inlayerView.mas_left).offset(10);
        make.centerY.equalTo(weakself.inlayerView.mas_bottom).offset(-40);;
        make.height.width.offset(70);
    }];
    
    [weakself.halfValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.inlayerView.mas_right).offset(-10);
        make.centerY.equalTo(weakself.inlayerView.mas_bottom).offset(-40);
        make.height.width.offset(70);
    }];
}

#pragma mark - 懒加载
- (UIView *)lineBorderView{
    if (!_lineBorderView) {
        _lineBorderView = [[UIView alloc]init];
        _lineBorderView.backgroundColor = [UIColor clearColor];
        _lineBorderView.layer.cornerRadius = 130;
        _lineBorderView.layer.masksToBounds = YES;
        _lineBorderView.layer.borderWidth = 1;
        _lineBorderView.layer.borderColor = [UIColor colorWithRed:70/255.0 green:107/255.0 blue:136/255.0 alpha:1].CGColor;
        [self addSubview:_lineBorderView];
    }
    return _lineBorderView;
}
- (UIView *)externalView{
    if (!_externalView) {
        _externalView = [[UIView alloc]init];
        _externalView.backgroundColor = [UIColor colorWithRed:33/255.0 green:59/255.0 blue:95/255.0 alpha:0.8];
        _externalView.layer.cornerRadius = 125;
        _externalView.layer.masksToBounds = YES;
        [self addSubview:_externalView];
    }
    return _externalView;
}
- (UIView *)inlayerView{
    if (!_inlayerView) {
        _inlayerView = [[UIView alloc]init];
        _inlayerView.backgroundColor = [UIColor colorWithRed:70/255.0 green:107/255.0 blue:136/255.0 alpha:0.6];
        _inlayerView.layer.cornerRadius = 80;
        _inlayerView.layer.masksToBounds = YES;
        _inlayerView.layer.borderWidth = 2;
        _inlayerView.layer.borderColor = [UIColor colorWithRed:23/255.0 green:56/255.0 blue:93/255.0 alpha:0.5].CGColor;
        [self addSubview:_inlayerView];
    }
    return _inlayerView;
}
- (UIButton *)outDutyButton{
    if (!_outDutyButton) {
        _outDutyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _outDutyButton.layer.cornerRadius = 30;
        _outDutyButton.layer.masksToBounds = YES;
        _outDutyButton.layer.borderWidth = 4;
        _outDutyButton.layer.borderColor = [UIColor colorWithRed:33/255.0 green:59/255.0 blue:95/255.0 alpha:0.8].CGColor;
        [_outDutyButton setBackgroundColor:[UIColor colorWithRed:54/255.0 green:140/255.0 blue:193/255.0 alpha:1]];
        [_outDutyButton setTitle:@"下班" forState:UIControlStateNormal];
        [_outDutyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_outDutyButton addTarget:self action:@selector(clickOutDutyButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_outDutyButton];
    }
    return _outDutyButton;
}
- (UIButton *)emptyValue{
    if (!_emptyValue) {
        _emptyValue = [UIButton buttonWithType:UIButtonTypeCustom];
        _emptyValue.layer.cornerRadius = 35;
        _emptyValue.layer.masksToBounds = YES;
        _emptyValue.layer.borderWidth = 4;
        _emptyValue.layer.borderColor = [UIColor colorWithRed:33/255.0 green:59/255.0 blue:95/255.0 alpha:0.8].CGColor;
        [_emptyValue setBackgroundColor:[UIColor colorWithRed:212/255.0 green:143/255.0 blue:41/255.0 alpha:1]];
        [_emptyValue setTitle:@"空载" forState:UIControlStateNormal];
        [_emptyValue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _emptyValue.tag = 1;
        [_emptyValue addTarget:self action:@selector(clickCarStateButton:) forControlEvents:UIControlEventTouchUpInside];
        self.selectButton = _emptyValue;
        [self addSubview:_emptyValue];
    }
    return _emptyValue;
}
- (UIButton *)fullValue{
    if (!_fullValue) {
        _fullValue = [UIButton buttonWithType:UIButtonTypeCustom];
        _fullValue.layer.cornerRadius = 35;
        _fullValue.layer.masksToBounds = YES;
        _fullValue.layer.borderWidth = 4;
        _fullValue.layer.borderColor = [UIColor colorWithRed:33/255.0 green:59/255.0 blue:95/255.0 alpha:0.8].CGColor;
        [_fullValue setBackgroundColor:[UIColor colorWithRed:61/255.0 green:107/255.0 blue:157/255.0 alpha:1]];
        [_fullValue setTitle:@"满载" forState:UIControlStateNormal];
        [_fullValue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _fullValue .tag = 3;
        [_fullValue addTarget:self action:@selector(clickCarStateButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_fullValue];
    }
    return _fullValue;
}
- (UIButton *)halfValue{
    if (!_halfValue) {
        _halfValue = [UIButton buttonWithType:UIButtonTypeCustom];
        _halfValue.layer.cornerRadius = 35;
        _halfValue.layer.masksToBounds = YES;
        _halfValue.layer.borderWidth = 4;
        _halfValue.layer.borderColor = [UIColor colorWithRed:33/255.0 green:59/255.0 blue:95/255.0 alpha:0.8].CGColor;
        [_halfValue setBackgroundColor:[UIColor colorWithRed:61/255.0 green:107/255.0 blue:157/255.0 alpha:1]];
        [_halfValue setTitle:@"半载" forState:UIControlStateNormal];
        [_halfValue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _halfValue.tag = 2;
        [_halfValue addTarget:self action:@selector(clickCarStateButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_halfValue];
    }
    return _halfValue;
}
@end
