//
//  OrderInfoViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/21.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "OrderInfoViewController.h"
//列表cell
#import "OrderInfoTableCell.h"
//菜单cell
#import "OrderInfoMenuTableCell.h"
/** 导航展示页面 */
#import "MapViewController.h"
/** 任务详情模型 */
#import "TaskInfoModel.h"
/** 地图地图详情页 */
#import "OrderInfoMapViewController.h"
/** 事故上报控制器 */
#import "AbnormalViewController.h"
/** 导航地图页面 */
#import "OrderInfoMapViewController.h"

@interface OrderInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIButton * rightButton;
/** 列表 */
@property (nonatomic,strong)UITableView * tableView;
/** 菜单选择tableView */
@property (nonatomic,strong)UITableView * menuTableView;
/** 事故上报按钮 */
@property (nonatomic,strong)UIButton * accidentButton;
/** 导航按钮 */
@property (nonatomic,strong)UIButton * navigationButton;
/** 数据源数组 */
@property (nonatomic,strong)NSMutableArray * dataArray;
/** 最顶部的任务 */
@property (nonatomic,strong)TaskInfoModel * topTask;
/** 用户的位置 */
@property (nonatomic) CLLocationCoordinate2D centerCoordinate;

@end

static NSString *const CellID = @"cellid";  //列表tableviewCellID
static NSString *const menuCellId = @"menuCellid";  //菜单tableviewCellID
@implementation OrderInfoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self downPullData];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单明细";
    [self.tableView registerClass:[OrderInfoTableCell class] forCellReuseIdentifier:CellID];
    [self.menuTableView registerClass:[OrderInfoMenuTableCell class] forCellReuseIdentifier:menuCellId];
    [self setSubViewAutoLayout];
    
}

#pragma mark - 数据处理
/** 请求数据 */
- (void)downPullData{
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:_orderID forKey:@"mainid"];
    [mutDic setObject:_type forKey:@"type"];
    NSMutableDictionary * upData = @{}.mutableCopy;
    
    upData = [NetWorkingManager combinationObj:@"Query" proc:@"QSP_GET_TASK_ORDER_DETAIL_APP" pars:mutDic];
    [MBProgressHUD showActivityIndicator];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:[TaskInfoModel mj_objectArrayWithKeyValuesArray:responseObject[@"msg"]]];
        if (self.dataArray.count >0) {
            self.topTask = self.dataArray[0];
        }
        [self.tableView reloadData];
    } error:^(id error) {
    } failure:^(NSError *error) {
    }];
}
/** 设置订单ID */
- (void)setOrderID:(NSString *)orderID{
    _orderID = orderID;
}

#pragma mark - 点击事件
/**
 点击导航右侧按钮调用方法
  */
- (void)clickBarItem:(UIButton *)sendButton{
    NSLog(@"点击导航条右侧item")
    self.menuTableView.hidden = !self.menuTableView.hidden;
}
/**
 点击导航按钮
 */
- (void)clickNavigationButton{
    OrderInfoMapViewController * infoMapVc = [[OrderInfoMapViewController alloc]init];
    infoMapVc.model = self.dataArray[0];
    infoMapVc.type = 1;
    [self.navigationController pushViewController:infoMapVc animated:YES];
}
/**
     点击事故上报按钮
 */
- (void)clickAccidentButton{
    AbnormalViewController * abnormalVc = [[AbnormalViewController alloc]init];
    abnormalVc.viewType = 2;
    abnormalVc.mainOrderID = self.orderID;
    [self.navigationController pushViewController:abnormalVc animated:YES];
}

#pragma mark - 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==2) {
        return 2;
    }else{
        return self.dataArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==2) {
        OrderInfoMenuTableCell * cell = [tableView dequeueReusableCellWithIdentifier:menuCellId];
        cell.contentLabel.text = @[@"按路径排序",@"按紧急情况"][indexPath.row];
        return cell;
    }else{
        OrderInfoTableCell * Cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        Cell.model = self.dataArray[indexPath.row];
        return Cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag ==2) {
        return 40;
    }else{
        return 390;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==2) {
        tableView.hidden = !tableView.hidden;
    }else{
        MapViewController * mapViewVc = [[MapViewController alloc]init];
        mapViewVc.model = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:mapViewVc animated:YES];
    }
}

#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(TopHeight);
        make.left.right.offset(0);
        make.bottom.equalTo(weakself.locationButton.mas_top).offset(-5);
    }];
    
    [weakself.accidentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-10);
        make.left.offset(10);
        make.width.offset(110);
        make.height.offset(SCRYFrom6(40));
    }];
    
    [weakself.locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.offset(-10);
        make.left.equalTo(weakself.accidentButton.mas_right).offset(10);
        make.height.offset(SCRYFrom6(40));
    }];
    
    [weakself.menuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.top.offset(64);
        make.width.offset(110);
        make.height.offset(80);
    }];
    
}
#pragma mark - 懒加载
- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setImage:[UIImage imageNamed:@"gl"] forState:UIControlStateNormal];
        _rightButton.bounds = CGRectMake(0, 0, 25, 25);
        [_rightButton addTarget:self action:@selector(clickBarItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tag = 1;
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (UIButton *)accidentButton{
    if (!_accidentButton) {
        _accidentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _accidentButton.backgroundColor = COLOR(220, 83,75, 1);
        [_accidentButton setTitle:@"事故上报" forState:UIControlStateNormal];
        [_accidentButton setTitleColor:White_Color forState:UIControlStateNormal];
        [_accidentButton addTarget:self action:@selector(clickAccidentButton) forControlEvents:UIControlEventTouchUpInside];
        _accidentButton.layer.cornerRadius = 5;
        _accidentButton.layer.masksToBounds = YES;
        [self.view addSubview:_accidentButton];
    }
    return _accidentButton;
}
- (UIButton *)locationButton{
    if (!_navigationButton) {
        _navigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _navigationButton.backgroundColor = COLOR(34, 114, 231, 1);
        [_navigationButton setTitle:@"开始导航" forState:UIControlStateNormal];
        [_navigationButton setTitleColor:White_Color forState:UIControlStateNormal];
        [_navigationButton addTarget:self action:@selector(clickNavigationButton) forControlEvents:UIControlEventTouchUpInside];
        _navigationButton.layer.cornerRadius = 5;
        _navigationButton.layer.masksToBounds = YES;
        [self.view addSubview:_navigationButton];
    }
    return _navigationButton;
}
- (UITableView *)menuTableView{
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc]init];
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.tag = 2;
        _menuTableView.hidden = YES;
        _menuTableView.bounces = NO;
        _menuTableView.layer.cornerRadius = 10;
        _menuTableView.layer.masksToBounds = YES;
        _menuTableView.layer.borderWidth = 0.5;
        _menuTableView.layer.borderColor = [UIColor grayColor].CGColor;
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuTableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_menuTableView];
    }
    return _menuTableView;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;;
}

@end
