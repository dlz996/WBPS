//
//  AddBankCardTableCell.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/28.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "AddBankCardTableCell.h"

@interface AddBankCardTableCell ()<UITextFieldDelegate>


@end

@implementation AddBankCardTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldValueChange) name:UITextFieldTextDidChangeNotification object:self.textField];
    }
    return self;
}

/** 监听输入框内容改变调用方法 */
- (void)textFieldValueChange{
    if ([self.delegate respondsToSelector:@selector(textFieldValueChange:textChange:)]) {
        [self.delegate textFieldValueChange:self.indexPath textChange:self.textField.text];
    }
}

/** 设置下标 */
- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    [self setSubViewAutoLayout];
}



#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    
    [weakself.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SCRXFrom6(17.5));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
    }];
    if (_indexPath.row ==2) {
        [weakself.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.contentView.mas_centerY);
            make.right.offset(-20).priorityHigh(750);
            make.height.offset(30);
            make.left.equalTo(weakself.titleLabel.mas_right).offset(20).priorityLow(300);
        }];
    }else{
        [weakself.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.contentView.mas_centerY);
            make.right.offset(-20);
            make.height.offset(30);
            make.left.equalTo(weakself.titleLabel.mas_right).offset(20);
        }];
    }
    
    UIImageView * line = [UIImageView horizontalSeparateImageView];
    [weakself.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(1);
    }];
}
#pragma mark - 懒加载
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"" atColor:Black_Color atTextSize:16 atTextFontForType:@""];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.delegate = self;
        _textField.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_textField];
    }
    return _textField;
}
- (UILabel *)hintLabel{
    if (!_hintLabel) {
        _hintLabel = [UILabel labelWithText:@"请选择" atColor:COLOR(162,163,164,1) atTextSize:16 atTextFontForType:@""];
        [self.contentView addSubview:_hintLabel];
    }
    return _hintLabel;
}

@end
