//
//  MyBankCardFootView.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/28.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "MyBankCardFootView.h"

@implementation MyBankCardFootView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = White_Color;
        [self setSubViewAutoLayout];
    }
    return self;
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.mas_centerY);
        make.left.offset(SCRXFrom6(17.5));
        make.width.height.offset(20);
    }];
    
    [weakself.hintTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.iconView.mas_right).offset(SCRXFrom6(20));
        make.centerY.equalTo(weakself.mas_centerY);
    }];
}

#pragma mark - 懒加载
- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"add"]];
        [self addSubview:_iconView];
    }
    return _iconView;
}
- (UILabel *)hintTitle{
    if (!_hintTitle) {
        _hintTitle = [UILabel labelWithText:@"添加银行卡" atColor:Black_Color atTextSize:16 atTextFontForType:@""];
        [self addSubview:_hintTitle];
    }
    return _hintTitle;
}


@end
