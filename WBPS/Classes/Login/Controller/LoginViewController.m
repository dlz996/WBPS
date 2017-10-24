//
//  LoginViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/21.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "LoginViewController.h"
/** 修改密码  忘记密码控制器 */
#import "LoginPassWordEditViewController.h"
#import "HomeViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

/** 背景图片 */
@property (nonatomic,strong)UIImageView * bgImageView;
/** Logo */
@property (nonatomic,strong)UIImageView * loginImage;
/** 用户手机号码 */
@property (nonatomic,strong)UITextField * userPhone;
/** 用户手机号码输入线条 */
@property (nonatomic,strong)UIImageView * userLine;
/** 用户密码 */
@property (nonatomic,strong)UITextField * passWord;
/** 用户密码输入线条 */
@property (nonatomic,strong)UIImageView * passWordLine;
/** 右侧隐藏显示密码按钮 */
@property (nonatomic,strong)UIButton * rightButton;
/** 登录按钮 */
@property (nonatomic,strong)UIButton * loginButton;
/** 忘记密码 */
@property (nonatomic,strong)UIButton * forgetPassword;
/** 注册用户 */
@property (nonatomic,strong)UIButton * registerUser;

/** 选中输入框背景颜色 */
@property (nonatomic,strong)UIImageView * selectLine;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = White_Color;
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldValueChange) name:UITextFieldTextDidChangeNotification object:self.userPhone];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldValueChange) name:UITextFieldTextDidChangeNotification object:self.passWord];
    
    [self setSubViewAutoLayout];
}

#pragma mark - 点击方法
/** 点击登录按钮 */
- (void)clickLoginButton{
    NSMutableDictionary * pars = [NSMutableDictionary dictionary];
    [pars setObject:self.userPhone.text forKey:@"usermb"];
    [pars setObject:self.passWord.text forKey:@"pwd"];
    [pars setObject:@"0" forKey:@"usertype"];
    NSMutableDictionary * upData =@{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Query" proc:@"QSP_GET_LOGIN_APP" pars:pars];
    [MBProgressHUD showActivityIndicator];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        NSArray * userAry = responseObject[@"msg"];
        NSDictionary * userDic = userAry[0];
        [UserModel setUserInfoModelWithDict:userDic];
        [AccessTool saveUserInfo];
        
        [[NSUserDefaults standardUserDefaults] setObject:[UserModel sharedUserInfo].token forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] setObject:self.userPhone.text forKey:UserPhone];
        [[NSUserDefaults standardUserDefaults] setObject:self.passWord.text forKey:UserPassWord];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:OrderVoice];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:OrderShake];
        
        NSString * userID = [UserModel sharedUserInfo].userid;
        NSString *strUrl = [userID stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [JPUSHService setTags:nil alias:strUrl fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
//            NSLog(@"设置别名");
        }];
        


        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            HomeViewController * homeVc = [[HomeViewController alloc]init];
            appdelegate.window.rootViewController = [[BasicNavigationVontroller alloc]initWithRootViewController:homeVc];
        });
    } error:^(id error) {
        NSLog(@"请求错误");
    } failure:^(NSError *error) {
    }];
}

/** 点击忘记密码 、 注册司机调用方法 */
- (void)clickPasswordEditButton:(UIButton *)send{
    LoginPassWordEditViewController * passWordEditVc = [[LoginPassWordEditViewController alloc]init];
    passWordEditVc.viewType = send.tag;
    [self.navigationController pushViewController:passWordEditVc animated:YES];
}
/** 点击密码输入框右侧按钮 */
- (void)clickRightButton{
    self.rightButton.selected = !self.rightButton.selected;
    self.passWord.secureTextEntry = !self.passWord.secureTextEntry;
}

#pragma mark - TextField代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.selectLine.backgroundColor = LineGray_Color;
    if (textField.tag ==1) {
        self.selectLine = self.userLine;
    }else{
        self.selectLine = self.passWordLine;
    }
    self.selectLine.backgroundColor = UIColorFromRGB(0x0079FF);
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.selectLine.backgroundColor = LineGray_Color;
}

#pragma mark - 监听输入框内容
- (void)textFieldValueChange{
    if (self.userPhone.text.length ==11 && self.passWord.text.length >=6) {
        _loginButton.userInteractionEnabled = YES;
        [_loginButton setBackgroundColor:UIColorFromRGB(0x0079FF)];
    }else {
        [_loginButton setBackgroundColor:COLOR(205, 228, 254, 1)];
        _loginButton.userInteractionEnabled = NO;
    }
}


