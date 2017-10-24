//
//  LoginUpPhotoTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/26.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "LoginUpPhotoTableCell.h"

@interface LoginUpPhotoTableCell ()<UITextFieldDelegate>
@property (nonatomic,strong)UIView * bgView;
@end

@implementation LoginUpPhotoTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = COLOR(222, 222, 222, 1);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setSubViewAutoLayout];

        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldValueChange) name:UITextFieldTextDidChangeNotification object:self.textField];
    }
    return self;
}


#pragma mark - 赋值
- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@[@"photo_id",@"photo_driving_license",@"photo_car_license",@"photo_opration_license"][_indexPath.row]]];
    self.titleImage.image = image;
    NSURL * url = [NSURL URLWithString:[kImageBaseUrl stringByAppendingString:_imageUrl]];
    [self.titleImage sd_setImageWithURL:url placeholderImage:image];
}

#pragma mark - 点击方法
/** 点击图片调用的方法 */
- (void)clickTitleImage{
    if ([self.delegate respondsToSelector:@selector(clickCellTitleImage:)]){
        [self.delegate clickCellTitleImage:self.indexPath];
    }
}

/** 监听输入框内容改变调用方法 */
- (void)textFieldValueChange{
    if ([self.delegate respondsToSelector:@selector(textFieldValueChange:textChange:)]) {
        [self.delegate textFieldValueChange:self.indexPath textChange:self.textField.text];
    }
}


#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    
    [weakself.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(0);
        
        make.top.offset(5);
    }];
   
    
    [weakself.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SCRXFrom6(20));
        make.top.offset(SCRYFrom6(20));
        make.height.offset(SCRYFrom6(85));
        make.width.offset(SCRXFrom6(125));
    }];
    
    [weakself.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.titleImage.mas_right).offset(17);
        make.top.equalTo(weakself.titleImage.mas_top);
    }];
    
    [weakself.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.titleLabel.mas_left);
        make.top.equalTo(weakself.titleLabel.mas_bottom).offset(5);
        make.height.offset(25);
        make.right.equalTo(weakself.bgView.mas_right).offset(-20);
    }];
    
}



#pragma mark - 懒加载
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = White_Color;
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}

- (UIImageView *)titleImage{
    if (!_titleImage) {
        _titleImage = [[UIImageView alloc]init];
        _titleImage.layer.cornerRadius = 5;
        _titleImage.layer.masksToBounds = YES;
        //开启交互
        _titleImage.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTitleImage)];
        [_titleImage addGestureRecognizer:tap];
        [self.bgView addSubview:_titleImage];
    }
    return _titleImage;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = Black_Color;
        _titleLabel.text = @"请填入身份证号码";
        [self.bgView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.delegate = self;
        _textField.backgroundColor = COLOR(222, 222, 222, 1);
        [self.bgView addSubview:_textField];
    }
    return _textField;
}

@end
