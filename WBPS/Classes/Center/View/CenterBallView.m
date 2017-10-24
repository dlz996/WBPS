//
//  CenterBallView.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/25.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "CenterBallView.h"
#import "ProvinceModel.h"
@interface CenterBallView ()<UIPickerViewDelegate,UIPickerViewDataSource>
/** 背景视图 */
@property (nonatomic,strong)UIView * bgView;
/** 提示标题 */
@property (nonatomic,strong)UILabel * hintLabel;
/** 选择器 */
@property (nonatomic,strong)UIPickerView * pickerView;
/** 确认按钮 */
@property (nonatomic,strong)UIButton * confirmButton;
/** 取消按钮 */
@property (nonatomic,strong)UIButton * cancelButton;
/** 选择类型 */
@property (nonatomic,copy)NSString * selectType;

/** 当前选中的省份 */
@property (nonatomic,strong)ProvinceModel *selectedProvince;
/** 选中的城市 */
@property (nonatomic,copy)NSString *citiesString;
/** 省份数组 */
@property (nonatomic,strong)NSArray * provinces;


@end

@implementation CenterBallView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:COLOR(0, 0, 0, 0.5)];
        [self setSubViewAutoLayout];
        [self.pickerView reloadAllComponents];
    }
    return self;
}
- (void)setCarTypeArray:(NSMutableArray *)carTypeArray{
    _carTypeArray = carTypeArray;
}
/**
 显示类型  1 全市通   2 同城运输 3 选择运送的城市  4 车辆的类型 5 车辆的容积  6 车辆的载重
 
 */
- (void)setType:(NSInteger)type{
    _type = type;
    
    [self.pickerView reloadAllComponents];
    switch (_type) {
        case 1:
            self.citiesString = @"全市通";
            break;
        case 2:
            self.citiesString = @"同城运输";
            break;
        case 3:
            self.citiesString = @"福州";
            self.hintLabel.text = @"请选择城市";
            break;
            
        case 4:{
            CarTypeModel * model = self.carTypeArray[0];
            self.citiesString = model.id;
            self.hintLabel.text = @"请选择车辆类型";
        }break;
            
        default:
            self.hintLabel.text = @"请选择";
            break;
    }
}
#pragma mark - 点击事件
/** 点击底部确认、取消按钮调用方法 */
- (void)clickSelectButton:(UIButton *)send{
    if (send.tag ==1) {
        if ([self.delegate respondsToSelector:@selector(clickSelectType:selectObj:)]) {
            [self.delegate clickSelectType:self.type selectObj:self.citiesString];
            [self removeFromSuperview];
        }
    }else{
        [self removeFromSuperview];
        return;
    }
}

#pragma mark - pickerView代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.type ==3) {
        return 2;
    }else{
        return 1;
    }
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.type ==3) {
        if (component ==0) {
            return self.provinces.count;
        }else{
            // 获得省份所在的行号
            NSInteger provinceIndex = [pickerView selectedRowInComponent:0];
            // 根据索引获得省份
            ProvinceModel *province = self.provinces[provinceIndex];
            return province.cities.count;
        }
    }else if(self.type ==4){
        return self.carTypeArray.count;
    }else if (self.type ==2){
        return 2;
    }else{
        return 1;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (self.type == 3) {
        if (component ==0) {
            ProvinceModel * province = self.provinces[row];
            return province.name;
        }else{
            // 获得省份所在的行号
            NSInteger provinceIndex = [pickerView selectedRowInComponent:0];
            // 根据索引获得省份
            ProvinceModel *province = self.provinces[provinceIndex];
            // 获得省份对应的所有城市
            NSArray *cities = province.cities; // 10 11
            if (cities.count > row) {
                return cities[row];
            }
            return nil;
        }
    }else if(self.type ==4){
        CarTypeModel * model = self.carTypeArray[row];
        return model.vehiclemodel;
    }else if (self.type ==1){
        return @"全市通";
    }else if (self.type ==2){
        return @[@"同城运输",@"长途运输"][row];
    }
    return nil;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (self.type ==3) {/* -----选择城市---- */
        if(component == 0) {
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            // 根据索引获得省份
            ProvinceModel *province = self.provinces[row];
            // 获得省份对应的所有城市
            NSArray *cities = province.cities;
            self.citiesString = cities[0];
        }else{
            // 获得省份所在的行号
            NSInteger provinceIndex = [pickerView selectedRowInComponent:0];
            // 根据索引获得省份
            ProvinceModel *province = self.provinces[provinceIndex];
            // 获得省份对应的所有城市
            NSArray *cities = province.cities;
            self.citiesString = cities[row];
        }
    }else if(self.type == 4){ /* -----车辆类型选择---- */
        CarTypeModel * model = self.carTypeArray[row];
        self.citiesString = model.id;
    }else if (self.type == 2){
        self.citiesString = @[@"同城运输",@"长途运输"][row];
    }
    
    
}

#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(300);
        make.centerX.equalTo(weakself.mas_centerX);
        make.centerY.equalTo(weakself.mas_centerY);
    }];
    
    [weakself.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(20);
    }];
    
    [weakself.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.bgView.mas_centerX);
        make.top.equalTo(weakself.hintLabel.mas_bottom).offset(20);
        make.width.offset(200);
        make.height.offset(160);
    }];
    
    UILabel * line1 = [[UILabel alloc]init];
    line1.backgroundColor = COLOR(100, 100, 100, 1);
    [self.bgView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(weakself.pickerView.mas_bottom).offset(20);
        make.height.offset(1);
    }];
    UILabel * line2 = [[UILabel alloc]init];
    line2.backgroundColor = COLOR(199, 199, 199, 1);
    [self.bgView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.centerX.equalTo(weakself.bgView.mas_centerX);
        make.width.offset(1);
        make.height.offset(60);
    }];
    
    [weakself.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.bottom.offset(0);
        make.height.offset(60);
        make.right.equalTo(line2.mas_left).offset(0);
    }];
    
    [weakself.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.bottom.offset(0);
        make.left.equalTo(line2.mas_right).offset(0);
        make.height.offset(60);
    }];
}

#pragma mark - 懒加载
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = White_Color;
        _bgView.layer.cornerRadius = 10;
        _bgView.layer.masksToBounds = YES;
        [self addSubview:_bgView];
    }
    return _bgView;
}

- (UILabel *)hintLabel{
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc]init];
        _hintLabel.text = @"城市选择";
        _hintLabel.textColor = Black_Color;
        [self.bgView addSubview:_hintLabel];
    }
    return _hintLabel;
}
- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [self.bgView addSubview:_pickerView];
    }
    return _pickerView;
}

- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:Black_Color forState:UIControlStateNormal];
        _confirmButton.tag = 1;
        [_confirmButton addTarget:self action:@selector(clickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:_confirmButton];
    }
    return _confirmButton;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:Black_Color forState:UIControlStateNormal];
        _cancelButton.tag = 2;
        [_cancelButton addTarget:self action:@selector(clickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (NSArray *)provinces {
    if (_provinces == nil) {
        _provinces = [ProvinceModel provinces];
    }
    return _provinces;
}

@end
