//
//  OrderInfoTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/22.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "OrderInfoTableCell.h"

@interface OrderInfoTableCell ()

/** 背景视图 */
@property (nonatomic,strong)UIView * bgView;
/** 运单号 */
@property (nonatomic,strong)UILabel * waybillNumber;
/** 运单号编号 */
@property (nonatomic,strong)UILabel * waybillValue;
/** 订单状态文本 */
@property (nonatomic,strong)UILabel * orderStater;
/** 运单信息标题 */
@property (nonatomic,strong)UILabel * orderTitle;
/** 运单信息详情 */
@property (nonatomic,strong)UILabel * orderInfo;
/** 订单时间标题 */
@property (nonatomic,strong)UILabel * timeTitle;
/** 订单时间详情 */
@property (nonatomic,strong)UILabel * timeInfo;
/** 提付标题 */
@property (nonatomic,strong)UILabel * extractMoneyTitle;
/** 提付详情 */
@property (nonatomic,strong)UILabel * extractMoneyInfo;
/** 代收标题 */
@property (nonatomic,strong)UILabel * replaceMoneyTitle;
/** 代收详情 */
@property (nonatomic,strong)UILabel * replaceMoneyInfo;
/** 回单要求标题 */
@property (nonatomic,strong)UILabel * orderAskTitle;
/** 回单要求详情 */
@property (nonatomic,strong)UILabel * orderAskInfo;
/** 出发地标题 */
@property (nonatomic,strong)UILabel * startLocationTitle;
/** 出发地详情 */
@property (nonatomic,strong)UILabel * startLocationInfo;
/** 目的地标题 */
@property (nonatomic,strong)UILabel * aimLocationTitle;
/** 目的地详情 */
@property (nonatomic,strong)UILabel * aimLocationInfo;
/** 带人卸货标题 */
@property (nonatomic,strong)UILabel * guideTitle;
/** 带人卸货详情 */
@property (nonatomic,strong)UILabel * guideInfo;
/** 上楼标题 */
@property (nonatomic,strong)UILabel * upstairsTitle;
/** 上楼详情 */
@property (nonatomic,strong)UILabel * upstairsInfo;
/** 加急标题 */
@property (nonatomic,strong)UILabel * urgentTitle;
/** 加急详情 */
@property (nonatomic,strong)UILabel * urgentInfo;

/** 拨号按钮 */
@property (nonatomic,strong)UIButton * callButton;
/** 拨号背景视图 */
@property (nonatomic,strong)UIView * callBGView;
/** 拨号用户名称 */
@property (nonatomic,strong)UILabel * callUser;

@end

@implementation OrderInfoTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = COLOR(243, 244, 245, 1);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setSubViewAutoLayout];
    }
    return self;
}
#pragma mark - 数据处理
- (void)setModel:(TaskInfoModel *)model{
    _model = model;
    
    self.waybillValue.text = _model.unit;
   
    //出发状态
    if ([_model.orderstate isEqualToString:@"0"]) {
        self.orderStater.text = @"待出发";
    }else if ([_model.orderstate isEqualToString:@"3"]){
        self.orderStater.text = @"出发中";
     }else if([_model.orderstate isEqualToString:@"4"]){
        self.orderStater.text = @"待签收";
    }
    
    
    self.orderInfo.text = _model.product;
    
    self.extractMoneyInfo.text = _model.accarrived;
    self.replaceMoneyInfo.text = _model.accdaishou;
    
    self.timeInfo.text = _model.downdate;
    /** 回单要求 */
    self.orderAskInfo.text = _model.backqty;
    
    self.startLocationInfo.text = [NSString stringWithFormat:@"%@%@%@%@%@",_model.bsheng,_model.bcity,_model.barea,_model.btown,_model.baddress];
    
    self.aimLocationInfo.text = [NSString stringWithFormat:@"%@%@%@%@%@",_model.esheng,_model.ecity,_model.earea,_model.etown,_model.eaddress];
    

    if ([_model.unload isEqualToString:@""] || _model.unload ==NULL || _model.unload.length<=0) {
        self.guideInfo.text = @"否";
    }else{
        self.guideInfo.text = _model.unload;
    }
    if ([_model.upstairs isEqualToString:@""] || _model.upstairs ==NULL || _model.upstairs.length<=0) {
        self.upstairsInfo.text = @"否";
    }else{
        self.upstairsInfo.text = _model.upstairs;
    }
    if ([_model.urgent isEqualToString:@""] || _model.urgent == NULL || _model.urgent.length<=0) {
        self.urgentInfo.text = @"否";
    }else{
        self.urgentInfo.text = _model.urgent;  //加急
    }
    
    self.callUser.text = _model.consignee;
}

