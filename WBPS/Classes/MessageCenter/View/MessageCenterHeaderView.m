//
//  MessageCenterHeaderView.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/14.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "MessageCenterHeaderView.h"

@interface MessageCenterHeaderView ()
/** 公告按钮 */
@property (nonatomic,strong)UIButton * leftButton;
/** 消息按钮 */
@property (nonatomic,strong)UIButton * rightButton;
/** 选中按钮 */
@property (nonatomic,strong)UIButton * selectButton;
/** 底部滚动条 */
@property (nonatomic,strong)UILabel * barLabel;

@end

@implementation MessageCenterHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubViewAutoLayout];
        self.selectButton = self.leftButton;
        [self addSubview:self.barLabel];

    }
    return self;
}
- (void)setType:(NSInteger)type{
    _type = type;
    
    UIButton * button = (UIButton *)[self viewWithTag:_type];

    
    [self.selectButton setTitleColor:COLOR(166,166,166,1) forState:UIControlStateNormal];
    self.selectButton = button;
    [self.selectButton setTitleColor:COLOR(101,148,218,1) forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.barLabel.center = CGPointMake(self.selectButton.center.x, self.barLabel.center.y);
    }];
    
}

#pragma mark - 点击方法
- (void)clickButton:(UIButton *)send{
    [self.selectButton setTitleColor:COLOR(166,166,166,1) forState:UIControlStateNormal];
    self.selectButton = send;
    [self.selectButton setTitleColor:COLOR(101,148,218,1) forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.barLabel.center = CGPointMake(self.selectButton.center.x, self.barLabel.center.y);
    }];
    if ([self.delegate respondsToSelector:@selector(changeView:)]) {
        [self.delegate changeView:send.tag];
    }
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0).priorityHigh(750);
        make.width.offset(SCREEN_WIDTH/2);
    }];
    
    [weakself.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.offset(0).priorityHigh(750);
        make.width.offset(SCREEN_WIDTH/2);
    }];
}

#pragma mark - 懒加载
- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithTitle:@"公告" atTitleSize:16 atTitleColor:COLOR(101,148,218,1) atTarget:self atAction:@selector(clickButton:)];
        _leftButton.tag = 1;
        [self addSubview:_leftButton];
    }
    return _leftButton;
}
- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithTitle:@"消息" atTitleSize:16 atTitleColor:COLOR(166,166,166,1) atTarget:self atAction:@selector(clickButton:)];
        _rightButton.tag = 2;
        [self addSubview:_rightButton];
    }
    return _rightButton;
}
- (UILabel *)barLabel{
    if (!_barLabel) {
        _barLabel = [[UILabel alloc]init];
        _barLabel.frame = CGRectMake(0, 58, SCREEN_WIDTH/2, 2);
        _barLabel.backgroundColor = COLOR(34, 114, 230, 1);
        [self addSubview:_barLabel];
    }
    return _barLabel;
}

@end
