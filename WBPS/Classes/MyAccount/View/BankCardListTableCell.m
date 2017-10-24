//
//  BankCardListTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/28.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "BankCardListTableCell.h"

@interface BankCardListTableCell ()

@property (nonatomic,strong)UIView * bgView;
/** 银行图标 */
@property (nonatomic,strong)UIImageView * bankImage;
/** 银行卡名字 */
@property (nonatomic,strong)UILabel * bankName;
/** 银行卡号 */
@property (nonatomic,strong)UILabel * cardNumber;

@end

@implementation BankCardListTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR(222, 222, 222, 1);
        [self setSubViewAutoLayout];
    }
    return self;
}
#pragma mark - 设置数据
- (void)setModel:(BankListModel *)model{
    _model = model;
    self.bankName.text = _model.bankname;
    self.cardNumber.text = _model.bankcode;
    NSString * imageString = [NSString stringWithFormat:@"icon_bank_%@",_model.bankname];
    self.bankImage.image = [UIImage imageNamed:imageString];
    
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.offset(-5);
    }];
    
    [weakself.bankImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17);
        make.top.offset(14);
        make.width.height.offset(20);
    }];
    
    [weakself.bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.bankImage.mas_centerY);
        make.left.equalTo(weakself.bankImage.mas_right).offset(10);
    }];
    
    [weakself.cardNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.bankName.mas_left);
        make.bottom.offset(-12);
    }];
    
}
#pragma mark - 懒加载
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = White_Color;
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}
- (UIImageView *)bankImage{
    if (!_bankImage) {
        _bankImage = [UIImageView imageViewWithImageName:@""];
        [self.bgView addSubview:_bankImage];
    }
    return _bankImage;
}
- (UILabel *)bankName{
    if (!_bankName) {
        _bankName = [UILabel labelWithText:@"工商银行" atColor:Black_Color atTextSize:16 atTextFontForType:@""];
        [self.bgView addSubview:_bankName];
    }
    return _bankName;
}
- (UILabel *)cardNumber{
    if (!_cardNumber) {
        _cardNumber = [UILabel labelWithText:@"**** **** **** 5278" atColor:Black_Color atTextSize:13 atTextFontForType:@""];
        [self.bgView addSubview:_cardNumber];
    }
    return _cardNumber;
}

@end
