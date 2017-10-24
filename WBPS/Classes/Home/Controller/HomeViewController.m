//
//  HomeViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/21.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "HomeViewController.h"
/** 侧滑菜单视图 */
#import "LeftSlideMenuView.h"
/** 列表Cell */
#import "HomeTableCell.h"
/** 订单详情控制器 */
#import "OrderInfoViewController.h"
/** 用户中心控制器 */
#import "UserCenterViewController.h"
/** 我的账户控制器 */
#import "MyAccountViewController.h"
/** 消息中心控制器 */
#import "MessageCenterViewController.h"
/** 接单设置控制器 */
#import "SetingViewController.h"
/** 更多控制器 */
#import "MoreViewController.h"
/** 下班视图 */
#import "OutDutyView.h"
/** 任务列表数据模型 */
#import "TaskListModel.h"
/** 车辆状态设置 */
#import "HomeCarStateView.h"
/** 登录 */
#import "LoginViewController.h"
/** 订单搜索页面 */
#import "SearchTaskViewController.h"
@interface HomeViewController ()
<UITableViewDelegate,
UITableViewDataSource,
LeftSlideMenuViewDelegate,
SuspensionViewDelegate,
UserAndCarStateEditViewDelegate,
HomeCarStateViewDelegate,
AMapLocationManagerDelegate>

/** 左侧Item */
@property (nonatomic,strong)UIButton * leftButton;
/** 右侧Item */
@property (nonatomic,strong)UIButton * rightButton;
/** 背景图片 */
@property (nonatomic,strong)UIView * segmentBgView;

/** 分段控制器 */
@property (nonatomic,strong)UISegmentedControl * segmented;
/** table */
@property (nonatomic,strong)UITableView * tableView;
/** 底部背景View */
@property (nonatomic,strong)UIView *bgView;
/** 任务订单按钮 */
@property (nonatomic,strong)UIButton * taskOrderBtn;
/** 平台订单按钮 */
@property (nonatomic,strong)UIButton * terraceOrderBtn;
/** 任务平台状态切换按钮 */
@property (nonatomic,strong)UIButton * sendBtn;
/** 菜单视图 */
@property (nonatomic,strong)LeftSlideMenuView * menuView;
/** 下班视图 */
@property (nonatomic,strong)OutDutyView * outView;
/** 悬浮球 */
@property (nonatomic,strong)SuspensionView * suspension;
/** 操作视图 */
@property (nonatomic,strong)UserAndCarStateEditView * userAndCar;
/** 请求数据的页数 */
@property (nonatomic,assign)NSInteger index;
/** 数据数组 */
@property (nonatomic,strong)NSMutableArray * dataArray;
/** 空数据视图 */
@property (nonatomic,strong)DataNullView * nullView;
/** 车辆载重状态出视图 */
@property (nonatomic,strong)HomeCarStateView * carStateView;

@property (nonatomic,strong)AMapLocationManager * locationManager;

@property (nonatomic,assign)CLLocationCoordinate2D userLocation;

@end

static NSString *const CellID = @"cellid";
@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newOrderPushInfo:) name:JPushMessageKey object:nil];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.window addSubview:self.suspension];
    [appDelegate.window addSubview:self.userAndCar];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downPullData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    if (self.sendBtn.tag ==1) {
        [self.tableView.mj_header beginRefreshing];
    }
    /** 接收更换头像通知 */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PostValue:) name:LoadTitleImage object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.suspension removeFromSuperview];
    [self.userAndCar removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"任务列表"];
    
    /** 创建定时器获取用户位置上传服务器 */
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:300 target:self
                                                    selector:@selector(getUserLocation) userInfo:nil repeats:true];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    
    [self.tableView registerClass:[HomeTableCell class] forCellReuseIdentifier:CellID];
    [self setSubViewAutoLayout];
    [self.view addSubview:self.outView];
    
    _index =1;

    /** 底部上拉加载更多 */
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upPullData)];
    [self loginGetUserInfo];
    
    [self configLocationManager];
}
/** 注册持续定位 */
- (void)configLocationManager{
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    [self.locationManager startUpdatingLocation];
}
#pragma mark - 高德地图代理方法
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    //定位结果
    self.userLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
}

