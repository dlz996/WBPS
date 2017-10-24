//
//  DetailSelectDateViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/12.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "DetailSelectDateViewController.h"

@interface DetailSelectDateViewController ()<HooDatePickerDelegate>

@property (nonatomic,strong)HooDatePicker * datePicker;
/** 日期 */
@property (nonatomic,strong)UILabel * dateLabel;

@end

@implementation DetailSelectDateViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(clickButton)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate * date = [NSDate date];
    [self formattingDateToStrin:date];

    CGFloat tap = iPhoneX?84:64;
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.offset(tap+30);
    }];
    [self.datePicker show];
}
#pragma mark - 数据处理
- (void)formattingDateToStrin:(NSDate *)date{
    //设置时间显示的格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY - MMMM";
    //设置月份显示的时候为数字
    [dateFormatter setMonthSymbols:[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil]];
    NSString * DateStr = [dateFormatter stringFromDate:date]; // date转换成为字符串
    self.dateLabel.text = DateStr;
}
#pragma mark - 点击方法
- (void)clickButton{
    __weak __typeof(&*self)weakself = self;
    if (weakself.date) {
        weakself.date(self.dateLabel.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 代理方法
- (void)datePicker:(HooDatePicker *)datePicker dateDidChange:(NSDate *)date{
    [self formattingDateToStrin:date];
}


#pragma mark - 懒加载
- (HooDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[HooDatePicker alloc] initWithSuperView:self.view];
        _datePicker.delegate = self;
        _datePicker.datePickerMode = HooDatePickerModeYearAndMonth;
        _datePicker.maximumDate = [NSDate date];
        _datePicker.backgroundColor = [UIColor clearColor];
    }
    return _datePicker;
}

- (UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [UILabel labelWithText:@"" atColor:COLOR(103, 156, 237, 1) atTextSize:18 atTextFontForType:@""];
        [self.view addSubview:_dateLabel];
    }
    return _dateLabel;
}
@end
