//
//  LeftSlideMenuHeaderView.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/22.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "LeftSlideMenuHeaderView.h"

@interface LeftSlideMenuHeaderView ()

/** 用户名称 */
@property (nonatomic,strong)UILabel * userName;
/** 用户手机号码 */
@property (nonatomic,strong)UILabel * userPhone;
/** 用户是否认证 */
@property (nonatomic,strong)UILabel * attestation;
/** 标记 */
@property (nonatomic,strong)UIImageView * signView;

@end

@implementation LeftSlideMenuHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR(35, 116, 230, 1);
        [self setSubViewAutoLayout];
        [self setData];
    }
    return self;
}
/** 设置数据 */
- (void)setData{
    UIImage * image = UIImageName(@"icon_头像");
    /** 头像URL路径 */
    NSString * titleImageUrl = [kImageBaseUrl stringByAppendingString:[UserModel sharedUserInfo].headimepath];
    NSURL * url = [NSURL URLWithString:titleImageUrl];
    [self.userImage sd_setImageWithURL:url placeholderImage:image];
    
    self.userName.text = [UserModel sharedUserInfo].username;
    
    self.userPhone.text = [UserModel sharedUserInfo].usermb;
    
    if ([[UserModel sharedUserInfo].checkstate intValue]==0){
        self.attestation.text = @"待审核";
    }else if ([[UserModel sharedUserInfo].checkstate intValue]==1){
        self.attestation.text = @"审核通过";
    }else{
        self.attestation.text = @"审核不通过";
    }
    
    
    
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.centerY.equalTo(weakself.mas_centerY);
        make.width.height.offset(60);
    }];
    
    [weakself.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.userImage.mas_right).offset(30);
        make.top.equalTo(weakself.userImage.mas_top).offset(6);
    }];
    
    [weakself.userPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.userName.mas_left);
        make.top.equalTo(weakself.userName.mas_bottom).offset(10);
    }];
    
    [weakself.attestation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.userImage.mas_centerX);
        make.top.equalTo(weakself.userImage.mas_bottom).offset(10);
    }];
    
    [weakself.signView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.userImage.mas_centerY);
        make.right.offset(-20);
        make.width.offset(10);
        make.height.offset(15);
    }];
    
}

#pragma mark - 懒加载
- (UIImageView *)userImage{
    if (!_userImage) {
        _userImage = [[UIImageView alloc]init];
        _userImage.layer.cornerRadius = 30;
        _userImage.layer.masksToBounds = YES;
        _userImage.layer.borderWidth = 1;
        _userImage.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:_userImage];
    }
    return _userImage;
}
- (UILabel *)userName{
    if (!_userName) {
        _userName = [[UILabel alloc]init];
        _userName.text = @"用户名称";
        _userName.textColor = White_Color;
        _userName.font = [UIFont systemFontOfSize:20];
        [self addSubview:_userName];
    }
    return _userName;
}
- (UILabel *)userPhone{
    if (!_userPhone) {
        _userPhone = [[UILabel alloc]init];
        _userPhone.text = @"151****7971";
        _userPhone.textColor = White_Color;
        [self addSubview:_userPhone];
    }
    return _userPhone;
}

- (UILabel *)attestation{
    if (!_attestation) {
        _attestation = [[UILabel alloc]init];
        _attestation.backgroundColor = COLOR(11, 80, 186, 1);
        _attestation.textColor = COLOR(241, 192, 70, 1);
        _attestation.text = @"已认证";
        _attestation.layer.cornerRadius = 5;
        _attestation.layer.masksToBounds = YES;
        [self addSubview:_attestation];
    }
    return _attestation;
}

- (UIImageView *)signView{
    if (!_signView) {
        _signView = [[UIImageView alloc]init];
        [_signView setImage:[UIImage imageNamed:@"jiaobiao"]];
        [self addSubview:_signView];
    }
    return _signView;
}

@end
