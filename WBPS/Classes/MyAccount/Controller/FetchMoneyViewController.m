//
//  FetchMoneyViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/25.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "FetchMoneyViewController.h"
/** 卡片列表控制器 */
#import "MyBankCardViewController.h"
/** 银行卡列表数据模型 */
#import "BankListModel.h"
@interface FetchMoneyViewController ()
/** 卡号提示 */
@property (nonatomic,strong)UILabel * cardNumberTitle;
/** 卡号展示文本*/
@property (nonatomic,strong)UILabel * cardText;
/** 可以取出提示 */
@property (nonatomic,strong)UILabel * fetchHint;
/** 可以取出来的文本 */
@property (nonatomic,strong)UILabel *fetchText;
/** 取出金额输入提示 */
@property (nonatomic,strong)UILabel * importHint;
/** 金额输入框 */
@property (nonatomic,strong)UITextField * moneyImport;
/** 提示单次提现金额 */
@property (nonatomic,strong)UILabel * hint;
/** 取现按钮 */
@property (nonatomic,strong)UIButton * fetchButton;
//
@property (nonatomic,strong)UIView * bgView;
/** 银行卡model */
@property (nonatomic,strong)BankListModel * model;

@end

@implementation FetchMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工资提现";
    [self setSubViewAutoLayout];
    self.fetchText.text = [NSString stringWithFormat:@"%.2f",_money];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldValueChange) name:UITextFieldTextDidChangeNotification object:self.moneyImport];
}
#pragma mark - 点击方法
/** 选择卡片 */
- (void)clickCardText{
    MyBankCardViewController * bankCardVc = [[MyBankCardViewController alloc]init];
    bankCardVc.type =1;
    [self.navigationController pushViewController:bankCardVc animated:YES];
    bankCardVc.returnCard = ^(BankListModel *returnModel) {
        self.model = returnModel;
        self.cardText.text = self.model.bankcode;
        if (self.moneyImport.text.length!=0 || ![self.moneyImport.text isEqualToString:@""]) {
            self.fetchButton.backgroundColor = COLOR(34, 114, 230, 1);
            self.fetchButton.userInteractionEnabled = YES;
        }
    };
}
/** 点击确认体现按钮 */
- (void)clickFetchButton{
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    [mutDic setObject:self.model.id forKey:@"bankcardid"];
    [mutDic setObject:self.moneyImport.text forKey:@"acc"];
    [mutDic setObject:@"" forKey:@"remark"];
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Modify" proc:@"USP_ADD_withdrawals" pars:mutDic];
    [MBProgressHUD showActivityIndicator];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [MBProgressHUD showSuccess:@"申请成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } error:^(id error) {
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

#pragma mark - 设置数据
/** 设置钱数 */
- (void)setMoney:(CGFloat)money{
    _money = money;
}
#pragma mark - 监听输入框内容
- (void)textFieldValueChange{
    if (self.model ==nil || self.model ==NULL || self.moneyImport.text.length==0 || [self.moneyImport.text isEqualToString:@""]){
        [self.fetchButton setBackgroundColor:COLOR(162, 163, 164, 1)];
        self.fetchButton.userInteractionEnabled = NO;
    }else{
        self.fetchButton.backgroundColor = COLOR(34, 114, 230, 1);
        self.fetchButton.userInteractionEnabled = YES;
    }
}
#pragma Mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhoneX) {
            make.top.offset(99);
        }else{
            make.top.offset(79);
        }
        make.left.right.offset(0);
        make.height.offset(155);
    }];
    
    [weakself.cardNumberTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.offset(20);
    }];
    
    [weakself.cardText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.cardNumberTitle.mas_centerY);
        make.right.offset(-20);
        make.left.equalTo(weakself.cardNumberTitle.mas_right).offset(20);
        make.height.offset(30);
    }];
    
    UILabel * line1 = [self lineLabel];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.offset(0);
        make.top.equalTo(weakself.cardNumberTitle.mas_bottom).offset(15);
        make.height.offset(1);
    }];

    [weakself.fetchHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.equalTo(line1.mas_bottom).offset(15);
    }];
    
    [weakself.fetchText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.centerY.equalTo(weakself.fetchHint.mas_centerY);
    }];
    
    UILabel * line2 = [self lineLabel];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(weakself.fetchHint.mas_bottom).offset(15);
        make.height.offset(1);
    }];
    
    [weakself.importHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(15);
        make.left.offset(20);
    }];

    [weakself.moneyImport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.importHint.mas_centerY);
        make.right.offset(-20);
        make.left.equalTo(weakself.importHint.mas_right).offset(20);
        make.height.offset(30);
    }];
    
    [weakself.hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.equalTo(weakself.bgView.mas_bottom).offset(20);
    }];
    
    [weakself.fetchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.hint.mas_bottom).offset(15);
        make.left.offset(SCRXFrom6(10));
        make.right.offset(SCRXFrom6(-10));
        make.height.offset(45);
    }];
    
}


