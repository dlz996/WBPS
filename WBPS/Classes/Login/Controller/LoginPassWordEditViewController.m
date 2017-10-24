//
//  LoginPassWordEditViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/26.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "LoginPassWordEditViewController.h"
/** 认证控制器 */
#import "LoginIdentificationViewController.h"
@interface LoginPassWordEditViewController ()<UITextFieldDelegate>

/** 大提示标题 */
@property (nonatomic,strong)UILabel * hintTitle;
/** 小提示标题 */
@property (nonatomic,strong)UILabel * littleTitle;
/** 手机号 */
@property (nonatomic,strong)UITextField * userPhone;
/** 密码 */
@property (nonatomic,strong)UITextField * passWord;
/** 再次输入密码 */
@property (nonatomic,strong)UITextField * againPassWord;
/** 验证码 */
@property (nonatomic,strong)UITextField * verificationCode;
/** 当前处于选中状态的输入框 */
@property (nonatomic,strong)UITextField * selectTextField;

/** 发送验证码 */
@property (nonatomic,strong)UIButton * sendButton;
/** 下一步按钮 */
@property (nonatomic,strong)UIButton * nextButton;

/** 同意用户协议勾选按钮 */
@property (nonatomic,strong)UIButton * consentButton;
/** 同意提示文本 */
@property (nonatomic,strong)UILabel * consentLabel;
/** 查看协议按钮 */
@property (nonatomic,strong)UIButton * agreement;
/** 注册按钮标题 */
@property (nonatomic,copy)NSString * buttonTitle;

@end

@implementation LoginPassWordEditViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = White_Color;
    
   
    [self setUIContent];
    [self setSubViewAutoLayout];
    
}

- (void)setUIContent{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldValueChange) name:UITextFieldTextDidChangeNotification object:self.userPhone];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldValueChange) name:UITextFieldTextDidChangeNotification object:self.passWord];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldValueChange) name:UITextFieldTextDidChangeNotification object:self.verificationCode];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldValueChange) name:UITextFieldTextDidChangeNotification object:self.againPassWord];

    
    if (self.viewType ==1) {
        self.title = @"忘记密码";
        self.consentButton.hidden = YES;
        self.consentButton.selected = YES;
        self.consentLabel.hidden = YES;
        self.agreement.hidden = YES;
        self.hintTitle.text = @"忘记密码";
        self.littleTitle.text = @"请注意查收短信验证码";
        self.buttonTitle = @"确定";
    }else if (self.viewType ==2){
        self.title = @"注册";
        self.buttonTitle = @"完成注册";
        
    }
}

#pragma mark - 数据处理
/** 用户注册 */
- (void)registaerUser{

    if (self.passWord.text.length < 6) {
        [MBProgressHUD showError:@"密码不得小于6位"];
        return;
    }
    if (![self.passWord.text isEqualToString:self.againPassWord.text]) {
        [MBProgressHUD showError:@"两次输入密码不一致"];
        return;
    }
        NSMutableDictionary * mutDic = @{}.mutableCopy;
        [mutDic setObject:self.userPhone.text forKey:@"usermb"];
        [mutDic setObject:self.passWord.text forKey:@"pwd"];
        [mutDic setObject:@"0" forKey:@"usertype"];
        [mutDic setObject:self.verificationCode.text forKey:@"msgcode"];
        NSMutableDictionary * upData =@{}.mutableCopy;
        upData = [NetWorkingManager combinationObj:@"Modify" proc:@"USP_ADD_REGISTER_APP" pars:mutDic];
        [MBProgressHUD showActivityIndicator];
        [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
            [self loginGetUserInfo];
        } error:^(id error) {
            
        } failure:^(NSError *error) {
            
        }];

}
/** 登录一次获取用户信息 */
- (void)loginGetUserInfo{
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
        [[NSUserDefaults standardUserDefaults] setObject:self.userPhone.text forKey:UserPhone];
        [[NSUserDefaults standardUserDefaults] setObject:self.passWord.text forKey:UserPassWord];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:OrderVoice];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:OrderShake];
        
        [MBProgressHUD showSuccess:@"注册成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LoginIdentificationViewController * loginIdentificationVC = [[LoginIdentificationViewController alloc]init];
            loginIdentificationVC.viewType = 1;
            [self.navigationController pushViewController:loginIdentificationVC animated:YES];
        });
    } error:^(id error) {
    } failure:^(NSError *error) {
    }];
}
/** 找回密码 */
- (void)retrievePassword{
    if (self.passWord.text.length < 6) {
        [MBProgressHUD showError:@"密码不得小于6位"];
        return;
    }
    if (![self.passWord.text isEqualToString:self.againPassWord.text]) {
        [MBProgressHUD showError:@"两次输入密码不一致"];
        return;
    }
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:self.userPhone.text forKey:@"usermb"];
    [mutDic setObject:@"0" forKey:@"usertype"];
    [mutDic setObject:self.passWord.text forKey:@"newpwd"];
    [mutDic setObject:self.verificationCode.text forKey:@"msgcode"];
    
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Modify" proc:@"USP_UPDATE_PWD_BySMS_APP" pars:mutDic];
    [MBProgressHUD showActivityIndicator];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [MBProgressHUD showSuccess:@"修改成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } error:^(id error) {
        
    } failure:^(NSError *error) {
        
    }];
}

