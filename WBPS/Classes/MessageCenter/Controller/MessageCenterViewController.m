//
//  MessageCenterViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/21.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "MessageCenterViewController.h"
/** 消息中心头视图 */
#import "MessageCenterHeaderView.h"
/** 公告 */
#import "AnnouncementViewController.h"
/** 消息 */
#import "MessageViewController.h"
@interface MessageCenterViewController ()<UIScrollViewDelegate,MessageCenterHeaderDelegate>{
    float tapHeight;
}
/** 头视图 */
@property (nonatomic,strong)MessageCenterHeaderView * headerView;
@property (nonatomic,strong)UIScrollView * scrollView;

@end
static NSString *const CellID = @"CellID";
@implementation MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
     tapHeight = iPhoneX?84:64;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.scrollView];
    
    
    AnnouncementViewController * announcementVc = [[AnnouncementViewController alloc]init];
    announcementVc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-tapHeight-60);
    [self addChildViewController:announcementVc];
    [self.scrollView addSubview:announcementVc.view];
    
    MessageViewController * messageVc = [[MessageViewController alloc]init];
    messageVc.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-tapHeight-60);
    [self addChildViewController:messageVc];
    [self.scrollView addSubview:messageVc.view];
    
}

#pragma mark - 子视图代理方法
/**
 点击头部按钮调用方法
 
 @param type 1 公告 2 消息
 */
- (void)changeView:(NSInteger)type{
    if (type ==1) {
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.contentOffset =CGPointMake(0, 0);
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        }];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x>=SCREEN_WIDTH) {
        self.headerView.type = 2;
    }else{
        self.headerView.type = 1;
    }
}


#pragma mark - 懒加载
- (MessageCenterHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[MessageCenterHeaderView alloc]initWithFrame:CGRectMake(0, tapHeight, SCREEN_WIDTH, 60)];
        _headerView.delegate = self;
    }
    return _headerView;
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, tapHeight+60, SCREEN_WIDTH, SCREEN_HEIGHT-tapHeight-60)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, SCREEN_HEIGHT-tapHeight-60);
    }
    return _scrollView;
}
@end
