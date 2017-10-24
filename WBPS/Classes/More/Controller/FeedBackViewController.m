//
//  FeedBackViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/11.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()<UITextViewDelegate>

@property (nonatomic,strong)UILabel * placeholderLabel;

@property (nonatomic,strong)UITextView * feddBaclTextView;

@property (nonatomic,strong)UIButton * upDataButton;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self setSubViewAutoLayout];
}
#pragma mark - 点击方法
- (void)clickUpData{
   
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    [mutDic setObject:self.feddBaclTextView.text forKey:@"opinioncontent"];
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Modify" proc:@"USP_ADD_OpinionInfo" pars:mutDic];
    [MBProgressHUD showActivityIndicator];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        
//        _placeholderLabel.text = @"请输入遇到的问题或建议...";
//        self.upDataButton.backgroundColor = COLOR(214, 216, 215, 1);
//        self.upDataButton.userInteractionEnabled = NO;
        [MBProgressHUD showSuccess:@"反馈成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.feddBaclTextView.text = @"";
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } error:^(id error) {
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - 代理方法
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0 ){
        _placeholderLabel.text = @"请输入遇到的问题或建议...";
        self.upDataButton.backgroundColor = COLOR(214, 216, 215, 1);
        self.upDataButton.userInteractionEnabled = NO;
    }else{
        _placeholderLabel.text = @"";
        self.upDataButton.backgroundColor = COLOR(34, 114, 230, 1);
        self.upDataButton.userInteractionEnabled = YES;
    }
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    
    CGFloat top = iPhoneX?84:64;
    [weakself.feddBaclTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.offset(top+20);
        make.height.offset(200);
    }];
    [weakself.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(7);
        make.width.offset(270);
        make.height.offset(15);
    }];
    [weakself.upDataButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.feddBaclTextView.mas_left);
        make.right.equalTo(weakself.feddBaclTextView.mas_right);
        make.top.equalTo(weakself.feddBaclTextView.mas_bottom).offset(5);
        make.height.offset(40);
    }];
}

#pragma mark - 懒加载
- (UITextView *)feddBaclTextView{
    if (!_feddBaclTextView) {
        _feddBaclTextView = [[UITextView alloc]init];
        _feddBaclTextView.delegate = self;
        _feddBaclTextView.layer.cornerRadius = 10;
        _feddBaclTextView.layer.masksToBounds = YES;
        _feddBaclTextView.layer.borderWidth = 1.5;
        _feddBaclTextView.layer.borderColor = COLOR(180, 180, 180, 1).CGColor;
        _feddBaclTextView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_feddBaclTextView];
    }
    return _feddBaclTextView;
}

- (UILabel *)placeholderLabel{
    if (!_placeholderLabel){
        _placeholderLabel = [UILabel labelWithText:@"请输入遇到的问题或建议..." atColor:Text_Color_Three atTextSize:Title_Size_Font atTextFontForType:Common_Font];
        [self.feddBaclTextView addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}
- (UIButton *)upDataButton{
    if (!_upDataButton) {
        _upDataButton = [UIButton buttonWithTitle:@"提交" atTitleSize:18 atTitleColor:Black_Color atTarget:self atAction:@selector(clickUpData)];
        _upDataButton.backgroundColor = COLOR(214, 216, 215, 1);
        _upDataButton.userInteractionEnabled = NO;
        _upDataButton.layer.cornerRadius = 5;
        _upDataButton.layer.masksToBounds = YES;
        [self.view addSubview:_upDataButton];
    }
    return _upDataButton;
}

@end