#pragma mark - 点击方法
- (void)clickCall{
    NSString * tellString = [NSString stringWithFormat:@"tel:%@",self.model.consigneemb];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tellString]];
}

#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
        make.right.offset(-10);
        make.bottom.offset(0);
    }];

    [weakself.orderStater mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.waybillValue.mas_centerY);
        make.right.offset(-10).priorityHigh(700);
//        make.left.equalTo(weakself.waybillValue.mas_right).offset(10);
    }];
    
    [weakself.waybillNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(15);
        make.width.offset(70);
    }];
    
    [weakself.waybillValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.waybillNumber.mas_right).offset(2);
        make.right.offset(-10);
        make.top.equalTo(weakself.waybillNumber.mas_top);
    }];
    
   
  
    UILabel * line1 = [self makeLabel];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.waybillNumber.mas_left);
        make.right.offset(-10);
        make.height.offset(1);
        make.top.equalTo(weakself.waybillNumber.mas_bottom).offset(15);
    }];
    
    [weakself.orderTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(15);
        make.left.equalTo(weakself.waybillNumber.mas_left);
        make.height.offset(17);
    }];
    
    [weakself.orderInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.orderTitle.mas_right).offset(7);
        make.top.equalTo(weakself.orderTitle.mas_top);
        make.height.offset(17);
    }];
    
    [weakself.timeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.orderTitle.mas_bottom).offset(10);
        make.left.equalTo(weakself.orderTitle.mas_left);
        make.height.offset(17);
    }];
    
    [weakself.timeInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.timeTitle.mas_right).offset(7);
        make.top.equalTo(weakself.timeTitle.mas_top);
        make.height.offset(17);
    }];
    
    [weakself.extractMoneyInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.orderTitle);
        make.right.offset(-10);
        make.height.offset(17);
    }];
    
    [weakself.extractMoneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.orderInfo);
        make.right.equalTo(weakself.extractMoneyInfo.mas_left).offset(-7);
        make.height.offset(17);
    }];
    
    [weakself.replaceMoneyInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.timeTitle);
        make.right.offset(-10);
        make.height.offset(17);
    }];
    
    [weakself.replaceMoneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.timeTitle);
        make.right.equalTo(weakself.replaceMoneyInfo.mas_left).offset(-7);
        make.height.offset(17);
    }];
    UILabel * line2 = [self makeLabel];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.waybillNumber.mas_left);
        make.right.offset(-10);
        make.height.offset(1);
        make.top.equalTo(weakself.timeTitle.mas_bottom).offset(15);
    }];
    
    [weakself.orderAskTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.waybillNumber.mas_left);
        make.top.equalTo(line2.mas_bottom).offset(15);
        make.height.offset(17);
    }];
    
    [weakself.orderAskInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.orderAskTitle);
        make.left.equalTo(weakself.orderAskTitle.mas_right).offset(7);
        make.height.offset(17);
        make.right.offset(-10);
    }];
    UILabel * line3 = [self makeLabel];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.orderAskTitle.mas_bottom).offset(15);
        make.left.equalTo(weakself.waybillNumber.mas_left);
        make.right.offset(-10);
        make.height.offset(1);
    }];
    
    [weakself.startLocationTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.waybillNumber.mas_left);
        make.top.equalTo(line3.mas_bottom).offset(15);
        make.height.offset(17);
    }];
    
    [weakself.startLocationInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.startLocationTitle).offset(-3);
        make.left.equalTo(weakself.startLocationTitle.mas_right).offset(7);
        make.right.offset(-15);
    }];
    
    [weakself.aimLocationTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.waybillNumber.mas_left);
        make.top.equalTo(weakself.startLocationInfo.mas_bottom).offset(10);
        make.height.offset(17);
        make.width.offset(55.5);
    }];
    
    [weakself.aimLocationInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.aimLocationTitle).offset(-3);
        make.left.equalTo(weakself.aimLocationTitle.mas_right).offset(7);
        make.right.offset(-15);
    }];
    UILabel * line4 = [self makeLabel];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.aimLocationInfo.mas_bottom).offset(15);
        make.left.equalTo(weakself.waybillNumber.mas_left);
        make.right.offset(-10);
        make.height.offset(1);
    }];
    
    [weakself.guideTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.waybillNumber.mas_left);
        make.top.equalTo(line4.mas_bottom).offset(15);
        make.height.offset(17);
    }];
    
    [weakself.guideInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.guideTitle.mas_right).offset(7);
        make.top.equalTo(weakself.guideTitle);
        make.height.offset(17);
    }];
    
    [weakself.upstairsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.bgView.mas_centerX).offset(-10);
        make.top.equalTo(weakself.guideTitle.mas_top);
        make.height.offset(17);
    }];
    [weakself.upstairsInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.upstairsTitle.mas_right).offset(7);
        make.top.equalTo(weakself.upstairsTitle);
        make.height.offset(17);
    }];
    
    [weakself.urgentInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.guideTitle.mas_top);
        make.right.offset(-10);
        make.height.offset(17);
    }];
    
    [weakself.urgentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.urgentInfo.mas_left).offset(-7);
        make.top.equalTo(weakself.guideTitle.mas_top);
        make.height.offset(17);
    }];
    UILabel * line5 = [self makeLabel];
    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.callButton.mas_top).offset(-5);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.offset(1);
    }];
    
    [weakself.callBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.bgView.mas_centerX);
        make.centerY.equalTo(weakself.bgView.mas_bottom).offset(-20);
        make.width.offset(300);
        make.height.offset(40);
    }];
    
    [weakself.callUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.bgView.mas_centerX);
        make.centerY.equalTo(weakself.callBGView.mas_centerY);
        make.height.offset(30);
    }];
    
    [weakself.callButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.callUser.mas_left).offset(-10);
        make.centerY.equalTo(weakself.callBGView.mas_centerY);
        make.width.offset(30);
        make.height.offset(30);
    }];
    
}

