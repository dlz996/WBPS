//
//  AddBankCardViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/28.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "AddBankCardViewController.h"
#import "AddBankCardTableCell.h"
/** 银行卡选择控制器 */
#import "SelecterBankViewController.h"
@interface AddBankCardViewController ()<UITableViewDelegate,UITableViewDataSource,AddBankCardTableCellDelegate>

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UIButton * confirmButton;
/** 银行名称 */
@property (nonatomic,strong)NSString * bankName;
/** 银行卡信息 */
@property (nonatomic,strong)NSMutableDictionary * bankInfoDic;

@end

static NSString *const CellID = @"CellID";
@implementation AddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加银行卡";
    self.bankName = @"请选择";
    [self.tableView registerClass:[AddBankCardTableCell class] forCellReuseIdentifier:CellID];
    [self setSubViewAutoLayout];
}
#pragma makr - 点击方法
/** 点击确认按钮调用的方法 */
- (void)clickConfirmButton{
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].gid forKey:@"userid"];
    [mutDic setObject:self.bankInfoDic[@"UserNO"] forKey:@"cardid"];
    [mutDic setObject:self.bankInfoDic[@"UserName"] forKey:@"bankman"];
    [mutDic setObject:self.bankInfoDic[@"BankNO"] forKey:@"bankcode"];
    [mutDic setObject:self.bankInfoDic[@"BankBranch"] forKey:@"bankid"];
    [mutDic setObject:self.bankName forKey:@"bankname"];
    [mutDic setObject:self.bankInfoDic[@"userPhone"] forKey:@"phonenumber"];
    
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Modify" proc:@"USP_ADD_BANKCARD_APP" pars:mutDic];
    [MBProgressHUD showActivityIndicator];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [MBProgressHUD showSuccess:@"添加成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } error:^(id error) {
    } failure:^(NSError *error) {
    }];
}

#pragma mark - 代理方法
/**
 输入框内值改变后调用的方法
 
 @param indexPath 改变的TextField的下标
 */
- (void) textFieldValueChange:(NSIndexPath *)indexPath textChange:(NSString *)text{
    /**
     0  身份证
     1 姓名
     3支行
     4 银行卡号
     5 电话号码
     */
    NSArray * ary =@[@"UserNO",@"UserName",@"BankBranch",@"BankNO",@"userPhone"];
    switch (indexPath.row) {
        case 0:
            [self.bankInfoDic setObject:text forKey:ary[0]];
            break;
        case 1:
            [self.bankInfoDic setObject:text forKey:ary[1]];
            break;
        case 3:
            [self.bankInfoDic setObject:text forKey:ary[2]];
            break;
        case 4:
            [self.bankInfoDic setObject:text forKey:ary[3]];
            break;
        case 5:
            [self.bankInfoDic setObject:text forKey:ary[4]];
            break;
        default:
            break;
    }
    for (NSString * str in  [self.bankInfoDic allValues]) {
        if ([str isEqualToString:@""] || str ==nil || [self.bankName isEqualToString:@"请选择"]) {
            self.confirmButton.userInteractionEnabled = NO;
            self.confirmButton.backgroundColor = COLOR(162, 163, 164, 1);
        }else{
            self.confirmButton.backgroundColor = COLOR(34, 114, 230, 1);
            self.confirmButton.userInteractionEnabled = YES;
        }
    }
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddBankCardTableCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.titleLabel.text = @[@"身份证号码",@"持卡人姓名",@"银行",@"支行",@"银行卡号",@"电话号码"][indexPath.row];
    cell.textField.placeholder = @[@"请填写个人身份证号码",@"请输入您的姓名",@"",@"银行卡号",@"请输入支行",@"请输入银行预留手机号码"][indexPath.row];
    cell.hintLabel.text = self.bankName;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        SelecterBankViewController * selectBankVc = [[SelecterBankViewController alloc]init];
        [self.navigationController pushViewController:selectBankVc animated:YES];
        selectBankVc.bankName = ^(NSString *str) {
            self.bankName = str;
            [self.tableView reloadData];
            for (NSString * str in  [self.bankInfoDic allValues]) {
                if ([str isEqualToString:@""] || str ==nil || [self.bankName isEqualToString:@"请选择"]) {
                    self.confirmButton.userInteractionEnabled = NO;
                    self.confirmButton.backgroundColor = COLOR(162, 163, 164, 1);
                }else{
                    self.confirmButton.backgroundColor = COLOR(34, 114, 230, 1);
                    self.confirmButton.userInteractionEnabled = YES;
                }
            }
        };
    }
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.tableView.mas_bottom).offset(30);
        make.left.offset(SCRXFrom6(10));
        make.right.offset(SCRXFrom6(-10));
        make.height.offset(45);
    }];
}

#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat height = 0;
        if (iPhoneX) {
            height = 88;
        }else{
            height = 64;
        }
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, height+15, SCREEN_WIDTH, 270) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithTitle:@"确认" atTitleSize:16 atTitleColor:White_Color atTarget:self atAction:@selector(clickConfirmButton)];
        _confirmButton.layer.cornerRadius = 8;
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.backgroundColor = COLOR(162, 163, 164, 1);
        _confirmButton.userInteractionEnabled = NO;
        [self.view addSubview:_confirmButton];
    }
    return _confirmButton;
}
- (NSMutableDictionary *)bankInfoDic{
    if (!_bankInfoDic) {
        _bankInfoDic = [NSMutableDictionary dictionary];
        for (int i=0; i<5; i++) {
            NSArray * ary =@[@"UserNO",@"UserName",@"BankBranch",@"BankNO",@"userPhone"];
            [_bankInfoDic setObject:@"" forKey:ary[i]];
        }
    }
    return _bankInfoDic;
}
@end