/** 将用户信息上传到服务器 */
- (void)getUserLocation{
    
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:@(6666.66) forKey:@"lat"];
    [mutDic setObject:@(6666.66) forKey:@"lng"];
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Modify" proc:@"USP_UPDATE_VEHICLE_LNGLAT_APP" pars:mutDic];
    [[NetWorkingManager sharedManager]POSTUserLocationWithParameters:upData success:^(id responseObject) {
        NSDate * date = [NSDate date];
        NSLog(@"位置上传成功----------****************--------时间------>>>%@",date);
    } error:^(id error) {
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 推送消息处理
- (void)newOrderPushInfo:(NSNotification *)notifiInfo{
    NSLog(@"推送详情");
    
    NSDictionary * dic = notifiInfo.userInfo;
    NSString * str = dic[@"aps"][@"alert"];

    OrderInfoViewController * orderInfoVc = [[OrderInfoViewController alloc]init];
    orderInfoVc.orderID = str;
    orderInfoVc.type = @"0";
    [self.navigationController pushViewController:orderInfoVc animated:YES];
}

#pragma mark - 数据处理
/** 下拉刷新 */
- (void)downPullData{
    NSLog(@"下拉刷新");
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    NSString * typeString = self.segmented.selectedSegmentIndex==0?@"0":@"1";
    [mutDic setObject:typeString forKey:@"type"];
    [mutDic setObject:@(1) forKey:@"PageIndex"];
    [mutDic setObject:@"10" forKey:@"PageSize"];
    NSMutableDictionary * upData =@{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Query" proc:@"QSP_GET_TASK_ORDER_APP" pars:mutDic];
    
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [self.dataArray removeAllObjects];
        self.index = 1;
        [self.dataArray addObjectsFromArray:[TaskListModel mj_objectArrayWithKeyValuesArray:responseObject[@"msg"]]];
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
    self.index +=1;
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    NSString * typeString = self.segmented.selectedSegmentIndex==0?@"0":@"1";
    [mutDic setObject:typeString forKey:@"type"];
    [mutDic setObject:@(_index) forKey:@"PageIndex"];
    [mutDic setObject:@"10" forKey:@"PageSize"];
    
    NSMutableDictionary * upData =@{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Query" proc:@"QSP_GET_TASK_ORDER_APP" pars:mutDic];

    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        NSArray * dataAry = [TaskListModel mj_objectArrayWithKeyValuesArray:responseObject[@"msg"]];
        [self.dataArray addObjectsFromArray:dataAry];
        if (dataAry.count<10) {
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } error:^(id error) {
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}
/** 登录一次获取用户信息 */
- (void)loginGetUserInfo{
    NSMutableDictionary * pars = [NSMutableDictionary dictionary];
    NSString * userPhone = [[NSUserDefaults standardUserDefaults]objectForKey:UserPhone];
    NSString * userPassWord = [[NSUserDefaults standardUserDefaults]objectForKey:UserPassWord];
    [pars setObject:userPhone forKey:@"usermb"];
    [pars setObject:userPassWord forKey:@"pwd"];
    [pars setObject:@"0" forKey:@"usertype"];
    NSMutableDictionary * upData =@{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Query" proc:@"QSP_GET_LOGIN_APP" pars:pars];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        NSArray * userAry = responseObject[@"msg"];
        NSDictionary * userDic = userAry[0];
        [UserModel setUserInfoModelWithDict:userDic];
        [AccessTool saveUserInfo];
        
        switch ([[UserModel sharedUserInfo].loadstate integerValue]) {
            case 0:
                self.suspension.carStateType = @"空载";
                break;
            case 1:
                self.suspension.carStateType = @"半载";
                break;
            case 2:
                self.suspension.carStateType = @"满载";
                break;
            default:
                break;
        }
        
    } error:^(id error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            LoginViewController * loginVc = [[LoginViewController alloc]init];
            appdelegate.window.rootViewController = [[BasicNavigationVontroller alloc]initWithRootViewController:loginVc];
        });
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 修改车辆状态
/** 修改车辆状态 */
- (void)reviseCarStateType:(NSInteger)type volume:(NSString *)volume weight:(NSString *)weight {
    
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    [mutDic setObject:@(type) forKey:@"loadstate"];
    if (type == 1) {
        [mutDic setObject:volume forKey:@"freevolumn"];
        [mutDic setObject:weight forKey:@"freeweight"];
    }else{
        [mutDic setObject:@"0" forKey:@"freevolumn"];
        [mutDic setObject:@"0" forKey:@"freeweight"];
    }
    NSMutableDictionary * upData =@{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Modify" proc:@"USP_UPDATE_LOADSTATE_APP" pars:mutDic];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [MBProgressHUD showSuccess:@"修改成功"];
    } error:^(id error) {
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 点击事件
/**
 点击底部两个按钮调用方法
 
 @param sendButton tag值为1  是任务订单   2是平台订单
 */
- (void)clickBottomButton:(UIButton *)sendButton{
    self.sendBtn.selected = NO;
    self.sendBtn = sendButton;
    self.sendBtn.selected = YES;
    if (sendButton.tag == 1) {
        [self.tableView.mj_header beginRefreshing];
    }else{
        self.nullView.hidden =  NO;
    }
}
/**
 点击导航两个按钮调用方法
 
 @param sendButton 3 左侧按钮 4右侧按钮
 */
- (void)clickBarItem:(UIButton *)sendButton{
    if (sendButton.tag == 3) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate.window addSubview:self.menuView];
        [UIView animateWithDuration:0.4 animations:^{
            self.menuView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }else{
        SearchTaskViewController * searchTaskVc = [[SearchTaskViewController alloc]init];
        [self.navigationController pushViewController:searchTaskVc animated:YES];
    }
}
/** 分段控制器调用方法 */
- (void)recommenSegValueChanged:(UISegmentedControl *)segment{
    self.index = 1;
    if (self.sendBtn.tag == 2) {
        return;
    }
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark - 自定义代理方法
/** 下班页面上滑手势调用方法 */
- (void)swipeGestureRecognizer{
    CGRect frame = _outView.frame;
    frame.origin.y = -SCREEN_HEIGHT;
    [UIView animateWithDuration:0.3 animations:^{
        _outView.frame = frame;
    }];
    self.suspension.hidden = NO;
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    [mutDic setObject:@"1" forKey:@"chaufferstate"];
    NSMutableDictionary * upData  = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Modify" proc:@"USP_UPDATE_CHAUFFERSTATE_APP" pars:mutDic];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [MBProgressHUD showSuccess:@"上班成功"];
    } error:^(id error) {
        
    } failure:^(NSError *error) {
        
    }];
    
}
/**
 侧滑菜单出现后阴影部分点击事件
 */
- (void)clickLeftBlackView{
    [UIView animateWithDuration:0.4 animations:^{
        self.menuView.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [self.menuView removeFromSuperview];
    }];
}
/**
 更改车辆状态调用的方法
 
 @param state 1 空载  2 半载  3 满载
 */
- (void)selectCarState:(NSInteger)state{
    switch (state) {
        case 1:
            self.userAndCar.carStateType = NSCarStateOfEmpty;
            self.suspension.carStateType = @"空载";
            [self reviseCarStateType:0 volume:@"" weight:@""];
            break;
        case 2:{
            self.userAndCar.carStateType = NSCarStateOfHalf;
            AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appdelegate.window addSubview: self.carStateView];
        }
            break;
        case 3:
            self.suspension.carStateType = @"满载";
            self.userAndCar.carStateType = NSCarStateOfFull;
            [self reviseCarStateType:2 volume:@"" weight:@""];
            break;
        default:
            break;
    }
    self.userAndCar.hidden = YES;
    self.suspension.hidden = NO;
}
/**
     点击车辆状态弹出视图调用的方法
 */
- (void)clickBlankView{
    self.userAndCar.hidden = YES;
    self.suspension.hidden = NO;
}
#pragma mark - 下班按钮
/** 下班调用方法 */
- (void)outDutyButton{
    self.suspension.hidden = YES;
    self.userAndCar.hidden = YES;
    CGRect frame = _outView.frame;
    frame.origin.y = iPhoneX?88:64;
    [UIView animateWithDuration:0.3 animations:^{
        _outView.frame = frame;
    }];
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    [mutDic setObject:@"0" forKey:@"chaufferstate"];
    NSMutableDictionary * upData  = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Modify" proc:@"USP_UPDATE_CHAUFFERSTATE_APP" pars:mutDic];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [MBProgressHUD showSuccess:@"下班成功"];
    } error:^(id error) {
        
    } failure:^(NSError *error) {
        
    }];
    
}
/**
 点击悬浮球调用方法
 */
- (void)clickSuspensionView{
    self.userAndCar.hidden = NO;
    self.suspension.hidden = YES;
}
/**
 点击侧滑菜单头部、列表调用方法
 
 @param row     0. 我的账户  1.消息中心   2.接单设置    3.更多    4.点击header位置
 */
- (void)clickMenuSelect:(NSInteger)row{
    [UIView animateWithDuration:0.4 animations:^{
        self.menuView.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [self.menuView removeFromSuperview];
        switch (row) {
            case 0:{
                MyAccountViewController * myAccountVc = [[MyAccountViewController alloc]init];
                [self.navigationController pushViewController:myAccountVc animated:YES];
            }break;
            case 1:{
                MessageCenterViewController * messageVc = [[MessageCenterViewController alloc]init];
                [self.navigationController pushViewController:messageVc animated:YES];
            }break;
            case 2:{
                SetingViewController * setingVc = [[SetingViewController alloc]init];
                [self.navigationController pushViewController:setingVc animated:YES];
            }break;
            case 3:{
                MoreViewController * moreVc = [[MoreViewController alloc]init];
                [self.navigationController pushViewController:moreVc animated:YES];
            }break;
            case 4:{
                UserCenterViewController * userCenterVc = [[UserCenterViewController alloc]init];
                [self.navigationController pushViewController:userCenterVc animated:YES];
            }break;
            default:
                return;
                break;
        }
    }];
}
#pragma mark - 半载信息输入弹出框调用方法
/** 修改车辆半载状态按钮 */
- (void)remainingVolume:(NSString *)volume weight:(NSString *)weight{
    self.suspension.carStateType = @"半载";
    [self reviseCarStateType:1 volume:volume weight:weight];
}

#pragma mark - 通知响应方法
-(void)PostValue:(NSNotification *)info{
    UIImage * image = [info userInfo][@"image"];
    self.menuView.headerView.userImage.image = image;
}

#pragma mark - tableView代理方法
/*******  tableView代理方法  ******/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableCell * Cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    Cell.model = self.dataArray[indexPath.row];
    return Cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString * typeString = self.segmented.selectedSegmentIndex==0?@"0":@"1";

    TaskListModel * model = self.dataArray[indexPath.row];
    OrderInfoViewController * orderInfoVc = [[OrderInfoViewController alloc]init];
    orderInfoVc.orderID = model.id;
    orderInfoVc.type = typeString;
    [self.navigationController pushViewController:orderInfoVc animated:YES];
}

#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    CGFloat width = SCREEN_WIDTH/2;

    [weakself.segmentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(TopHeight);
        make.left.right.offset(0);
        make.height.offset(SCRYFrom6(30));
    }];
    
    [weakself.segmented mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SCRXFrom6(10));
        make.right.offset(-SCRXFrom6(10));
        make.height.offset(SCRYFrom6(30));
        make.top.offset(0);
    }];

    [weakself.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.segmentBgView.mas_bottom).offset(10);
        make.left.offset(SCRXFrom6(10));
        make.right.offset(SCRXFrom6(-10));
        make.bottom.offset(-60);
    }];
    
    [weakself.nullView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.segmented.mas_bottom).offset(10);
        make.left.offset(SCRXFrom6(10));
        make.right.offset(SCRXFrom6(-10));
        make.bottom.offset(-60);
    }];
    
    [weakself.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(SCRYFrom6(50));
    }];

    [weakself.taskOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset(0);
        make.height.offset(SCRYFrom6(50));
        make.width.offset(width);
    }];

    [weakself.terraceOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.offset(0);
        make.height.offset(SCRYFrom6(50));
        make.width.offset(width);
    }];
}