#pragma mark - 懒加载
- (UILabel *)cardNumberTitle{
    if (!_cardNumberTitle) {
        _cardNumberTitle = [[UILabel alloc]init];
        _cardNumberTitle.text = @"储蓄卡号";
        _cardNumberTitle.textColor = Black_Color;
        [self.bgView addSubview:_cardNumberTitle];
    }
    return _cardNumberTitle;
}
- (UILabel *)cardText{
    if (!_cardText) {
        _cardText = [UILabel labelWithText:@"请选择卡" atColor:Black_Color atTextSize:16 atTextFontForType:@""];
        _cardText.userInteractionEnabled = YES;
        _cardText.textAlignment = NSTextAlignmentRight;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCardText)];
        [_cardText addGestureRecognizer:tap];
        [self.bgView addSubview:_cardText];
    }
    return _cardText;
}
- (UILabel *)fetchHint{
    if (!_fetchHint) {
        _fetchHint = [[UILabel alloc]init];
        _fetchHint.text = @"可提现余额";
        _fetchHint.textColor = Black_Color;
        [self.bgView addSubview:_fetchHint];
    }
    return _fetchHint;
}
- (UILabel *)fetchText{
    if (!_fetchText) {
        _fetchText = [[UILabel alloc]init];
        _fetchText.textAlignment = NSTextAlignmentRight;
        _fetchText.textColor = Black_Color;
        _fetchText.text = @"1100.00";
        [self.bgView addSubview:_fetchText];
    }
    return _fetchText;
}
- (UILabel *)importHint{
    if (!_importHint) {
        _importHint = [[UILabel alloc]init];
        _importHint.textColor = Black_Color;
        _importHint.text = @"提现金额";
        [self.bgView addSubview:_importHint];
    }
    return _importHint;
}
- (UITextField *)moneyImport{
    if (!_moneyImport) {
        _moneyImport = [[UITextField alloc]init];
        _moneyImport.textAlignment = NSTextAlignmentRight;
        _moneyImport.placeholder = @"请输入提现金额";
        [self.bgView addSubview:_moneyImport];
    }
    return _moneyImport;
}

- (UILabel *)hint{
    if (!_hint) {
        _hint = [[UILabel alloc]init];
        _hint.textColor = COLOR(158, 159, 160, 1);
        _hint.font = [UIFont systemFontOfSize:14];
        _hint.text = @"每次最多提现50000元，当前可体现1次";
        [self.view addSubview:_hint];
    }
    return _hint;
}

- (UIButton *)fetchButton{
    if (!_fetchButton) {
        _fetchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fetchButton setTitle:@"确认提现" forState:UIControlStateNormal];
        [_fetchButton setBackgroundColor:COLOR(162, 163, 164, 1)];
        [_fetchButton addTarget:self action:@selector(clickFetchButton) forControlEvents:UIControlEventTouchUpInside];
        [_fetchButton setTitleColor:White_Color forState:UIControlStateNormal];
        _fetchButton.layer.cornerRadius = 10;
        _fetchButton.layer.masksToBounds = YES;
        _fetchButton.userInteractionEnabled = NO;
        [self.view addSubview:_fetchButton];
    }
    return _fetchButton;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = White_Color;
        [self.view addSubview:_bgView];
    }
    return _bgView;
}
- (UILabel *)lineLabel{
    UILabel * label = [[UILabel alloc]init];
    label.backgroundColor = LineGray_Color;
    [self.bgView addSubview:label];
    return label;
}

@end
