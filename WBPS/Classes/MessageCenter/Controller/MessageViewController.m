//
//  MessageViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/14.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableCell.h"
#import "MessageModel.h"
@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableView;
/** 请求数据的页数 */
@property (nonatomic,assign)NSInteger index;
/** 数据数组 */
@property (nonatomic,strong)NSMutableArray * dataArray;
/** 空数据视图 */
@property (nonatomic,strong)DataNullView * nullView;

@end
static NSString *const CellID = @"CellID";
@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    self.index = 1;
    [self.tableView registerClass:[MessageTableCell class] forCellReuseIdentifier:CellID];
   
    [self setSubViewAutoLayout];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downPullData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    
    /** 底部上拉加载更多 */
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upPullData)];
    
}
#pragma mark - 获取数据
/** 下拉刷新 */
- (void)downPullData{
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:@(1) forKey:@"PageIndex"];
    [mutDic setObject:@"10" forKey:@"PageSize"];
    NSMutableDictionary * upData =@{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Query" proc:@"QSP_GET_NoticeInfo" pars:mutDic];
    
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [self.dataArray removeAllObjects];
        self.index = 1;
        [self.dataArray addObjectsFromArray:[MessageModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"msg"]]];
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
    [mutDic setObject:@(self.index) forKey:@"PageIndex"];
    [mutDic setObject:@"10" forKey:@"PageSize"];
    NSMutableDictionary * upData =@{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Query" proc:@"QSP_GET_NoticeInfo" pars:mutDic];
    
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        
        NSArray * array = [MessageModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"msg"]];
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

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel * model = self.dataArray[indexPath.row];
    CGSize size = [QLRegularTool convertToString:model.msgcontent stringFont:15 wide:SCREEN_WIDTH-40 high:999];
    CGFloat height = size.height + 75;
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageTableCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.offset(0);
    }];
    
    [weakself.nullView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.offset(0);
    }];
}

#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
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


@end

