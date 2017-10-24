//
//  CenterHeaderBottomView.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/25.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "CenterHeaderBottomView.h"

@interface CenterHeaderBottomView()




@end

@implementation CenterHeaderBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:White_Color];
        [self setSubViewAutoLayout];
    }
    return self;
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.mas_centerX);
        make.top.offset(10);
    }];
    [weakself.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.mas_centerX);
        make.bottom.offset(-10);
    }];
}

#pragma mark - 懒加载
- (UILabel *)hintLabel{
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc]init];
        _hintLabel.textColor = Black_Color;
        _hintLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_hintLabel];
    }
    return _hintLabel;
}

- (UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc]init];
        _valueLabel.textColor = Red_Color;
        _valueLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:_valueLabel];
    }
    return _valueLabel;
}



@end
