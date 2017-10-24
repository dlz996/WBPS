//
//  ChangePasswordViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/29.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()
/** 用户名 */
@property (nonatomic,strong)UITextField * userName;
/** 老密码 */
@property (nonatomic,strong)UITextField * oldPassWord;
/** 输入新密码 */
@property (nonatomic,strong)UITextField * newPassWord;
/** 再次输入新密码 */
@property (nonatomic,strong)UITextField *againPassWord;
/** 确认 */
@property (nonatomic,strong)UIButton * confirmButton;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [self setSubViewAutoLayout];
}
#pragma mark - 点击事件
/** 点击了确认按钮 */
- (void)clickConfirmButton{
    if (self.newPassWord.text.length <6) {
        [MBProgressHUD showError:@"最少输入6位字符"];
        return;
    }
//    pars={"method":"Modify","proc":"USP_UPDATE_PWD_APP","pars":[{参数}]}
//    json数组参数说明：
//    @userid INT,        --用户id
//    @pwd VARCHAR(50),    --旧密码
//    @newpwd VARCHAR(50)     --新密码
//    返回内容示例
    
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    [mutDic setObject:self.oldPassWord.text forKey:@"pwd"];
    [mutDic setObject:self.newPassWord.text forKey:@"newpwd"];
    
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Modify" proc:@"USP_UPDATE_PWD_APP" pars:mutDic];
    [MBProgressHUD showActivityIndicator];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [MBProgressHUD showSuccess:@"修改成功"];
    } error:^(id error) {
    } failure:^(NSError *error) {
    }];
    
}
#pragma mark- 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    CGFloat navBarHeader = 0;
    if (iPhoneX) {
        navBarHeader = 88;
    }else{
        navBarHeader = 64;
    }
    [weakself.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(navBarHeader+(SCRYFrom6(30)));
        make.centerX.equalTo(weakself.view.mas_centerX);
        make.width.offset(SCRXFrom6(300));
        make.height.offset(SCRYFrom6(40));
    }];
    
    [weakself.oldPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.userName.mas_bottom).offset(SCRYFrom6(15));
        make.centerX.equalTo(weakself.view.mas_centerX);
        make.width.offset(SCRXFrom6(300));
        make.height.offset(SCRYFrom6(40));
    }];
    
    [weakself.newPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.oldPassWord.mas_bottom).offset(SCRYFrom6(15));
        make.centerX.equalTo(weakself.view.mas_centerX);
        make.width.offset(SCRXFrom6(300));
        make.height.offset(SCRYFrom6(40));
    }];
    [weakself.againPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.newPassWord.mas_bottom).offset(SCRYFrom6(15));
        make.centerX.equalTo(weakself.view.mas_centerX);
        make.width.offset(SCRXFrom6(300));
        make.height.offset(SCRYFrom6(40));
    }];
    
    [weakself.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.againPassWord.mas_bottom).offset(SCRYFrom6(30));
        make.centerX.equalTo(weakself.view.mas_centerX);
        make.width.offset(SCRXFrom6(300));
        make.height.offset(SCRYFrom6(40));
    }];
}
#pragma mark - 懒加载
- (UITextField *)userName{
    if (!_userName) {
        UIImageView * lefImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"userLogin"]];
        lefImage.bounds = CGRectMake(0, 0, 50, 25);
        lefImage.contentMode = UIViewContentModeScaleAspectFit;
        _userName = [[UITextField alloc]init];
        _userName.placeholder = @"请输入手机号";
        _userName.layer.cornerRadius = SCRYFrom6(20);
        _userName.layer.masksToBounds = YES;
        _userName.layer.borderWidth = 0.5;
        _userName.layer.borderColor = [UIColor grayColor].CGColor;
        _userName.leftView = lefImage;
        _userName.leftViewMode = UITextFieldViewModeAlways;
        [self.view addSubview:_userName];
    }
    return _userName;
}
- (UITextField *)oldPassWord{
    if (!_oldPassWord) {
        UIImageView * lefImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pwdLogin"]];
        lefImage.bounds = CGRectMake(0, 0, 50, 25);
        lefImage.contentMode = UIViewContentModeScaleAspectFit;
        _oldPassWord = [[UITextField alloc]init];
        _oldPassWord.placeholder = @"请输入旧密码";
        _oldPassWord.layer.cornerRadius = SCRYFrom6(20);
        _oldPassWord.layer.masksToBounds = YES;
        _oldPassWord.layer.borderWidth = 0.5;
        _oldPassWord.layer.borderColor = [UIColor grayColor].CGColor;
        _oldPassWord.leftView = lefImage;
        _oldPassWord.leftViewMode = UITextFieldViewModeAlways;
        [self.view addSubview:_oldPassWord];
    }
    return _oldPassWord;
}

- (UITextField *)newPassWord{
    if (!_newPassWord) {
        UIImageView * lefImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pwdLogin"]];
        lefImage.bounds = CGRectMake(0, 0, 50, 25);
        lefImage.contentMode = UIViewContentModeScaleAspectFit;
        _newPassWord = [[UITextField alloc]init];
        _newPassWord.placeholder = @"请输入新密码";
        _newPassWord.secureTextEntry = YES;
        _newPassWord.layer.cornerRadius = SCRYFrom6(20);
        _newPassWord.layer.masksToBounds = YES;
        _newPassWord.layer.borderWidth = 0.5;
        _newPassWord.layer.borderColor = [UIColor grayColor].CGColor;
        _newPassWord.leftView = lefImage;
        _newPassWord.leftViewMode = UITextFieldViewModeAlways;
        [self.view addSubview:_newPassWord];
    }
    return _newPassWord;
}

- (UITextField *)againPassWord{
    if (!_againPassWord) {
        UIImageView * lefImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pwdLogin"]];
        lefImage.bounds = CGRectMake(0, 0, 50, 25);
        lefImage.contentMode = UIViewContentModeScaleAspectFit;
        _againPassWord = [[UITextField alloc]init];
        _againPassWord.placeholder = @"请确认密码";
        _againPassWord.secureTextEntry = YES;
        _againPassWord.layer.cornerRadius = SCRYFrom6(20);
        _againPassWord.layer.masksToBounds = YES;
        _againPassWord.layer.borderWidth = 0.5;
        _againPassWord.layer.borderColor = [UIColor grayColor].CGColor;
        _againPassWord.leftView = lefImage;
        _againPassWord.leftViewMode = UITextFieldViewModeAlways;
        [self.view addSubview:_againPassWord];
    }
    return _againPassWord;
}
- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setBackgroundColor:COLOR(249, 95, 87, 1)];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:White_Color forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(clickConfirmButton) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.layer.cornerRadius = SCRYFrom6(20);
        _confirmButton.layer.masksToBounds = YES;
        [self.view addSubview:_confirmButton];
    }
    return _confirmButton;
}


@end
