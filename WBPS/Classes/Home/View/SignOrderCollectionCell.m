
//
//  SignOrderCollectionCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/29.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "SignOrderCollectionCell.h"

@implementation SignOrderCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubViewAutoLayout];
    }
    return self;
}
/** 点击移除按钮 */
- (void)clickRemoButton{
    if ([self.delegate respondsToSelector:@selector(remoImageOf:)]){
        [self.delegate remoImageOf:self.indexPath];
    }
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
        make.bottom.right.offset(-10);
    }];
    
    [weakself.remoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.selectImage.mas_right);
        make.centerY.equalTo(weakself.selectImage.mas_top);
        make.width.height.offset(20);
    }];
    
}

#pragma mark - 懒加载
- (UIImageView *)selectImage{
    if (!_selectImage) {
        _selectImage = [UIImageView imageViewWithImageName:@""];
        _selectImage.backgroundColor = White_Color;
        _selectImage.layer.cornerRadius = 5;
        _selectImage.layer.masksToBounds = YES;
        _selectImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_selectImage];
    }
    return _selectImage;
}
- (UIButton *)remoButton{
    if (!_remoButton) {
        _remoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_remoButton addTarget:self action:@selector(clickRemoButton) forControlEvents:UIControlEventTouchUpInside];
        [_remoButton setBackgroundImage:[UIImage imageNamed:@"remo"] forState:UIControlStateNormal];
        [self.contentView addSubview:_remoButton];
    }
    return _remoButton;
}

@end
