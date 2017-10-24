//
//  SearchTaskViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/13.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "SearchTaskViewController.h"

/** 列表Cell */
#import "HomeTableCell.h"
/** 订单详情控制器 */
#import "OrderInfoViewController.h"
/** 任务列表数据模型 */
#import "TaskListModel.h"
/** 筛选类型 */
#import "SearchTableCell.h"
@interface SearchTaskViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
/** 搜索输入框 */
@property (nonatomic,strong)UITextField * searchTextField;
/** 返回按钮 */
@property (nonatomic,strong)UIButton * backButton;

@property (nonatomic,strong)UITableView * searchTypeTableView;
@end

static NSString *const searchCellID = @"cellid";
@implementation SearchTaskViewController
- (void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithCustomView:self.backButton];
    UIBarButtonItem * searchItem = [[UIBarButtonItem alloc]initWithCustomView:self.searchTextField];
    NSArray * barArray = @[backItem,searchItem];
    self.navigationItem.leftBarButtonItems = barArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.searchTypeTableView registerClass:[SearchTableCell class] forCellReuseIdentifier:searchCellID];
    
    [self setSubViewAutoLayout];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldValueChange) name:UITextFieldTextDidChangeNotification object:self.searchTextField];

}
#pragma mark - 点击方法
- (void)clickBackItem{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 代理方法
- (void)textFieldValueChange{
    if ([self.searchTextField.text isEqualToString:@""] || self.searchTextField.text.length<=0 || self.searchTextField.text == nil || self.searchTextField.text == NULL) {
        self.searchTypeTableView.hidden = YES;
    }else{
        self.searchTypeTableView.hidden = NO;
    }
    [self.searchTypeTableView reloadData];
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTableCell * cell = [tableView dequeueReusableCellWithIdentifier:searchCellID];
    cell.titleLabel.text = @[@"客户单号：",@"订单号：",@"发货人：",@"收货人："][indexPath.row];
    cell.contentLabel.text = self.searchTextField.text;
    return cell;
}

#pragma mark - 设置约束
- (void)setSubViewAutoLayout{
    WS(weakself);

//    [weakself.searchTypeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.offset(0);
//        make.top.offset(TopHeight);
//        make.height.offset(200);
//    }];
}

#pragma mark - 懒加载
- (UITableView *)searchTypeTableView{
    if (!_searchTypeTableView) {
        _searchTypeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, 200) style:UITableViewStylePlain];
        _searchTypeTableView.delegate = self;
        _searchTypeTableView.dataSource = self;
        _searchTypeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _searchTypeTableView.showsHorizontalScrollIndicator = NO;
        _searchTypeTableView.showsVerticalScrollIndicator = NO;
        _searchTypeTableView.tag = 1;
        _searchTypeTableView.hidden = YES;
        _searchTypeTableView.bounces = NO;
        if (@available(iOS 11.0, *)) {
        
        } else {
            _searchTypeTableView.contentInset = UIEdgeInsetsMake(-(TopHeight) , 0, 0, 0);
        }
        [self.view addSubview:_searchTypeTableView];
    }
    return _searchTypeTableView;
}
- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(-10, 0, 20, 20);
        [_backButton setImage:UIImageName(@"back") forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(clickBackItem) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
- (UITextField *)searchTextField{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, 40)];
        _searchTextField.placeholder = @"客户单号/订单号/收发货人";
        _searchTextField.delegate = self;
    }
    return _searchTextField;
}


@end
