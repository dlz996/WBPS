
//
//  DataNullView.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/9.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "DataNullView.h"

@interface DataNullView ()

/** 没有数据 */
@property (nonatomic,strong)UIImageView * imageView;

@end

@implementation DataNullView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubViewAutoLayout];
        self.backgroundColor = COLOR(243, 244, 245, 1);
    }
    return self;
}

- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.mas_centerX);
        make.centerY.equalTo(weakself.mas_centerY);
        make.width.offset(148);
        make.height.offset(208);
    }];
}
- (UIImageView *)imageView{
    if (!_imageView){
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:@"DataNull"];
        [self addSubview:_imageView];
    }
    return _imageView;
}


@end
