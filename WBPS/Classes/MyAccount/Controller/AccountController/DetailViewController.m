//
//  DetailViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/11.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "DetailViewController.h"
#import "AccountDetailTableCell.h"
#import "DetailSelectDateViewController.h"
/** 数据模型 */
#import "DetailModel.h"

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIButton * rightButton;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,assign)NSInteger index;
/** 年月字符串 */
@property (nonatomic,copy)NSString * yearmonth;
/** 空数据视图 */
@property (nonatomic,strong)DataNullView * nullView;

@end


static NSString * const CellID = @"CellID";
@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收支明细";
    self.yearmonth = @"";
    self.index = 1;
    self.dataArray = [NSMutableArray array];

    [self.tableView registerClass:[AccountDetailTableCell class] forCellReuseIdentifier:CellID];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downPullData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    /** 底部上拉加载更多 */
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upPullData)];
    
}
#pragma mark - 数据处理
/** 下拉刷新 */
- (void)downPullData{
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:@"1" forKey:@"PageIndex"];
    [mutDic setObject:@"10" forKey:@"PageSize"];
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    [mutDic setObject:self.yearmonth forKey:@"yearmonth"];
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Query" proc:@"QSP_GET_ACCOUNT_DETAIL_APP" pars:mutDic];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [self.dataArray removeAllObjects];
        self.index = 1;
        [self.dataArray addObjectsFromArray:[DetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"msg"]]];
        if (self.dataArray.count<=0) {
            self.nullView.hidden = NO;
        }else{
            self.nullView.hidden = YES;
        }
        if (self.dataArray.count<10 || self.dataArray.count ==0) {
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } error:^(id error) {
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}
/** 上拉加载更多 */
- (void)upPullData{
    self.index += 1;
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:@(self.index) forKey:@"PageIndex"];
    [mutDic setObject:@"10" forKey:@"PageSize"];
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    [mutDic setObject:self.yearmonth forKey:@"yearmonth"];
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Query" proc:@"QSP_GET_ACCOUNT_DETAIL_APP" pars:mutDic];
    
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        NSArray * array =[DetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"msg"]];
        [self.dataArray addObjectsFromArray:array];
        if (array.count<10 || array.count ==0) {
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } error:^(id error) {
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - 点击方法
- (void)clickBarItem{
    DetailSelectDateViewController * detailSelectVc = [[DetailSelectDateViewController alloc]init];
    detailSelectVc.date = ^(NSString *selectDate) {
        self.yearmonth = selectDate;
        [self.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:detailSelectVc animated:YES];
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AccountDetailTableCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, (TopHeight)+10, SCREEN_WIDTH, SCREEN_HEIGHT-(TopHeight)) style:UITableViewStylePlain];
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
- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setImage:[UIImage imageNamed:@"gl"] forState:UIControlStateNormal];
        _rightButton.bounds = CGRectMake(0, 0, 25, 25);
        [_rightButton addTarget:self action:@selector(clickBarItem) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
- (DataNullView *)nullView{
    if (!_nullView) {
        _nullView = [[DataNullView alloc]initWithFrame:self.view.frame];
        _nullView.hidden = YES;
        [self.view addSubview:_nullView];
    }
    return _nullView;
}

@end
