//
//  HomeCarStateView.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/10.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "HomeCarStateView.h"

@interface HomeCarStateView ()
/** 背景视图 */
@property (nonatomic,strong)UIView * bgView;
/** 标题文本 */
@property (nonatomic,strong)UILabel * titleLabel;

/** 体积背景视图 */
@property (nonatomic,strong)UIView * volumnBgView;
/** 体积输入框 */
@property (nonatomic,strong)UITextField * volumnTextField;
/** 体积输入框左视图 */
@property (nonatomic,strong)UILabel * volumnLeftLabel;
/** 体积输入框右视图 */
@property (nonatomic,strong)UILabel * volumnRightLabel;

/** 载重背景视图 */
@property (nonatomic,strong)UIView * freeweightBgView;
/** 重量输入框 */
@property (nonatomic,strong)UITextField * freeweightTextField;
/** 重量左视图 */
@property (nonatomic,strong)UILabel * freeweightLeftLabel;
/** 重量右视图 */
@property (nonatomic,strong)UILabel * freeweightRightLabel;
/** 取消按钮 */
@property (nonatomic,strong)UIButton * cancleButton;
/** 确认按钮 */
@property (nonatomic,strong)UIButton * confirmButton;


@end

@implementation HomeCarStateView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setBackgroundColor:COLOR(0, 0, 0, 0.5)];
        [self setSubViewAutoLayout];
    }
    return self;
}
/** 点击按钮 */
- (void)clickBottomButton:(UIButton *)send{
    if (send.tag ==1) {
        [self removeFromSuperview];
    }else{
        if ([self.volumnTextField.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请输入剩余体积"];
            return;
        }
        if ([self.freeweightTextField.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请输入剩余重量"];
            return;
        }
        if ([self.delegate respondsToSelector:@selector(remainingVolume:weight:)]) {
            [self.delegate remainingVolume:self.volumnTextField.text weight:self.freeweightTextField.text];
            [self removeFromSuperview];
        }
    }
}

#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    
    [weakself.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.mas_centerX);
        make.centerY.equalTo(weakself.mas_centerY);
        make.height.offset(215);
        make.width.offset(280);
       
        
    }];
    
    [weakself.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.bgView.mas_centerX);
        make.top.offset(15);
    }];
    
    [weakself.volumnTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.top.equalTo(weakself.titleLabel.mas_bottom).offset(15);
        make.height.offset(45);
    }];
    
    [weakself.freeweightTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.top.equalTo(weakself.volumnTextField.mas_bottom).offset(10);
        make.height.offset(45);
    }];
    

    UIImageView * horizontalLine = [UIImageView horizontalSeparateImageView];
    [self.bgView addSubview:horizontalLine];
    [horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(1);
        make.top.equalTo(weakself.freeweightTextField.mas_bottom).offset(15);
    }];
    
    UIImageView * verticalLine = [UIImageView horizontalSeparateImageView];
    [self.bgView addSubview:verticalLine];
    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.bgView.mas_centerX);
        make.top.equalTo(horizontalLine.mas_bottom);
        make.bottom.offset(0);
        make.width.offset(1);
    }];
    
    [weakself.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(horizontalLine.mas_bottom).offset(0);
        make.right.equalTo(verticalLine.mas_left).offset(0);
        make.height.offset(43);
    }];
    [weakself.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verticalLine.mas_right).offset(0);
        make.top.equalTo(horizontalLine.mas_bottom).offset(0);
        make.right.offset(0);
        make.height.offset(43);
    }];
    
}

#pragma mark - 懒加载
- (UIView *)bgView{
    if (!_bgView){
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = White_Color;
        [self addSubview:_bgView];
    }
    return _bgView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [UILabel labelWithText:@"剩余体积/重量" atColor:Black_Color atTextSize:16 atTextFontForType:@""];
        [self.bgView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)volumnLeftLabel{
    if (!_volumnLeftLabel) {
        _volumnLeftLabel = [UILabel labelWithText:@"  体积：" atColor:Black_Color atTextSize:16 atTextFontForType:@""];
        _volumnLeftLabel.bounds = CGRectMake(0, 0, 60, 30);
    }
    return _volumnLeftLabel;
}
- (UILabel *)volumnRightLabel{
    if (!_volumnRightLabel) {
        _volumnRightLabel = [UILabel labelWithText:@"立方米" atColor:Black_Color atTextSize:16 atTextFontForType:@""];
        _volumnRightLabel.bounds = CGRectMake(0, 0, 60, 30);
    }
    return _volumnRightLabel;
}
- (UITextField *)volumnTextField{
    if (!_volumnTextField) {
        _volumnTextField = [UITextField textFieldWithText:@""];
        _volumnTextField.backgroundColor = COLOR(237, 237, 237, 1);
        _volumnTextField.leftView = self.volumnLeftLabel;
        _volumnTextField.leftViewMode = UITextFieldViewModeAlways;
        _volumnTextField.rightView = self.volumnRightLabel;
        _volumnTextField.rightViewMode = UITextFieldViewModeAlways;
        _volumnTextField.font = [UIFont systemFontOfSize:20];
        _volumnTextField.keyboardType =UIKeyboardTypeDecimalPad;
        [self.bgView addSubview:_volumnTextField];
    }
    return _volumnTextField;
}
- (UILabel *)freeweightLeftLabel{
    if (!_freeweightLeftLabel) {
        _freeweightLeftLabel = [UILabel labelWithText:@"  重量：" atColor:Black_Color atTextSize:16 atTextFontForType:@""];
        _freeweightLeftLabel.bounds = CGRectMake(0, 0, 60, 30);
    }
    return _freeweightLeftLabel;
}
- (UILabel *)freeweightRightLabel{
    if (!_freeweightRightLabel) {
        _freeweightRightLabel = [UILabel labelWithText:@"吨" atColor:Black_Color atTextSize:16 atTextFontForType:@""];
        _freeweightRightLabel.bounds = CGRectMake(0, 0, 28, 30);
    }
    return _freeweightRightLabel;
}
- (UITextField *)freeweightTextField{
    if (!_freeweightTextField) {
        _freeweightTextField = [UITextField textFieldWithText:@""];
        _freeweightTextField.backgroundColor = COLOR(237, 237, 237, 1);
        _freeweightTextField.leftView = self.freeweightLeftLabel;
        _freeweightTextField.leftViewMode = UITextFieldViewModeAlways;
        _freeweightTextField.rightView = self.freeweightRightLabel;
        _freeweightTextField.rightViewMode = UITextFieldViewModeAlways;
        _freeweightTextField.font = [UIFont systemFontOfSize:20];
        _freeweightTextField.keyboardType =UIKeyboardTypeDecimalPad;
        [self.bgView addSubview:_freeweightTextField];
    }
    return _freeweightTextField;
}

- (UIButton *)cancleButton{
    if (!_cancleButton){
        _cancleButton = [UIButton buttonWithTitle:@"取消" atTitleSize:16 atTitleColor:COLOR(126,126,126,1) atTarget:self atAction:@selector(clickBottomButton:)];
        _cancleButton.tag = 1;
        [self.bgView addSubview:_cancleButton];
    }
    return _cancleButton;
}

- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithTitle:@"确定" atTitleSize:16 atTitleColor:COLOR(63,115,190,1) atTarget:self atAction:@selector(clickBottomButton:)];
        _confirmButton.tag = 2;
        [self.bgView addSubview:_confirmButton];
    }
    return _confirmButton;
}


@end
