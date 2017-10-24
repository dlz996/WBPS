//
//  RecordTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/12.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "RecordTableCell.h"

@interface RecordTableCell ()
/** 订单编号 */
@property (nonatomic,strong)UILabel * orderNo;
/** 订单时间 */
@property (nonatomic,strong)UILabel * orderTime;
/** 订单金额 */
@property (nonatomic,strong)UILabel * money;
/** 随机图标 */
@property (nonatomic,strong)UIImageView * icon;
@end

@implementation RecordTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubViewAutoLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
#pragma mark - 设置数据
- (void)setModel:(RecordModel *)model{
   
    _model = model;
    self.orderTime.text = _model.billdate;
    self.money.text = _model.acc;
}

#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    
    [weakself.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(12.5);
        make.bottom.offset(-12.5);
        make.width.height.offset(30);
    }];
    
    [weakself.orderNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.icon.mas_right).offset(10);
        make.top.equalTo(weakself.icon.mas_top);
    }];
    
    [weakself.orderTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.orderNo.mas_left);
        make.top.equalTo(weakself.orderNo.mas_bottom).offset(1);
    }];
    
    [weakself.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.equalTo(weakself.orderNo.mas_top);
    }];
    
    UIImageView * line = [UIImageView horizontalSeparateImageView];
    [weakself.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(1);
    }];
}

#pragma mark - 懒加载
- (UILabel *)orderNo{
    if (!_orderNo) {
        _orderNo = [UILabel labelWithText:@"20170728085636331895" atColor:Black_Color atTextSize:16 atTextFontForType:@""];
        [self.contentView addSubview:_orderNo];
    }
    return _orderNo;
}
- (UILabel *)orderTime{
    if (!_orderTime) {
        _orderTime = [UILabel labelWithText:@"2017-08-08 18:00" atColor:FontGray_Color atTextSize:14 atTextFontForType:@""];
        [self.contentView addSubview:_orderTime];
    }
    return _orderTime;
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [UIImageView imageViewWithImageName:@""];
        _icon.layer.cornerRadius = 15;
        _icon.layer.masksToBounds = YES;
        NSInteger type = arc4random()%3;
        NSString * imageString = @[@"_0001_i",@"_0002_i",@"_0003_i"][type];
        _icon.image = [UIImage imageNamed:imageString];
        [self.contentView addSubview:_icon];
    }
    return _icon;
}
- (UILabel *)money{
    if (!_money) {
        _money = [UILabel labelWithText:@"165" atColor:Black_Color atTextSize:18 atTextFontForType:@"Arial-BoldMT"];
        [self.contentView addSubview:_money];
    }
    return _money;
}


@end