#pragma mark - 约束
- (void)setSubViewAutoLayout{
    
    WS(weakself);
    [weakself.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.offset(0);
    }];
    [weakself.loginImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SCRYFrom6(65));
        make.centerX.equalTo(weakself.view.mas_centerX);
        make.width.offset(SCRXFrom6(81));
        make.height.offset(SCRYFrom6(104));
    }];
    
    [weakself.userPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.loginImage.mas_bottom).offset(SCRYFrom6(40));
        make.left.offset(SCRXFrom6(38));
        make.right.offset(SCRXFrom6(-38));
        make.height.offset(SCRYFrom6(40));
    }];

    [self.userLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.userPhone);
        make.right.equalTo(weakself.userPhone);
        make.height.offset(2);
        make.top.equalTo(weakself.userPhone.mas_bottom).offset(SCRYFrom6(0));
    }];
    
    [weakself.passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.userPhone.mas_bottom).offset(SCRYFrom6(15));
        make.left.offset(SCRXFrom6(38));
        make.right.offset(SCRXFrom6(-38));
        make.height.offset(SCRYFrom6(40));
    }];
    
    [self.passWordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.passWord);
        make.right.equalTo(weakself.passWord);
        make.height.offset(2);
        make.top.equalTo(weakself.passWord.mas_bottom).offset(SCRYFrom6(0));
    }];
    
    [weakself.forgetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.passWordLine.mas_bottom).offset(SCRYFrom6(3));
        make.right.equalTo(weakself.passWordLine.mas_right);
        make.height.offset(SCRYFrom6(20));
        make.width.offset(SCRXFrom6(60));
    }];
    [weakself.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.passWordLine.mas_bottom).offset(SCRYFrom6(50));
        make.centerX.equalTo(weakself.view.mas_centerX);
        make.width.offset(SCRXFrom6(300));
        make.height.offset(SCRYFrom6(40));
    }];
    [weakself.registerUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.loginButton.mas_bottom).offset(SCRYFrom6(20));
        make.centerX.equalTo(weakself.view.mas_centerX);
        make.width.offset(SCRXFrom6(300));
        make.height.offset(SCRYFrom6(40));
    }];
    
}

#pragma  mark - 懒加载
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView imageViewWithImageName:@"login_input_bg"];
        _bgImageView.userInteractionEnabled = YES;
        [self.view addSubview:_bgImageView];
    }
    return _bgImageView;
}
- (UIImageView *)loginImage{
    if (!_loginImage) {
        _loginImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
        [self.bgImageView addSubview:_loginImage];
    }
    return _loginImage;
}
- (UITextField *)userPhone{
    if (!_userPhone) {
        _userPhone = [[UITextField alloc]init];
        _userPhone.placeholder = @"输入手机号";
        _userPhone.clearButtonMode = UITextFieldViewModeAlways;
        _userPhone.tag = 1;
        _userPhone.delegate = self;
        [self.bgImageView addSubview:_userPhone];
    }
    return _userPhone;
}
- (UIImageView *)userLine{
    if (!_userLine) {
        _userLine = [UIImageView horizontalSeparateImageView];
        [self.bgImageView addSubview:_userLine];
    }
    return _userLine;
}

- (UITextField *)passWord{
    if (!_passWord) {
        _passWord = [[UITextField alloc]init];
        _passWord.placeholder = @"输入密码";
        _passWord.rightView = self.rightButton;
        _passWord.rightViewMode = UITextFieldViewModeAlways;
        _passWord.tag = 2;
        _passWord.delegate = self;
        _passWord.secureTextEntry = YES;
        [self.bgImageView addSubview:_passWord];
    }
    return _passWord;
}
- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithTitle:@"" atTitleSize:15 atTitleColor:White_Color atTarget:self  atAction:@selector(clickRightButton)];
        _rightButton.bounds = CGRectMake(0, 0, 30, 30);
        [_rightButton setImage:[UIImage imageNamed:@"login_input_visibility_off"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"login_input_visibility"] forState:UIControlStateSelected];
        _rightButton.selected = NO;
    }
    return _rightButton;
}

- (UIImageView *)passWordLine{
    if (!_passWordLine) {
        _passWordLine = [UIImageView horizontalSeparateImageView];
        [self.bgImageView addSubview:_passWordLine];
    }
    return _passWordLine;
}
- (UIButton *)forgetPassword{
    if (!_forgetPassword) {
        _forgetPassword = [UIButton buttonWithTitle:@"忘记密码" atTitleSize:13 atTitleColor:UIColorFromRGB(0x0079FF) atTarget:self atAction:@selector(clickPasswordEditButton:)];
        _forgetPassword.tag = 1;
        [self.bgImageView addSubview:_forgetPassword];
    }
    return _forgetPassword;
}
- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithTitle:@"登录" atTitleSize:16 atTitleColor:UIColorFromRGB(0xFFFFFF) atTarget:self atAction:@selector(clickLoginButton)];
        [_loginButton setBackgroundColor:COLOR(205, 228, 254, 1)];
        _loginButton.userInteractionEnabled = NO;
        _loginButton.layer.cornerRadius = 2;
        _loginButton.layer.masksToBounds = YES;
        [self.bgImageView addSubview:_loginButton];
    }
    return _loginButton;
}
- (UIButton *)registerUser{
    if (!_registerUser) {
        _registerUser = [UIButton buttonWithTitle:@"注册司机版" atTitleSize:16 atTitleColor:UIColorFromRGB(0x0079FF) atTarget:self atAction:@selector(clickPasswordEditButton:)];
        [_registerUser setBackgroundColor:UIColorFromRGB(0xFFFFFF)];
        _registerUser.tag = 2;
        _registerUser.layer.cornerRadius = 2;
        _registerUser.layer.masksToBounds = YES;
        _registerUser.layer.borderWidth = 1;
        _registerUser.layer.borderColor = UIColorFromRGB(0x0079FF).CGColor;
        [self.bgImageView addSubview:_registerUser];
    }
    return _registerUser;
}
@end
