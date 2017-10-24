//
//  LeftSlideMenuView.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/22.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "LeftSlideMenuView.h"
#import "LeftSlideMenuTableCell.h"
@interface LeftSlideMenuView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableView;
/** 右侧灰色View */
@property (nonatomic,strong)UIView * rightView;

/** 返回按钮 */
@property (nonatomic,strong)UIButton * returnButton;
@end
static NSString *const CellID = @"CellID";
@implementation LeftSlideMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(clickRightView)];
        swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeGesture];
        [self.tableView registerClass:[LeftSlideMenuTableCell class] forCellReuseIdentifier:CellID];
        [self setSubViewAutoLayout];
    }
    return self;
}


#pragma mark - 点击方法
/**
 点击右侧空白视图调用方法
 用来控制关闭侧滑菜单
 */
- (void)clickRightView{
    if ([self.delegate respondsToSelector:@selector(clickLeftBlackView)]) {
        [self.delegate clickLeftBlackView];
    }
}

/**
 点击头部视图调用方法
 */
- (void)clickTableViewHeaderView{
    if ([self.delegate respondsToSelector:@selector(clickMenuSelect:)]) {
        [self.delegate clickMenuSelect:4];
    }
}


#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftSlideMenuTableCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.contentLabel.text = @[@"我的账户",@"消息中心",@"接单设置",@"更多"][indexPath.row];
    NSString * str = @[@"wdzh",@"xxzx",@"jdsz",@"gd"][indexPath.row];
    cell.iconView.image = [UIImage imageNamed:str];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(clickMenuSelect:)]) {
        [self.delegate clickMenuSelect:indexPath.row];
    }}

#pragma makr - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    float width = SCREEN_WIDTH * 0.8;
    [weakself.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.height.offset(SCREEN_HEIGHT);
        make.width.offset(width);
    }];
    
    [weakself.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhoneX) {
            make.top.offset(44);
        }else{
            make.top.offset(0);
        }
        make.right.offset(0);
        make.height.offset(SCREEN_HEIGHT);
        make.width.offset(SCREEN_WIDTH-width);
    }];
    
    [weakself.returnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.tableView.mas_right).offset(-20);
        make.height.with.offset(20);
        if (iPhoneX) {
            make.top.offset(64);
        }else{
            make.top.offset(20);
        }
    }];
}

#pragma makr - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = White_Color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
        [self addSubview:_tableView];
    }
    return _tableView;
}
- (UIView *)rightView{
    if (!_rightView) {
        _rightView = [[UIView alloc]init];
        _rightView.backgroundColor = Black_Color;
        _rightView.alpha = 0.8;
        _rightView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickRightView)];
        [_rightView addGestureRecognizer:tap];
        [self addSubview:_rightView];
    }
    return _rightView;
}
- (LeftSlideMenuHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[LeftSlideMenuHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.8, 200)];
        _headerView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTableViewHeaderView)];
        [_headerView addGestureRecognizer:tap];
    }
    return _headerView;
}

- (UIButton *)returnButton{
    if (!_returnButton) {
        _returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _returnButton.backgroundColor = Red_Color;
        [_returnButton setBackgroundImage:[UIImage imageNamed:@"X"] forState:UIControlStateNormal];
//        [_returnButton setImage:[UIImage imageNamed:@"X"] forState:UIControlStateNormal];
        [_returnButton addTarget:self action:@selector(clickRightView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_returnButton];
    }
    return _returnButton;
}
@end
