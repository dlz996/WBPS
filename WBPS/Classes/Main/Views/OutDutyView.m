//
//  OutDutyView.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/28.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "OutDutyView.h"
#import "OutDutyViewCell.h"
@interface OutDutyView ()<UITableViewDataSource,UITableViewDelegate>
/** 背景图片 */
@property (nonatomic,strong)UIImageView *bgImage;
/** 动画视图 */
@property (nonatomic,strong)UIImageView * animationView;
/** 数据 */
@property (nonatomic,strong)UITableView * tableView;
/** 提示文本 */
@property (nonatomic,strong)UILabel * hintLabel;


@end

static NSString *const CellID = @"CellID";
@implementation OutDutyView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.tableView registerClass:[OutDutyViewCell class] forCellReuseIdentifier:CellID];
        [self setSubViewAutoLayout];
    }
    return self;
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OutDutyViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.titleLabel.text = @[@"今日收入",@"今日成单",@"累计积分"][indexPath.row];
    return cell;
}


#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
    
    [weakself.animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-50);
        make.centerX.equalTo(weakself.bgImage.mas_centerX);
        make.width.height.offset(SCRXFrom6(50));
    }];
    
    [weakself.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(100);
        make.height.offset(300);
    }];

    [weakself.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.bgImage.mas_centerX);
        make.bottom.offset(-20);
    }];
    
}

#pragma mark - 懒加载
- (UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [UIImageView imageViewWithImageName:@"backGround"];
        _bgImage.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_bgImage];
    }
    return _bgImage;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.bgImage addSubview:_tableView];
    }
    return _tableView;
}
- (UIImageView *)animationView{
    if (!_animationView) {
        NSMutableArray * animationArray = [NSMutableArray array];
        for (int i=1; i<4; i++){
            NSString *str=[NSString stringWithFormat:@"animation%d.png",i];
            UIImage *image=[UIImage imageNamed:str];
            [animationArray addObject:image];
        }
        _animationView = [[UIImageView alloc]init];
        _animationView.animationImages = animationArray;
        _animationView.animationDuration = 1;
        _animationView.animationRepeatCount = 0;
        [_animationView startAnimating];
        [self.bgImage addSubview:_animationView];
    }
    return _animationView;
}
- (UILabel *)hintLabel{
    if (!_hintLabel) {
        _hintLabel = [UILabel labelWithText:@"向上滑动,开始上班" atColor:White_Color atTextSize:16 atTextFontForType:@""];
        [self.bgImage addSubview:_hintLabel];
    }
    return _hintLabel;
}
@end
