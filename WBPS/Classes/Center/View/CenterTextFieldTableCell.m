//
//  CenterTextFieldTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/25.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "CenterTextFieldTableCell.h"

@implementation CenterTextFieldTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setSubViewAutoLayout];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldValueChange) name:UITextFieldTextDidChangeNotification object:self.textField];
    }
    return self;
}
/** 监听输入框内容改变调用方法 */
- (void)textFieldValueChange{
    if ([self.delegate respondsToSelector:@selector(textFieldValueChange:textChange:)]) {
        [self.delegate textFieldValueChange:self.cellIndexPath textChange:self.textField.text];
    }
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.centerY.equalTo(weakself.contentView.mas_centerY);
    }];
    
    [weakself.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.left.equalTo(weakself.contentView.mas_right).offset(-120);
        make.height.offset(30);
        make.width.offset(110);
    }];
    
    UILabel * label = [[UILabel alloc]init];
    label.backgroundColor = LineGray_Color;
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(1);
    }];
}


#pragma mark - 懒加载
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"未设定";
        _titleLabel.textColor =Black_Color;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.textColor = COLOR(130, 131, 132, 1);
//        _textField.borderStyle = UITextBorderStyleRoundedRect;
        [self.contentView addSubview:_textField];
    }
    return _textField;
}



@end
