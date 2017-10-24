//
//  FreezeMoneyViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/11.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "FreezeMoneyViewController.h"
/** 头视图 */
#import "FreezeMoneyHeadView.h"
#import "AccountDetailTableCell.h"
@interface FreezeMoneyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)FreezeMoneyHeadView * header;

@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,assign)NSInteger index;
/** 空数据视图 */
@property (nonatomic,strong)DataNullView * nullView;
@end

static NSString * const CellID = @"CellID";
@implementation FreezeMoneyViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"冻结金额";
    self.index = 1;
    self.dataArray = [NSMutableArray array];
    
    [self.tableView registerClass:[AccountDetailTableCell class] forCellReuseIdentifier:CellID];
    [self setSubViewAutoLayout];
    /*
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downPullData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    /** 底部上拉加载更多 
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upPullData)];
    */
    
}


#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AccountDetailTableCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    return cell;
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(TopHeight);
        make.left.right.offset(0);
        make.height.offset(150);
    }];
    
    [weakself.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(weakself.header.mas_bottom).offset(0);
    }];
}


#pragma mark - 懒加载
- (FreezeMoneyHeadView *)header{
    if (!_header) {
        _header = [[FreezeMoneyHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        [self.view addSubview:_header];
    }
    return _header;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;

//#ifdef __IPHONE_11_0
//        if ([_tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
//            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        }
//#endif
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
