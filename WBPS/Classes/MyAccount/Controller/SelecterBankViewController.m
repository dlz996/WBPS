//
//  SelecterBankViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/12.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "SelecterBankViewController.h"
/** 银行卡列表 */
#import "SelecterBankTableCell.h"

@interface SelecterBankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
/** 银行卡名字数组 */
@property (nonatomic,strong)NSMutableArray * bankNameArray;

@end
static NSString *const CellID = @"CellID";
@implementation SelecterBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择银行";
    [self.tableView registerClass:[SelecterBankTableCell class] forCellReuseIdentifier:CellID];
    
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bankNameArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SelecterBankTableCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_bank_%@",self.bankNameArray[indexPath.row]]];
    cell.bankName.text = self.bankNameArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak __typeof(&*self) weakself = self;
    if (weakself.bankName) {
        weakself.bankName(self.bankNameArray[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {

        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TopHeight+15, SCREEN_WIDTH, SCREEN_HEIGHT-(TopHeight)-15) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)bankNameArray{
    if (!_bankNameArray) {
        _bankNameArray = [NSMutableArray arrayWithObjects:@"工商银行",@"农业银行",@"中国银行",@"建设银行",@"交通银行",@"中信银行",@"平安银行",@"兴业银行",@"浦发银行",@"光大银行",@"民生银行",@"中国人民银行",@"招商银行",@"邮政储蓄银行",@"华夏银行",@"北京银行",@"渤海银行",@"大连银行",@"广州银行",@"杭州银行",@"恒丰银行",@"江苏银行",@"南京银行",@"内蒙古银行",@"宁波银行",@"上海银行",@"盛京银行",@"长沙银行",@"浙商银行",nil];
    }
    return _bankNameArray;
}

@end
