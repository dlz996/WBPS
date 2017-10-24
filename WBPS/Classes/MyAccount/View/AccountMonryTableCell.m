//
//  AccountMonryTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/25.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "AccountMonryTableCell.h"

@interface AccountMonryTableCell ()

/** 账户余额提示文本 */
@property (nonatomic,strong)UILabel * hintLabel;
/** 余额文本 */
@property (nonatomic,strong)UILabel * moneyLabel;
/** 标记按钮 */
@property (nonatomic,strong)UIImageView * signImageView;

@end

@implementation AccountMonryTableCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setSubViewAutoLayout];
    }
    return self;
}
- (void)setModel:(AccountMoneyModel *)model{
    _model = model;
    if ([_model.acc isEqualToString:@""] || _model.acc == nil || _model.acc == NULL) {
        _model.acc = @"0.00";
    }
    NSString * moneyString = [NSString stringWithFormat:@"%@元",_model.acc];
    NSMutableAttributedString * attString = [[NSMutableAttributedString alloc]initWithString:moneyString];
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(attString.length-1, 1)];
    _moneyLabel.attributedText = attString;
}

#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(15);
    }];
    
    [weakself.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.bottom.offset(-20);
    }];
    
    [weakself.signImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.moneyLabel.mas_bottom).offset(-2);
        make.right.offset(-25);
        make.width.offset(13);
        make.height.offset(20);
    }];

}


#pragma Mark - 懒加载
- (UILabel *)hintLabel{
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc]init];
        _hintLabel.text = @"账户余额";
        _hintLabel.textColor = Black_Color;
        _hintLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_hintLabel];
    }
    return _hintLabel;
}
- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.textColor = Red_Color;
        _moneyLabel.font = [UIFont systemFontOfSize:30];
        NSMutableAttributedString * attString = [[NSMutableAttributedString alloc]initWithString:@"0.00元"];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(attString.length-1, 1)];
        _moneyLabel.attributedText = attString;
        [self.contentView addSubview:_moneyLabel];
    }
    return _moneyLabel;
}

- (UIImageView *)signImageView{
    if (!_signImageView) {
        _signImageView = [[UIImageView alloc]init];
        [_signImageView setImage:[UIImage imageNamed:@"jiaobiao"]];
        [self.contentView addSubview:_signImageView];
    }
    return _signImageView;
}




@end