#pragma mark - 懒加载
/** 创建一个灰色背景色label用来做分割线 */
- (UILabel *)makeLabel{
    UILabel * label = [[UILabel alloc]init];
    label.backgroundColor = LineGray_Color;
    [self.bgView addSubview:label];
    return label;
}
/** 创建一个粗体Label */
- (UILabel *)makeTitleLabel{
    UILabel * label = [[UILabel alloc]init];
    UIFont *font =[UIFont boldSystemFontOfSize:18]; //粗体
    label.font = font;
    label.textColor = Black_Color;
    [self.bgView addSubview:label];
    return label;
}
/** 创建详情细体Label */
- (UILabel *)makeInfoLabel{
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = Black_Color;
    [self.bgView addSubview:label];
    return label;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.layer.cornerRadius = 10;
        _bgView.layer.masksToBounds = YES;
        _bgView.backgroundColor = White_Color;
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}

- (UILabel *)waybillNumber{
    if (!_waybillNumber) {
        _waybillNumber = [[UILabel alloc]init];
        UIFont *font =[UIFont boldSystemFontOfSize:20]; //粗体
        _waybillNumber.font = font;
        _waybillNumber.text = @"运单号:";
        _waybillNumber.textColor = Black_Color;
        [self.bgView addSubview:_waybillNumber];
    }
    return _waybillNumber;
}

- (UILabel *)waybillValue{
    if (!_waybillValue) {
        _waybillValue = [[UILabel alloc]init];
        UIFont *font =[UIFont boldSystemFontOfSize:20]; //粗体
        _waybillValue.font = font;
        _waybillValue.text = @"000000000";
        _waybillValue.numberOfLines = 0;
        _waybillValue.textColor = Black_Color;
        [self.bgView addSubview:_waybillValue];
    }
    return _waybillValue;
}

- (UILabel *)orderStater{
    if (!_orderStater) {
        _orderStater = [[UILabel alloc]init];
        _orderStater.textColor = COLOR(0, 189, 198, 1);
        [self.bgView addSubview:_orderStater];
    }
    return _orderStater;
}

- (UILabel *)orderTitle{
    if (!_orderTitle) {
        _orderTitle = [self makeTitleLabel];
        _orderTitle.text = @"运单信息";
    }
    return _orderTitle;
}

- (UILabel *)orderInfo{
    if (!_orderInfo) {
        _orderInfo = [self makeInfoLabel];
        _orderInfo.text = @"家居一箱纸";
    }
    return _orderInfo;
}

- (UILabel *)timeTitle{
    if (!_timeTitle) {
        _timeTitle = [self makeTitleLabel];
        _timeTitle.text = @"送达时间";
    }
    return _timeTitle;
}

- (UILabel *)timeInfo{
    if (!_timeInfo) {
        _timeInfo = [self makeInfoLabel];
        _timeInfo.text = @"未设定";
    }
    return _timeInfo;
}

- (UILabel *)extractMoneyTitle{
    if (!_extractMoneyTitle) {
        _extractMoneyTitle = [self makeTitleLabel];
        _extractMoneyTitle.text = @"提付";
    }
    return _extractMoneyTitle;
}

