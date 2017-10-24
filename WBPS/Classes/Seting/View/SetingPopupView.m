//
//  SetingPopupView.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/12.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "SetingPopupView.h"

@interface SetingPopupView ()<UIPickerViewDelegate,UIPickerViewDataSource>

/** 背景视图 */
@property (nonatomic,strong)UIView * bgView;
/** 提示标题 */
@property (nonatomic,strong)UILabel * hintLabel;
/** 选择器 */
@property (nonatomic,strong)UIPickerView * pickerView;
/** 确认按钮 */
@property (nonatomic,strong)UIButton * confirmButton;
/** 取消按钮 */
@property (nonatomic,strong)UIButton * cancelButton;
/** 返回的字符串 */
@property (nonatomic,strong)NSString * returnString;
@end

@implementation SetingPopupView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:COLOR(0, 0, 0, 0.5)];
        [self setSubViewAutoLayout];
        [self.pickerView reloadAllComponents];
    }
    return self;
}

- (void)setType:(NSInteger)type{
    _type = type;
    [self.pickerView reloadAllComponents];
    if (_type ==1) {
        self.returnString = @"1公里";
    }else if (_type ==2){
        self.returnString = @"本市全境";
    }else if (_type ==3){
        self.returnString = @"货物破损";
    }
}

#pragma mark - 点击事件
/** 点击底部确认、取消按钮调用方法 */
- (void)clickSelectButton:(UIButton *)send{
    if (send.tag ==1) {
        if ([self.delegate respondsToSelector:@selector(clickSelectButton:selectObj:)]) {
            [self.delegate clickSelectButton:self.type selectObj:self.returnString];
            [self removeFromSuperview];
        }
    }else{
        [self removeFromSuperview];
        return;
    }
}
#pragma mark - pickView代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.type ==1) {
        return 3;
    }else if(self.type ==2){
        return 1;
    }else if (self.type==3){
        return 4;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (self.type ==1) {
        return @[@"1公里",@"5公里",@"20公里"][row];
    }else if(self.type ==2) {
        return @"本市全境";
    }else if (self.type ==3){
        return  @[@"货物破损",@"货物少件",@"客户不签收",@"其他"][row];
    }
    return nil;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.type ==1) {
        self.returnString = @[@"1公里",@"5公里",@"20公里"][row];
    }else if(self.type ==2){
        self.returnString = @"本市全境";
    }else if (self.type ==3){
        self.returnString = @[@"货物破损",@"货物少件",@"客户不签收",@"其他"][row];
    }
}



#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(300);
        make.centerX.equalTo(weakself.mas_centerX);
        make.centerY.equalTo(weakself.mas_centerY);
    }];
    
    [weakself.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(20);
    }];
    
    [weakself.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.bgView.mas_centerX);
        make.top.equalTo(weakself.hintLabel.mas_bottom).offset(20);
        make.width.offset(200);
        make.height.offset(160);
    }];
    
    UILabel * line1 = [[UILabel alloc]init];
    line1.backgroundColor = COLOR(100, 100, 100, 1);
    [self.bgView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(weakself.pickerView.mas_bottom).offset(20);
        make.height.offset(1);
    }];
    UILabel * line2 = [[UILabel alloc]init];
    line2.backgroundColor = COLOR(199, 199, 199, 1);
    [self.bgView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.centerX.equalTo(weakself.bgView.mas_centerX);
        make.width.offset(1);
        make.height.offset(60);
    }];
    
    [weakself.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.bottom.offset(0);
        make.height.offset(60);
        make.right.equalTo(line2.mas_left).offset(0);
    }];
    
    [weakself.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.bottom.offset(0);
        make.left.equalTo(line2.mas_right).offset(0);
        make.height.offset(60);
    }];
}
#pragma mark - 懒加载
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = White_Color;
        _bgView.layer.cornerRadius = 10;
        _bgView.layer.masksToBounds = YES;
        [self addSubview:_bgView];
    }
    return _bgView;
}

- (UILabel *)hintLabel{
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc]init];
        _hintLabel.text = @"请选择";
        _hintLabel.textColor = Black_Color;
        [self.bgView addSubview:_hintLabel];
    }
    return _hintLabel;
}
- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [self.bgView addSubview:_pickerView];
    }
    return _pickerView;
}

- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:Black_Color forState:UIControlStateNormal];
        _confirmButton.tag = 1;
        [_confirmButton addTarget:self action:@selector(clickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:_confirmButton];
    }
    return _confirmButton;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:Black_Color forState:UIControlStateNormal];
        _cancelButton.tag = 2;
        [_cancelButton addTarget:self action:@selector(clickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:_cancelButton];
    }
    return _cancelButton;
}


@end
