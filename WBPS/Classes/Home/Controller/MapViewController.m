//
//  MapViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/27.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "MapViewController.h"
/** 地图页面订单详情页面 */
#import "MapOrderInfoView.h"
/** 订单详情页面 */
#import "SignOrderViewController.h"
/** 导航详情页面 */
#import "OrderInfoMapViewController.h"
/** 异常控制器 */
#import "AbnormalViewController.h"
/** 地图详情控制器 */
#import "OrderInfoMapViewController.h"
/** 地理位置标注点 */
#import "CustomPointAnnotation.h"
/** 路径信息类 */
#import "SelectableOverlay.h"
@interface MapViewController ()
<MAMapViewDelegate,
AMapLocationManagerDelegate,
MapOrderInfoViewDelegate,
AMapNaviDriveManagerDelegate,
AMapNaviDriveViewDelegate,
UIAlertViewDelegate
>

/** 订单详情 */
@property (nonatomic,strong)MapOrderInfoView * orderInfo;
/** 基础地图 */
@property (nonatomic,strong)MAMapView * mapView;
/** 地图管理 */
@property (nonatomic,strong)AMapNaviDriveManager * driveManager;
/** 我的位置 */
@property (nonatomic,strong)AMapNaviPoint * startPoint;
/** 接货点 */
@property (nonatomic,strong)AMapNaviPoint * middlePoint;
/** 到货点 */
@property (nonatomic,strong)AMapNaviPoint * endPoint;



@property (nonatomic, strong) NSMutableArray *routeIndicatorInfoArray;
/** 路径ID */
@property (nonatomic,assign)NSInteger wayID;

@end

@implementation MapViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIBarButtonItem *rightttItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"phone"] style:UIBarButtonItemStyleDone target:self action:@selector(clickCallButton)];
    self.navigationItem.rightBarButtonItem = rightttItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.wayID = 0;
    self.routeIndicatorInfoArray = [NSMutableArray array];
    self.title = self.model.unit;
    self.view.backgroundColor = White_Color;

    [AMapServices sharedServices].enableHTTPS = YES;
    [self.view addSubview:self.mapView];
    [self getUserLocation];
    [self setSubViewAutoLayout];
}
#pragma mark - 定位
/** 获取用户位置 */
- (void)getUserLocation{
    [[LWLocationManager sharedManager]getLocationSuccess:^(CLLocationCoordinate2D coordinate) {
        self.startPoint = [AMapNaviPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        [self addPoint];
        self.mapView.centerCoordinate = coordinate;
        [self initDriveManager];
    } Regeocode:^(AMapLocationReGeocode *regeocode) {
    } error:^(id error) {
    }];
}
- (void)initDriveManager{
    if (self.driveManager == nil) {
        self.driveManager = [[AMapNaviDriveManager alloc] init];
        self.driveManager.delegate = self;
    }
    AMapNaviDrivingStrategy  drivign = ConvertDrivingPreferenceToDrivingStrategy(YES, YES, NO, NO, NO);
    //路径规划
    [self.driveManager calculateDriveRouteWithStartPoints:@[self.startPoint]
                                                endPoints:@[self.endPoint]
                                                wayPoints:@[self.middlePoint]
                                          drivingStrategy:drivign];
}
/** 添加点 */
- (void)addPoint{
    CustomPointAnnotation *beginAnnotation = [[CustomPointAnnotation alloc] init];
    [beginAnnotation setCoordinate:CLLocationCoordinate2DMake(self.startPoint.latitude, self.startPoint.longitude)];
    beginAnnotation.pointID = 1;
    [self.mapView addAnnotation:beginAnnotation];
    CustomPointAnnotation *middleAnnotation = [[CustomPointAnnotation alloc] init];
    [middleAnnotation setCoordinate:CLLocationCoordinate2DMake(self.middlePoint.latitude, self.middlePoint.longitude)];
    middleAnnotation.pointID = 2;
    [self.mapView addAnnotation:middleAnnotation];
    CustomPointAnnotation *endAnnotation = [[CustomPointAnnotation alloc] init];
    [endAnnotation setCoordinate:CLLocationCoordinate2DMake(self.endPoint.latitude, self.endPoint.longitude)];
    endAnnotation.pointID = 3;
    [self.mapView addAnnotation:endAnnotation];
}
/** 重绘大头针 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[CustomPointAnnotation class]]){
        static NSString *poiIdentifier = @"poiIdentifier";
        MAPinAnnotationView *poiAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:poiIdentifier];
        if (poiAnnotationView == nil){
            poiAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:poiIdentifier];
        }
        CustomPointAnnotation *custom = annotation;
        poiAnnotationView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@[@"star",@"middle",@"end"][custom.pointID-1]]];
        poiAnnotationView.canShowCallout = NO;
        return poiAnnotationView;
    }
    return nil;
}
/**
 * @brief 根据overlay生成对应的Renderer
 * @param mapView 地图View
 * @param overlay 指定的overlay
 * @return 生成的覆盖物Renderer      2
 */
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay{
    if ([overlay isKindOfClass:[SelectableOverlay class]]){
        SelectableOverlay * selectableOverlay = (SelectableOverlay *)overlay;
        id<MAOverlay> actualOverlay = selectableOverlay.overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:actualOverlay];
        polylineRenderer.lineWidth = 10.0;
        [polylineRenderer loadStrokeTextureImage:[UIImage imageNamed:@"navi"]];
        return polylineRenderer;
    }
    return nil;
}

