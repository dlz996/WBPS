//
//  LoginPopupHintView.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/27.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "LoginPopupHintView.h"

@interface LoginPopupHintView ()
/** 提示图片 */
@property (nonatomic,strong)UIImageView * hintImage;
/** 取消按钮 */
@property (nonatomic,strong)UIButton * cancelButton;
/** 确定按钮 */
@property (nonatomic,strong)UIButton * confirmButton;
@end

@implementation LoginPopupHintView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:COLOR(0, 0, 0, 0.4)];
        [self setSubViewAutoLayout];
    }
    return self;
}
- (void)setType:(NSInteger)type{
    _type = type;
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@[@"identity_card",@"drivingOne",@"drivingTow",@"Operation"][type]]];
    self.hintImage.image = image;
}

#pragma mark - 点击方法
- (void)clickButton:(UIButton *)send{
    if (send.tag ==1) {
        [self removeFromSuperview];
    }else if (send.tag ==2){
        if ([self.delegate respondsToSelector:@selector(confirmSelectPhoto)]){
            [self.delegate confirmSelectPhoto];
        }
    }
}

#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.top.offset(15);
        make.width.height.offset(40);
    }];
    
    [weakself.hintImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SCRXFrom6(17.5));
        make.right.offset(SCRXFrom6(-17.5));
        make.height.offset(SCRYFrom6(190));
        make.top.equalTo(weakself.cancelButton.mas_bottom).offset(SCRYFrom6(25));
    }];
    
    [weakself.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.hintImage.mas_bottom).offset(110);
        make.centerX.equalTo(weakself.mas_centerX);
        make.height.offset(45);
        make.left.offset(SCRXFrom6(17.5));
        make.right.offset(SCRXFrom6(-17.5));
    }];
    
    
}

#pragma mark - 懒加载
- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setBackgroundColor:COLOR(127, 131, 140, 1)];
        [_cancelButton setImage:[UIImage imageNamed:@"cancel_coupon_pay"] forState:UIControlStateNormal];
        _cancelButton.tag = 1;
        [_cancelButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (UIImageView *)hintImage{
    if (!_hintImage) {
        _hintImage = [[UIImageView alloc]init];
        [self addSubview:_hintImage];
    }
    return _hintImage;
}

- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"知道了，我要上传照片" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:White_Color forState:UIControlStateNormal];
        [_confirmButton setBackgroundColor:COLOR(40, 76, 103, 0.8)];
        _confirmButton.tag = 2;
        [_confirmButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_confirmButton];
    }
    return _confirmButton;
}

@end
