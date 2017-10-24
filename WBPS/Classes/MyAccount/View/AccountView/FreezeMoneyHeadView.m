//
//  FreezeMoneyHeadView.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/11.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "FreezeMoneyHeadView.h"

@interface FreezeMoneyHeadView ()

/** 蓝色背景视图 */
@property (nonatomic,strong)UIView * blueBgView;
/** 标题 */
@property (nonatomic,strong)UILabel * hintLabel;
/** 锁图片 */
@property (nonatomic,strong)UIImageView * lockImageView;
/** 全部冻结金额 */
@property (nonatomic,strong)UILabel * allMoney;

@end

@implementation FreezeMoneyHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = COLOR(243, 244, 245, 1);
        [self setSubViewAutoLayout];
    }
    return self;
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    
    [weakself.blueBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
    
    [weakself.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.blueBgView.mas_centerX);
        make.top.offset(30);
    }];
    
    [weakself.allMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.blueBgView.mas_centerX);
        make.top.equalTo(weakself.hintLabel.mas_bottom).offset(5);
    }];
    
    [weakself.lockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(20);
        make.width.height.offset(80);
    }];
    
    
}

#pragma mark - 懒加载
- (UIView *)blueBgView{
    if (!_blueBgView) {
        _blueBgView = [[UIView alloc]init];
        _blueBgView.backgroundColor = COLOR(34, 114, 231, 1);
        [self addSubview:_blueBgView];
    }
    return _blueBgView;
}

- (UILabel *)hintLabel{
    if (!_hintLabel){
        _hintLabel = [UILabel labelWithText:@"冻结金额" atColor:White_Color atTextSize:16 atTextFontForType:@""];
        [self.blueBgView addSubview:_hintLabel];
    }
    return _hintLabel;
}
- (UILabel *)allMoney{
    if (!_allMoney) {
        _allMoney = [UILabel labelWithText:@"0元" atColor:White_Color atTextSize:30 atTextFontForType:@""];
        [self.blueBgView addSubview:_allMoney];
    }
    return _allMoney;
}
- (UIImageView *)lockImageView{
    if (!_lockImageView) {
        _lockImageView = [UIImageView imageViewWithImageName:@"lock"];
        [self.blueBgView addSubview:_lockImageView];
    }
    return _lockImageView;
}

@end
