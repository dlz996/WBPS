//
//  suspensionView.m
//  悬浮球
//
//  Created by 董立峥 on 2017/9/29.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "SuspensionView.h"

@interface SuspensionView ()
/** 用户上下班状态 */
@property (nonatomic,strong)UILabel * userState;
/** 车辆状态 */
@property (nonatomic,strong)UILabel * carState;
/** 背景视图 */
@property (nonatomic,strong)UIView * bgView;

@end

@implementation SuspensionView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        /** 拖拽手势 */
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(movedView:)];
        [self addGestureRecognizer:pan];
        /** 点击事件 */
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickViewGesture:)];
        [self addGestureRecognizer:tap];
        [self setSubViewAutoLayout];
    }
    return self;
}

- (void)setCarStateType:(NSString *)carStateType{
    _carStateType = carStateType;
    self.carState.text = _carStateType;
}

#pragma mark - 手势
/** 点击 */
- (void)clickViewGesture:(UITapGestureRecognizer *)sendGesture{
    if ([self.delegate respondsToSelector:@selector(clickSuspensionView)]) {
        [self.delegate clickSuspensionView];
    }
}
/** 拖拽手势 */
- (void)movedView:(UIPanGestureRecognizer *)sendGesture{
    if ( sendGesture.state == UIGestureRecognizerStateEnded || sendGesture.state == UIGestureRecognizerStateCancelled ){
        CGFloat centerX = SCREEN_WIDTH/2;
        [UIView animateWithDuration:0.5 animations:^{
            if (sendGesture.view.center.x>centerX){
                sendGesture.view.center = CGPointMake(SCREEN_WIDTH, sendGesture.view.center.y);
             }else{
                 sendGesture.view.center = CGPointMake(0, sendGesture.view.center.y);
             }
        }];
    }
    CGPoint translation = [sendGesture translationInView:self.superview];
    CGPoint newCenter = CGPointMake(sendGesture.view.center.x+ translation.x,sendGesture.view.center.y + translation.y);//    限制屏幕范围：
    newCenter.y = MAX(sendGesture.view.frame.size.height/2, newCenter.y);
    newCenter.y = MIN(self.superview.frame.size.height - sendGesture.view.frame.size.height/2,  newCenter.y);
    newCenter.x = MAX(sendGesture.view.frame.size.width/2-35, newCenter.x);
    newCenter.x = MIN(self.superview.frame.size.width - sendGesture.view.frame.size.width/2+35,newCenter.x);
    sendGesture.view.center = newCenter;
    [sendGesture setTranslation:CGPointZero inView:self.superview];
}

#pragma mark - 约束
- (void)setSubViewAutoLayout{
    __weak typeof(&*self) weakself = self;
    [weakself.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(2.5);
        make.top.offset(2.5);
        make.width.height.offset(65);
    }];
    [weakself.userState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.bgView.mas_centerX);
        make.top.equalTo(weakself.bgView.mas_top).offset(10);
    }];
    [weakself.carState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.bgView.mas_centerX);
        make.bottom.equalTo(weakself.bgView.mas_bottom).offset(-10);
    }];
}

#pragma mark - 懒加载
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.layer.cornerRadius = 32.5;
        _bgView.layer.masksToBounds = YES;
        _bgView.backgroundColor = [UIColor colorWithRed:45/255.0 green:85/255.0 blue:139/255.0 alpha:1];
        [self addSubview:self.bgView];
    }
    return _bgView;
}
- (UILabel *)userState{
    if (!_userState) {
        _userState = [[UILabel alloc]init];
        _userState.text = @"上班";
        _userState.font = [UIFont systemFontOfSize:16];
        _userState.textColor = [UIColor whiteColor];
        [self.bgView addSubview:_userState];
    }
    return _userState;
}
- (UILabel *)carState{
    if (!_carState) {
        _carState = [[UILabel alloc]init];
        _carState.text = @"空载";
        _carState.font = [UIFont systemFontOfSize:16];
        _carState.textColor = [UIColor whiteColor];
        [self.bgView addSubview:_carState];
    }
    return _carState;
}


@end