/** 计算路径 */
- (void)showNaviRoutes{
    if ([self.driveManager.naviRoutes count] <= 0){
        return;
    }
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.routeIndicatorInfoArray removeAllObjects];
    //将路径显示到地图上
    for (NSNumber *aRouteID in [self.driveManager.naviRoutes allKeys]){
        AMapNaviRoute *aRoute = [[self.driveManager naviRoutes] objectForKey:aRouteID];
        int count = (int)[[aRoute routeCoordinates] count];
        //添加路径Polyline
        CLLocationCoordinate2D *coords = (CLLocationCoordinate2D *)malloc(count * sizeof(CLLocationCoordinate2D));
        for (int i = 0; i < count; i++){
            AMapNaviPoint *coordinate = [[aRoute routeCoordinates] objectAtIndex:i];
            coords[i].latitude = [coordinate latitude];
            coords[i].longitude = [coordinate longitude];
        }
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coords count:count];
        SelectableOverlay *selectablePolyline = [[SelectableOverlay alloc] initWithOverlay:polyline];
        [selectablePolyline setRouteID:[aRouteID integerValue]];
        [self.mapView addOverlay:selectablePolyline];
        free(coords);
    }
    
    [self.mapView showAnnotations:self.mapView.annotations animated:NO];
    [self selectNaviRouteWithID:[[self.routeIndicatorInfoArray firstObject] routeID]];
}
- (void)selectNaviRouteWithID:(NSInteger)routeID{
    //在开始导航前进行路径选择
    if ([self.driveManager selectNaviRouteWithRouteID:routeID]){
        [self selecteOverlayWithRouteID:routeID];
    }
}
- (void)selecteOverlayWithRouteID:(NSInteger)routeID{
    [self.mapView.overlays enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id<MAOverlay> overlay, NSUInteger idx, BOOL *stop){
        if ([overlay isKindOfClass:[SelectableOverlay class]]){
            SelectableOverlay *selectableOverlay = overlay;
            /* 获取overlay对应的renderer. */
            MAPolylineRenderer * overlayRenderer = (MAPolylineRenderer *)[self.mapView rendererForOverlay:selectableOverlay];
            if (selectableOverlay.routeID == routeID){
                /* 设置选中状态. */
                selectableOverlay.selected = YES;
                /* 修改renderer选中颜色. */
                overlayRenderer.fillColor   = selectableOverlay.selectedColor;
                overlayRenderer.strokeColor = selectableOverlay.selectedColor;
                [overlayRenderer loadStrokeTextureImage:[UIImage imageNamed:@"navi"]];
                /* 修改overlay覆盖的顺序. */
                [self.mapView exchangeOverlayAtIndex:idx withOverlayAtIndex:self.mapView.overlays.count - 1];
            }else{
                /* 设置非选中状态. */
                selectableOverlay.selected = NO;
                /* 修改renderer选中颜色. */
                overlayRenderer.fillColor   = selectableOverlay.regularColor;
                overlayRenderer.strokeColor = selectableOverlay.regularColor;
                [overlayRenderer loadStrokeTextureImage:[UIImage imageNamed:@"red_navi"]];
            }
            [overlayRenderer glRender];
        }
    }];
}

/** 路线规划成功回调 */
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager{
    [self showNaviRoutes];
}
- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error{
    UIAlertView * aleView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"导航失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [aleView show];
}

#pragma mark - 数据处理，条件判断
/** 发送到达卸货地的请求   1 出发      2 到达卸货地   */
- (void)upData:(NSInteger)upDataType{
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:self.model.mainid forKey:@"orderid"];
    [mutDic setObject:self.model.gid forKey:@"orderinfoid"];
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    [mutDic setObject:@(self.startPoint.latitude) forKey:@"lat"];
    [mutDic setObject:@(self.startPoint.longitude) forKey:@"lng"];
    if (upDataType ==1) {
        [mutDic setObject:@"1" forKey:@"reporttypeid"];
    }else{
        [mutDic setObject:@"2" forKey:@"reporttypeid"];
    }
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Modify" proc:@"USP_UPDATE_REPORTORDER_APP_EX" pars:mutDic];
    [MBProgressHUD showActivityIndicator];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        if (upDataType ==1) {
            [self.orderInfo.typeButton setTitle:@"到达卸货地" forState:UIControlStateNormal];
        }else{
            [self.orderInfo.typeButton setTitle:@"签收" forState:UIControlStateNormal];
        }
    } error:^(id error) {
    } failure:^(NSError *error) {
    }];
}

