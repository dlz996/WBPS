
//
//  MoreViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/21.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "MoreViewController.h"
/** 列表展示Cell */
#import "MoreListTableCell.h"

/** 修改密码控制器 */
#import "ChangePasswordViewController.h"
/** 关于我们  常见问题 */
#import "AboutAndFAQViewController.h"
/** 意见反馈 */
#import "FeedBackViewController.h"
/** 登录 */
#import "LoginViewController.h"

@interface MoreViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

/** 列表 */
@property (nonatomic,strong)UITableView * tableView;
/** 退出登录 */
@property (nonatomic,strong)UIButton * loginOut;

@end

static NSString *const moreCellID = @"MoreCellID";
@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
    self.view.backgroundColor = White_Color;
    [self.tableView registerClass:[MoreListTableCell class] forCellReuseIdentifier:moreCellID];

    [self setSubViewAutoLayout];
    
}
/**
     退出登录
 */
- (void)clickLoginOut{
    UIAlertView * aletView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [aletView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==1) {
//用户退出登录，清空别名
        [JPUSHService setAlias:@"" callbackSelector:nil object:self];
        AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        LoginViewController * loginVc = [[LoginViewController alloc]init];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
        appdelegate.window.rootViewController = [[BasicNavigationVontroller alloc]initWithRootViewController:loginVc];
    }
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    view.backgroundColor = COLOR(243, 244, 245, 1);
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreListTableCell * cell = [tableView dequeueReusableCellWithIdentifier:moreCellID];
    cell.titleLabel.text = @[@"修改密码",@"关于我们",@"常见问题",@"意见反馈",@"联系客服"][indexPath.row];
    NSString * string = @[@"xgmm",@"gywm",@"cjwt",@"yjfk",@"lxkf"][indexPath.row];
    cell.icon.image = [UIImage imageNamed:string];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            ChangePasswordViewController * changePassWordVc = [[ChangePasswordViewController alloc]init];
            [self.navigationController pushViewController:changePassWordVc animated:YES];
        }break;
            
        case 1:{
            AboutAndFAQViewController * aboutAndFAQ = [[AboutAndFAQViewController alloc]init];
            aboutAndFAQ.viewType = 1;
            [self.navigationController pushViewController:aboutAndFAQ animated:YES];
        }break;
         
        case 2:{
            AboutAndFAQViewController * aboutAndFAQ = [[AboutAndFAQViewController alloc]init];
            aboutAndFAQ.viewType = 2;
            [self.navigationController pushViewController:aboutAndFAQ animated:YES];
        }break;
            
        case 3:{
            FeedBackViewController * feedBack = [[FeedBackViewController alloc]init];
            [self.navigationController pushViewController:feedBack animated:YES];
        }break;

        case 4:{
            NSString * tellString = @"tel:4008115618";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tellString]];
        }break;
            
        default:
            break;
    }
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(TopHeight);
        make.height.offset(265);
    }];
    
    [weakself.loginOut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.bottom.offset(-20);
        make.height.offset(45);
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
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIButton *)loginOut{
    if (!_loginOut) {
        _loginOut = [UIButton buttonWithTitle:@"退出登录" atTitleSize:20 atTitleColor:White_Color atTarget:self atAction:@selector(clickLoginOut)];
        _loginOut.layer.cornerRadius = 5;
        _loginOut.layer.masksToBounds = YES;
        _loginOut.backgroundColor = COLOR(34, 114, 230, 1);
        [self.view addSubview:_loginOut];
    }
    return _loginOut;
}

@end