- (UILabel *)extractMoneyInfo {
    if (!_extractMoneyInfo) {
        _extractMoneyInfo = [self makeInfoLabel];
        _extractMoneyInfo.text = @"235";
    }
    return _extractMoneyInfo;
}

- (UILabel *)replaceMoneyTitle{
    if (!_replaceMoneyTitle) {
        _replaceMoneyTitle = [self makeTitleLabel];
        _replaceMoneyTitle.text = @"代收";
    }
    return _replaceMoneyTitle;
}

- (UILabel *)replaceMoneyInfo{
    if (!_replaceMoneyInfo) {
        _replaceMoneyInfo = [self makeInfoLabel];
        _replaceMoneyInfo.text = @"235";
    }
    return _replaceMoneyInfo;
}
- (UILabel *)orderAskTitle{
    if (!_orderAskTitle) {
        _orderAskTitle = [self makeTitleLabel];
        _orderAskTitle.text = @"回单要求";
    }
    return _orderAskTitle;
}
- (UILabel *)orderAskInfo{
    if (!_orderAskInfo) {
        _orderAskInfo = [self makeInfoLabel];
        _orderAskInfo.text = @"不能迟到";
    }
    return _orderAskInfo;
}
- (UILabel *)startLocationTitle{
    if (!_startLocationTitle) {
        _startLocationTitle = [self makeTitleLabel];
        _startLocationTitle.text = @"出发地";
    }
    return _startLocationTitle;
}

- (UILabel *)startLocationInfo{
    if (!_startLocationInfo) {
        _startLocationInfo = [self makeInfoLabel];
        _startLocationInfo.text = @"广东省广州市白云区石井街道石沙路294号";
        _startLocationInfo.numberOfLines = 0;
    }
    return _startLocationInfo;
}

- (UILabel *)aimLocationTitle{
    if (!_aimLocationTitle) {
        _aimLocationTitle = [self makeTitleLabel];
        _aimLocationTitle.text = @"目的地";
    }
    return _aimLocationTitle;
}

- (UILabel *)aimLocationInfo{
    if (!_aimLocationInfo) {
        _aimLocationInfo = [self makeInfoLabel];
        _aimLocationInfo.text = @"广东省广州市白云区石井街道石沙路b八方物流园D栋1-6号";
        _aimLocationInfo.numberOfLines = 0;
    }
    return _aimLocationInfo;
}

- (UILabel *)guideTitle{
    if (!_guideTitle) {
        _guideTitle = [self makeTitleLabel];
        _guideTitle.text = @"带人卸货";
    }
    return _guideTitle;
}

- (UILabel *)guideInfo{
    if (!_guideInfo) {
        _guideInfo = [self makeInfoLabel];
        _guideInfo.text = @"否";
    }
    return _guideInfo;
}

- (UILabel *)upstairsTitle{
    if (!_upstairsTitle) {
        _upstairsTitle  = [self makeTitleLabel];
        _upstairsTitle.text = @"上楼";
    }
    return _upstairsTitle;
}

- (UILabel *)upstairsInfo{
    if (!_upstairsInfo) {
        _upstairsInfo = [self makeInfoLabel];
        _upstairsInfo.text = @"否";
    }
    return _upstairsInfo;
}

- (UILabel *)urgentTitle{
    if (!_urgentTitle) {
        _urgentTitle = [self makeTitleLabel];
        _urgentTitle.text = @"加急";
    }
    return _urgentTitle;
}

- (UILabel *)urgentInfo{
    if (!_urgentInfo) {
        _urgentInfo = [self makeInfoLabel];
        _urgentInfo.text = @"否";
    }
    return _urgentInfo;
}

- (UIView *)callBGView{
    if (!_callBGView) {
        _callBGView = [[UIView alloc]init];
        _callBGView.backgroundColor = White_Color;
        _callBGView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCall)];
        [_callBGView addGestureRecognizer:tap];
        [self.bgView addSubview:_callBGView];
    }
    return _callBGView;
}

- (UILabel *)callUser{
    if (!_callUser) {
        _callUser = [[UILabel alloc]init];
        _callUser.textColor = FontGray_Color;
        _callUser.text = @"万晓尔";
        [self.callBGView addSubview:_callUser];
    }
    return _callUser;
}

- (UIButton *)callButton{
    if (!_callButton){
        _callButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_callButton setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
//        [_callButton addTarget:self action:@selector(clickCallButton) forControlEvents:UIControlEventTouchUpInside];
        [self.callBGView addSubview:_callButton];
    }
    return _callButton;
}
@end

