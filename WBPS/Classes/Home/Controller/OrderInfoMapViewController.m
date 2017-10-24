//
//  OrderInfoMapViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/10.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "OrderInfoMapViewController.h"

@interface OrderInfoMapViewController ()<AMapNaviDriveManagerDelegate,
AMapNaviDriveViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) AMapNaviDriveView *driveView;

@property (nonatomic,strong)AMapNaviPoint * startPoint;
@property (nonatomic,strong)AMapNaviPoint * middlePoint;
@property (nonatomic,strong)AMapNaviPoint * endPoint;


@end

@implementation OrderInfoMapViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.driveView];
    if (self.type ==1) {
        [self getUserLocation];
    }else{
        [self.Manager addDataRepresentative:self.driveView];
        [self.Manager startGPSNavi];
    }
    
//    [self getUserLocation];
}

#pragma mark - 定位
- (void)getUserLocation{
    [[LWLocationManager sharedManager]getLocationSuccess:^(CLLocationCoordinate2D coordinate) {
        self.startPoint = [AMapNaviPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        [self loadGPSNavi];
    } Regeocode:^(AMapLocationReGeocode *regeocode) {
    } error:^(id error) {
    }];
}
/** 初始化路径规划 */
- (void)loadGPSNavi{
    self.middlePoint = [AMapNaviPoint locationWithLatitude:[self.model.blat floatValue] longitude:[self.model.blng floatValue]];
    self.endPoint = [AMapNaviPoint locationWithLatitude:[self.model.elat floatValue] longitude:[self.model.elng floatValue]];
    if (self.Manager == nil){
        self.Manager = [[AMapNaviDriveManager alloc] init];
        self.Manager.delegate = self;
    }
    [self.Manager addDataRepresentative:self.driveView];
    AMapNaviDrivingStrategy  drivign = ConvertDrivingPreferenceToDrivingStrategy(YES, YES, NO, NO, NO);
    //路径规划
    [self.Manager calculateDriveRouteWithStartPoints:@[self.startPoint]
                                                endPoints:@[self.endPoint]
                                                wayPoints:@[self.middlePoint]
                                          drivingStrategy:drivign];
}

//路径规划成功后，开始导航
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager{
    [self.Manager startGPSNavi];
}
//规划失败
- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error{
    UIAlertView * aleView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"导航失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [aleView show];
}
- (void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView{
    NSLog(@"点击了关闭导航");
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认退出导航？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setModel:(TaskInfoModel *)model{
    _model = model;
}
- (void)setType:(NSInteger)type{
    _type = type;
}
#pragma mark - 懒加载
- (AMapNaviDriveView *)driveView{
    if (!_driveView) {
        _driveView = [[AMapNaviDriveView alloc] initWithFrame:self.view.bounds];
        _driveView.showMoreButton = NO;
        [_driveView setDelegate:self];
    }
    return _driveView;
}
@end