/** 发送验证码 */
- (void)sendVerification{
    NSMutableDictionary * dic =@{}.mutableCopy;
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Sms" proc:self.userPhone.text pars:dic];
    if (![QLRegularTool isValidateMobile:self.userPhone.text]) {
        [MBProgressHUD showError:@"手机号码不正确"];
        return;
    }
    [MBProgressHUD showActivityIndicator];
    [[NetWorkingManager sharedManager] POSTWithParameters:upData success:^(id responseObject) {
        [self buttonAnimation];
    } error:^(id error) {
    } failure:^(NSError *error) {
    }];
}

/** 验证手机号是否注册 */
- (void)verificationPhone{
    if (![QLRegularTool isValidateMobile:self.userPhone.text]) {
        [MBProgressHUD showError:@"手机号码不正确"];
        return;
    }
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:self.userPhone.text forKey:@"usermb"];
    [mutDic setObject:@"0" forKey:@"usertype"];
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Query" proc:@"QSP_CHECK_USERMB_APP" pars:mutDic];
    [MBProgressHUD showActivityIndicator];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [self buttonAnimation];
        [self sendVerification];//发送验证码
    } error:^(id error) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 点击方法
/** 点击确定按钮 */
- (void)clickNextButton{
    if (!self.consentButton.selected) {
        [MBProgressHUD showError:@"请同意用户协议"];
        return;
    }
    if (self.viewType ==1) {
        [self retrievePassword];
    }else if (self.viewType ==2){
        [self registaerUser];
    }
}

/** 点击发送验证码按钮按钮调用方法 */
- (void)clickSendButton:(UIButton *)send{
    if (self.viewType ==1) {
        [self verificationPhone];
    }else if (self.viewType ==2){
        [self sendVerification];
    }
}
/** 点击勾选是否同意用户协议按钮 */
- (void)clickConsentButton{
    self.consentButton.selected = !self.consentButton.selected;

}

/** 点击查看用户协议按钮 */
- (void)clickAgreement{
    NSLog(@"点击了用户协议按钮");
}

#pragma mark - 监听方法
/** 监听输入框内容变化，改变按钮状态 */
- (void)textFieldValueChange{
    if (self.userPhone.text.length ==11 && self.passWord.text.length >=6 && self.againPassWord.text.length>=6 && self.verificationCode.text.length>0) {
        self.nextButton.userInteractionEnabled = YES;
        [self.nextButton setBackgroundColor:UIColorFromRGB(0x0079FF)];
    }else {
        [self.nextButton setBackgroundColor:COLOR(205, 228, 254, 1)];
        self.nextButton.userInteractionEnabled = NO;
    }
}
/** 结束编辑的状态 */
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.selectTextField = textField;
    self.selectTextField.layer.borderColor = UIColorFromRGB(0xCDCDCD).CGColor;

}
/** 开始编辑状态 */
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.selectTextField = textField;
    self.selectTextField.layer.borderColor = UIColorFromRGB(0x0079FF).CGColor;

}