#pragma mark - 设置定位点的数据
- (void)setModel:(TaskInfoModel *)model{
    _model = model;
    self.middlePoint = [AMapNaviPoint locationWithLatitude:[self.model.blat floatValue] longitude:[self.model.blng floatValue]];
    self.endPoint = [AMapNaviPoint locationWithLatitude:[self.model.elat floatValue] longitude:[self.model.elng floatValue]];
}
#pragma mark - 点击事件
/** 点击拨号按钮 */
- (void)clickCallButton{
    NSString * tellString = [NSString stringWithFormat:@"tel:%@",self.model.consigneemb];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tellString]];
}
/**
 点击订单详情页面导航  到达目的地按钮调用的方法
 
 @param type 1 导航  2 到达目的地、签收  3异常
 */
- (void)clickBottomButton:(NSInteger)type{
    
    if (type ==2) {//导航
        
        
        if ([self.orderInfo.typeButton.titleLabel.text isEqualToString:@"到达卸货地"]) {
            UIAlertView * aleView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认到货吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            aleView.tag = 2;
            [aleView show];
        } else if ([self.orderInfo.typeButton.titleLabel.text isEqualToString:@"出发"]){
            UIAlertView * aleView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认出发吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            aleView.tag = 1;
            [aleView show];
        }else{
            SignOrderViewController * signVc = [[SignOrderViewController alloc]init];
            signVc.model = self.model;
            [self.navigationController pushViewController:signVc animated:YES];
        }
    }else if (type==1){ //签收
        OrderInfoMapViewController * infoMapVc = [[OrderInfoMapViewController alloc]init];
        infoMapVc.model = self.model;
        infoMapVc.Manager = self.driveManager;
        [self.navigationController pushViewController:infoMapVc animated:YES];
    }else if (type ==3){  //异常上报
        AbnormalViewController * abnormalVc = [[AbnormalViewController alloc]init];
        abnormalVc.viewType = 1;
        abnormalVc.mainOrderID = self.model.mainid;
        abnormalVc.subOrderID = self.model.gid;
        [self.navigationController pushViewController:abnormalVc animated:YES];
    }else if(type ==4){//切换路线
        NSArray * allKey = [self.driveManager.naviRoutes allKeys];
        if (self.wayID ==  allKey.count-1) {
            self.wayID = 0;
        }else{
            self.wayID += 1;
        }
        [self selectNaviRouteWithID:self.wayID];
    }
}

#pragma mark - AlertView代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==1) {
        double elng = [self.model.elng doubleValue];
        double elat = [self.model.elat doubleValue];
        double value = [self distanceBetweenOrderBy:self.startPoint.latitude :elat :self.startPoint.longitude :elng];
//        if (value/1000 >1.00){
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请在收货地1公里以内确认到货" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
//        }else{
            if (alertView.tag ==1) {
                [self upData:1];
            }else{
                [self upData:2];
            }
//        }
    }
}
/** 计算两个经纬度之间的直线距离 */
-(double)distanceBetweenOrderBy:(double) lat1 :(double) lat2 :(double) lng1 :(double) lng2{
    CLLocation *curLocation = [[CLLocation alloc] initWithLatitude:lat1 longitude:lng1];
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:lat2 longitude:lng2];
    double  distance  = [curLocation distanceFromLocation:otherLocation];
    return  distance;
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.orderInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(265);
    }];
    CGFloat top = iPhoneX?84:64;
    [weakself.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(10+top);
        make.bottom.equalTo(weakself.orderInfo.mas_top);
    }];
}
#pragma mark - 懒加载
- (MapOrderInfoView *)orderInfo{
    if (!_orderInfo) {
        _orderInfo = [[MapOrderInfoView alloc]init];
        _orderInfo.backgroundColor = White_Color;
        _orderInfo.delegate = self;
        _orderInfo.model = self.model;
        [self.view addSubview:_orderInfo];
    }
    return _orderInfo;
}
- (MAMapView *)mapView{
    if(!_mapView){
        _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 70, self.view.bounds.size.width, self.view.bounds.size.height-70)];
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;
        _mapView.showsCompass = NO;
        _mapView.showsScale = NO;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
    }
    return _mapView;
}
@end
