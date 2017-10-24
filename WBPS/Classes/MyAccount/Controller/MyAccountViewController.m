//
//  MyAccountViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/21.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "MyAccountViewController.h"

#import "AccountMonryTableCell.h"
#import "AccountOperateTableCell.h"
/** 账户余额管理 */
#import "AccountMoneyViewController.h"
/** 工资提现 */
#import "FetchMoneyViewController.h"
/** 我的银行卡 */
#import "MyBankCardViewController.h"
/** 数据Model */
#import "AccountMoneyModel.h"

@interface MyAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIButton * rightButton;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)AccountMoneyModel * model;
@end

static NSString *const moneyCellID = @"moneyCellID";
static NSString *const operateCellID = @"operateCellID";
@implementation MyAccountViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的账户";
    [self.tableView registerClass:[AccountMonryTableCell class] forCellReuseIdentifier:moneyCellID];
    [self.tableView registerClass:[AccountOperateTableCell class] forCellReuseIdentifier:operateCellID];
}

#pragma mark - 数据处理
/** 获取数据 */
- (void)getData{
    
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Query" proc:@"QSP_GET_ACCOUNT_APP" pars:mutDic];
    [MBProgressHUD showActivityIndicator];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        self.model =  [AccountMoneyModel mj_objectWithKeyValues:responseObject[@"msg"][0]];
        [self.tableView reloadData];
        
    } error:^(id error) {
    } failure:^(NSError *error) {
    }];
    
}

#pragma mark - tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }else{
        return 2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 100;
    }else{
        return SCRYFrom6(45);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    view.backgroundColor = self.view.backgroundColor;
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        AccountMonryTableCell * cell = [tableView dequeueReusableCellWithIdentifier:moneyCellID];
        cell.model = self.model;
        
        return cell;
    }else{
        AccountOperateTableCell * cell = [tableView dequeueReusableCellWithIdentifier:operateCellID];
        cell.contentLabel.text = @[@"工资提现",@"我的银行卡"][indexPath.row];
        cell.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@[@"gztx",@"xhk"][indexPath.row]]];
        cell.moneyInfo.hidden = YES;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        AccountMoneyViewController * accpuntMoneyVc = [[AccountMoneyViewController alloc]init];
        [self.navigationController pushViewController:accpuntMoneyVc animated:YES];
    }else if (indexPath.section ==1){
        if (indexPath.row ==0) {
            FetchMoneyViewController * fetchMoneyVc = [[FetchMoneyViewController alloc]init];
            fetchMoneyVc.money = [self.model.acc floatValue] - [self.model.frozenacc floatValue];
            [self.navigationController pushViewController:fetchMoneyVc animated:YES];
        }else if (indexPath.row ==1){
            MyBankCardViewController * bankCardVc = [[MyBankCardViewController alloc]init];
            bankCardVc.type = 2;
            [self.navigationController pushViewController:bankCardVc animated:YES];
        }
    }
}

#pragma mark - 懒加载
- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitleColor:COLOR(0, 99, 228, 1) forState:UIControlStateNormal];
        [_rightButton setTitle:@"承运记录" forState:UIControlStateNormal];
    }
    return _rightButton;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREEN_HEIGHT- (TopHeight)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