#pragma mark - UI动画处理
/** 发送验证码动画 */
- (void)buttonAnimation{
    //  *******************************请求验证码倒计时
    __block int timeout=60;//倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^
                                      {
                                          if(timeout<=0){ //倒计时结束，关闭
                                              dispatch_source_cancel(_timer);
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                 //设置界面的按钮显示 根据自己需求设置
                                                                 [_sendButton setTitle:@"重新发送" forState:UIControlStateNormal];
                                                                 _sendButton.userInteractionEnabled = YES;
                                                  [_sendButton setTitleColor:UIColorFromRGB(0x0079FF) forState:UIControlStateNormal];
                                                             });
                                              
                                          }else{
                                              int seconds = timeout % 130;
                                              NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                                              dispatch_async(dispatch_get_main_queue(), ^
                                                             {
                                                                 //设置界面的按钮显示 根据自己需求设置
                                                                 //NSLog(@"____%@",strTime);
                                                                 [UIView beginAnimations:nil context:nil];
                                                                 [UIView setAnimationDuration:0.5];
                                                                 [_sendButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                                                                 [_sendButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
                                                                 [UIView commitAnimations];
                                                                 _sendButton.userInteractionEnabled = NO;
                                                             });
                                              timeout--;
                                          }
                                          
                                      });
    dispatch_resume(_timer);
}

#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);

    [weakself.hintTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(TopHeight+(SCRYFrom6(21)));
        make.left.offset(SCRXFrom6(38));
    }];
    [weakself.littleTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.hintTitle);
        make.top.equalTo(weakself.hintTitle.mas_bottom).offset(2);
    }];
    
    [weakself.userPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.littleTitle.mas_bottom).offset(SCRYFrom6(20));
        make.left.offset(SCRXFrom6(38));
        make.right.offset(SCRXFrom6(-38));
        make.height.offset(SCRYFrom6(40));
    }];
    
    [weakself.verificationCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.userPhone.mas_bottom).offset(SCRYFrom6(11));
        make.left.offset(SCRXFrom6(38));
        make.right.offset(SCRXFrom6(-38));
        make.height.offset(SCRYFrom6(40));
    }];
    
    [weakself.passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.verificationCode.mas_bottom).offset(SCRYFrom6(11));
        make.left.offset(SCRXFrom6(38));
        make.right.offset(SCRXFrom6(-38));
        make.height.offset(SCRYFrom6(40));
    }];
    
    [weakself.againPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.passWord.mas_bottom).offset(SCRYFrom6(11));
        make.left.offset(SCRXFrom6(38));
        make.right.offset(SCRXFrom6(-38));
        make.height.offset(SCRYFrom6(40));
    }];
    
    [weakself.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.againPassWord.mas_bottom).offset(SCRYFrom6(30));
        make.left.offset(SCRXFrom6(38));
        make.right.offset(SCRXFrom6(-38));
        make.height.offset(SCRYFrom6(40));
    }];
    
    [weakself.consentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.nextButton.mas_left);
        make.top.equalTo(weakself.nextButton.mas_bottom).offset(SCRYFrom6(19));
        make.width.height.offset(SCRXFrom6(18));
    }];

    [weakself.consentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.consentButton.mas_right).offset(5);
        make.centerY.equalTo(weakself.consentButton.mas_centerY);
    }];

    [weakself.agreement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.consentLabel.mas_right).offset(0);
        make.centerY.equalTo(weakself.consentButton.mas_centerY);
        make.width.offset(72);
        make.height.offset(17);
    }];
    
}

