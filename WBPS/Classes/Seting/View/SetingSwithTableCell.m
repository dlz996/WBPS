//
//  SetingSwithTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/26.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "SetingSwithTableCell.h"

@interface SetingSwithTableCell ()
@end

@implementation SetingSwithTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setSubViewAutoLayout];
    }
    return self;
}

- (void)setSwitchState:(NSString *)switchState{
    _switchState = switchState;
    if ([_switchState isEqualToString:@"0"]) {
        self.switchBtn.on = NO;
    }else{
        self.switchBtn.on = YES;
    }
}

#pragma mark - 点击方法
- (void)swithValueChange:(UISwitch *)sendSwitch{
    NSString * state = sendSwitch.on==YES?@"1":@"0";
    if ([self.delegate respondsToSelector:@selector(switchValueChangeWithIndexPath:withState:)]) {
        [self.delegate switchValueChangeWithIndexPath:self.cellIndexPath withState:state];
    }
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.equalTo(weakself.contentView.mas_centerY);
    }];
    
    [weakself.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.titleLabel.mas_centerY);
        make.right.offset(-15);
    }];
    
    UILabel * line = [[UILabel alloc]init];
    line.backgroundColor = LineGray_Color;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(1);
    }];
}
#pragma mark - 懒加载
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = Black_Color;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UISwitch *)switchBtn{
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc]init];
        _switchBtn.transform= CGAffineTransformMakeScale(0.85,0.75);
        _switchBtn.onTintColor = COLOR(42, 194, 217, 1);
        [_switchBtn addTarget:self action:@selector(swithValueChange:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_switchBtn];
    }
    return _switchBtn;
}


@end
