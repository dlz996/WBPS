//
//  AccountMoneyViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/25.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "AccountMoneyViewController.h"
#import "AccountOperateTableCell.h"
/** 账户金额模型 */
#import "AccountMoneyModel.h"
/** 冻结金额 */
#import "FreezeMoneyViewController.h"
/** 收支明细 */
#import "DetailViewController.h"
/** 提现记录 */
#import "RecordViewController.h"

@interface AccountMoneyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)AccountMoneyModel * model;
@end

static NSString *const operateCellID = @"operateCellID";
@implementation AccountMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户余额";
    [self getData];
}
#pragma mark - 数据处理
- (void)getData{
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Query" proc:@"QSP_GET_ACCOUNT_APP" pars:mutDic];
    [MBProgressHUD showActivityIndicator];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        self.model =  [AccountMoneyModel mj_objectWithKeyValues:responseObject[@"msg"][0]];
        [self.tableView registerClass:[AccountOperateTableCell class] forCellReuseIdentifier:operateCellID];
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
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCRYFrom6(45);
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
    AccountOperateTableCell * cell = [tableView dequeueReusableCellWithIdentifier:operateCellID];
    cell.contentLabel.text = @[@[@"可提现金额",@"冻结金额"],@[@"收支明细",@"提现记录"]][indexPath.section][indexPath.row];
    cell.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@[@[@"gztx",@"djje"],@[@"szmx",@"txjl"]][indexPath.section][indexPath.row]]];
    NSString * str = [NSString stringWithFormat:@"%.2f",[self.model.acc floatValue] - [self.model.frozenacc floatValue]];
    cell.moneyInfo.text = str;
    if(indexPath.section ==1 || indexPath.row ==1){
        cell.moneyInfo.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0&&indexPath.row==1){
        FreezeMoneyViewController * freezeMoneyVc = [[FreezeMoneyViewController alloc]init];
        [self.navigationController pushViewController:freezeMoneyVc animated:YES
         ];
    }
    if (indexPath.section ==1){
        if (indexPath.row ==0) {
            DetailViewController * detailVc = [[DetailViewController alloc]init];
            [self.navigationController pushViewController:detailVc animated:YES];
        }else if (indexPath.row ==1){
            RecordViewController * recordVc = [[RecordViewController alloc]init];
            [self.navigationController pushViewController:recordVc animated:YES];
        }
    }
}

#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
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