#pragma mark - 懒加载
- (UILabel *)hintTitle{
    if (!_hintTitle) {
        _hintTitle = [UILabel labelWithText:@"注册" atColor:UIColorFromRGB(0x333333) atTextSize:26 atTextFontForType:@""];
        [self.view addSubview:_hintTitle];
    }
    return _hintTitle;
}
- (UILabel *)littleTitle{
    if (!_littleTitle) {
        _littleTitle = [UILabel labelWithText:@"你离大量订单只差最后一步" atColor:UIColorFromRGB(0x666666) atTextSize:12 atTextFontForType:@""];
        [self.view addSubview:_littleTitle];
    }
    return _littleTitle;
}
- (UITextField *)userPhone{
    if (!_userPhone) {
        _userPhone = [self makeTextWithPlaceholder:@"输入手机号码"];
    }
    return _userPhone;
}
- (UITextField *)verificationCode{
    if (!_verificationCode) {
        _verificationCode = [self makeTextWithPlaceholder:@"输入验证码"];
        _verificationCode.rightView = self.sendButton;
        _verificationCode.rightViewMode = UITextFieldViewModeAlways;
    }
    return _verificationCode;
}
- (UITextField *)passWord{
    if (!_passWord) {
        _passWord = [self makeTextWithPlaceholder:@"输入6-12位密码"];
        _passWord.secureTextEntry = YES;
    }
    return _passWord;
}
- (UITextField *)againPassWord{
    if (!_againPassWord) {
        _againPassWord = [self makeTextWithPlaceholder:@"确认密码"];
        _againPassWord.secureTextEntry = YES;
    }
    return _againPassWord;
}
- (UITextField *)makeTextWithPlaceholder:(NSString *)placeholder{
    UITextField * textField = [UITextField textFieldWithPlaceholder:placeholder];
    textField.layer.cornerRadius = 2;
    textField.layer.masksToBounds = YES;
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = UIColorFromRGB(0xCDCDCD).CGColor;
    textField.delegate = self;
    [self.view addSubview:textField];
    return textField;
}
- (UIButton *)sendButton{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithTitle:@"获取验证码" atTitleSize:14 atTitleColor:UIColorFromRGB(0x0079FF) atTarget:self atAction:@selector(clickSendButton:)];
        _sendButton.bounds = CGRectMake(0, 0, SCRXFrom6(90), 40);
        UIImageView * line = [UIImageView horizontalSeparateImageView];
        line.backgroundColor = UIColorFromRGB(0xCDCDCD);
        [_sendButton addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.offset(0);
            make.width.offset(1);
        }];
        [self.view addSubview:_sendButton];
    }
    return _sendButton;
}
- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithTitle:self.buttonTitle atTitleSize:16 atTitleColor:White_Color atTarget:self atAction:@selector(clickNextButton)];
        [self.nextButton setBackgroundColor:COLOR(205, 228, 254, 1)];
        self.nextButton.userInteractionEnabled = NO;
        _nextButton.layer.cornerRadius = 2;
        _nextButton.layer.masksToBounds = YES;
        [self.view addSubview:_nextButton];
    }
    return _nextButton;
}
- (UIButton *)consentButton{
    if (!_consentButton) {
        _consentButton = [UIButton buttonWithTitle:@"" atTitleSize:0 atTitleColor:White_Color atTarget:self atAction:@selector(clickConsentButton)];
        [_consentButton setImage:[UIImage imageNamed:@"Icons_login_n"] forState:UIControlStateNormal];
        [_consentButton setImage:[UIImage imageNamed:@"Icons_login_y"] forState:UIControlStateSelected];
        _consentButton.selected = NO;
        [self.view addSubview:_consentButton];
    }
    return _consentButton;
}
- (UILabel *)consentLabel{
    if (!_consentLabel) {
        _consentLabel = [UILabel labelWithText:@"阅读并同意" atColor:UIColorFromRGB(0x333333) atTextSize:12 atTextFontForType:@""];
        [self.view addSubview:_consentLabel];
    }
    return _consentLabel;
}
- (UIButton *)agreement{
    if (!_agreement) {
        _agreement = [UIButton buttonWithTitle:@"《用户协议》" atTitleSize:12 atTitleColor:UIColorFromRGB(0x007AFF) atTarget:self atAction:@selector(clickAgreement)];
        [self.view addSubview:_agreement];
    }
    return _agreement;
}

@end
