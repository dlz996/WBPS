//
//  MyBankCardViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/28.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "MyBankCardViewController.h"
/** 添加银行卡控制器 */
#import "AddBankCardViewController.h"
/** 银行卡列表Cell */
#import "BankCardListTableCell.h"
/** 添加银行卡根视图 */
#import "MyBankCardFootView.h"
/** 银行卡选择控制器 */
#import "SelecterBankViewController.h"

@interface MyBankCardViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)MyBankCardFootView * footView;
/** 右侧添加按钮 */
@property (nonatomic,strong)UIButton *rightButton;
/** 银行卡信息页面 */
@property (nonatomic,strong)NSMutableArray * bankArray;
/** 删除银行卡下标 */
@property (nonatomic,assign)NSInteger deleteIndexPath;
@end

static NSString *const CellID = @"CellID";
@implementation MyBankCardViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self getBankList];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的银行卡";
    
    [self.tableView registerClass:[BankCardListTableCell class] forCellReuseIdentifier:CellID];
}
#pragma mark - 获取银行卡数据列表
- (void)getBankList{
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].gid forKey:@"userid"];
    
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Query" proc:@"QSP_GET_BANKCARD_APP" pars:mutDic];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        self.bankArray = [NSMutableArray array];
        [self.bankArray addObjectsFromArray:[BankListModel mj_objectArrayWithKeyValuesArray:responseObject[@"msg"]]];
        [self.tableView reloadData];
    } error:^(id error) {
        
    } failure:^(NSError *error) {
        
    }];
}
/**
     删除银行卡操作
 */
- (void)deleteBank{
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    BankListModel * model = self.bankArray[self.deleteIndexPath];
    [mutDic setObject:model.id forKey:@"id"];
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Modify" proc:@"USP_DELETE_BACKAPP" pars:mutDic];
    
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [MBProgressHUD showSuccess:@"删除成功"];
        [self.bankArray removeObjectAtIndex:self.deleteIndexPath];
        [self.tableView reloadData];
    } error:^(id error) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 点击方法
/** 点击添加调用方法 */
- (void)clickFootView{
    AddBankCardViewController * addBankCardVc = [[AddBankCardViewController alloc]init];
    [self.navigationController pushViewController:addBankCardVc animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type ==1) {
        __weak typeof(&*self) weakself = self;
        if (weakself.returnCard) {
            weakself.returnCard(self.bankArray[indexPath.row]);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else if (self.type ==2){
        self.deleteIndexPath = indexPath.row;
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认删除银行卡？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [self deleteBank];
    }
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bankArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
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
    BankCardListTableCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.model = self.bankArray[indexPath.row];
    return cell;
}
#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-(TopHeight)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.tableFooterView = self.footView;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (MyBankCardFootView *)footView{
    if (!_footView) {
        _footView = [[MyBankCardFootView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        _footView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickFootView)];
        [_footView addGestureRecognizer:tap];
    }
    return _footView;
}
- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.bounds = CGRectMake(0, 0, 20, 20);
        [_rightButton setImage:[UIImage imageNamed:@"rightItem"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(clickFootView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

@end