#pragma mark - 懒加载
- (UIView *)segmentBgView{
    if (!_segmentBgView) {
        _segmentBgView = [[UIView alloc]init];
        _segmentBgView.backgroundColor = self.view.backgroundColor;
        [self.view addSubview:_segmentBgView];
    }
    return _segmentBgView;
}
- (UISegmentedControl *)segmented{
    if (!_segmented) {
        _segmented = [[UISegmentedControl alloc]initWithItems:@[@"进行中",@"已完成"]];
        _segmented.selectedSegmentIndex = 0;
        _segmented.layer.cornerRadius = 5;
        _segmented.clipsToBounds = YES;
        _segmented.tintColor= COLOR(34, 114, 231, 1);
        _segmented.backgroundColor = self.view.backgroundColor;
        [_segmented addTarget:self action:@selector(recommenSegValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.segmentBgView addSubview:_segmented];
    }
    return _segmented;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (DataNullView *)nullView{
    if (!_nullView) {
        _nullView = [[DataNullView alloc]init];
        _nullView.hidden = YES;
        [self.view addSubview:_nullView];
    }
    return _nullView;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = White_Color;
        [self.view addSubview:_bgView];
    }
    return _bgView;
}

- (UIButton *)taskOrderBtn{
    if (!_taskOrderBtn) {
        _taskOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_taskOrderBtn setTitle:@"任务订单" forState:UIControlStateNormal];
        [_taskOrderBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_taskOrderBtn setTitleColor:COLOR(161, 161, 161, 1) forState:UIControlStateNormal];
        [_taskOrderBtn setTitleColor:COLOR(34, 113, 230, 1) forState:UIControlStateSelected];
        [_taskOrderBtn addTarget:self action:@selector(clickBottomButton:) forControlEvents:UIControlEventTouchUpInside];
        _taskOrderBtn.selected = YES;
        _taskOrderBtn.tag = 1;
        self.sendBtn = _taskOrderBtn;
        [self.bgView addSubview:_taskOrderBtn];
    }
    return _taskOrderBtn;
}
- (UIButton *)terraceOrderBtn{
    if (!_terraceOrderBtn) {
        _terraceOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_terraceOrderBtn setTitle:@"平台订单" forState:UIControlStateNormal];
        [_terraceOrderBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_terraceOrderBtn setTitleColor:COLOR(161, 161, 161, 1) forState:UIControlStateNormal];
        [_terraceOrderBtn setTitleColor:COLOR(34, 113, 230, 1) forState:UIControlStateSelected];
        [_terraceOrderBtn addTarget:self action:@selector(clickBottomButton:) forControlEvents:UIControlEventTouchUpInside];
        [_terraceOrderBtn setTitleColor:COLOR(34, 113, 230, 1) forState:UIControlStateSelected];
        _terraceOrderBtn.tag = 2;
        [self.bgView addSubview:_terraceOrderBtn];
    }
    return _terraceOrderBtn;
}

- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.bounds = CGRectMake(0, 0, 25, 25);
        _leftButton.tag = 3;
        [_leftButton setImage:[UIImage imageNamed:@"user"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(clickBarItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.bounds = CGRectMake(0, 0, 25, 25);
        _rightButton.tag = 4;
        [_rightButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(clickBarItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
- (LeftSlideMenuView *)menuView{
    if (!_menuView) {
        _menuView = [[LeftSlideMenuView alloc]init];
        _menuView.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT );
        _menuView.delegate = self;
    }
    return _menuView;
}
- (OutDutyView *)outView{
    if (!_outView) {
        _outView = [[OutDutyView alloc]init];
        CGFloat stateHeight = iPhoneX?88:64;
        _outView.frame = CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-stateHeight);
        UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureRecognizer)];
        swipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
        [_outView addGestureRecognizer:swipeGesture];
    }
    return _outView;
}
- (SuspensionView *)suspension{
    if (!_suspension) {
        _suspension = [[SuspensionView alloc]initWithFrame:CGRectMake(-35, SCREEN_WIDTH/2, 70, 70)];
        _suspension.layer.cornerRadius = 35;
        _suspension.layer.masksToBounds = YES;
        _suspension.layer.borderWidth = 1;
        _suspension.layer.borderColor = [UIColor colorWithRed:45/255.0 green:85/255.0 blue:139/255.0 alpha:1].CGColor;
        _suspension.delegate = self;
    }
    return _suspension;
}
- (UserAndCarStateEditView *)userAndCar{
    if (!_userAndCar) {
        _userAndCar = [[UserAndCarStateEditView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _userAndCar.delegate = self;
        _userAndCar.carStateType = NSCarStateOfEmpty;
        _userAndCar.hidden = YES;
    }
    return _userAndCar;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (HomeCarStateView *)carStateView{
    if (!_carStateView) {
        _carStateView = [[HomeCarStateView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _carStateView.delegate = self;
    }
    return _carStateView;
}

@end
