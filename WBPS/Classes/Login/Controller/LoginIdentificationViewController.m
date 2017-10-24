
//
//  LoginIdentificationViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/26.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "LoginIdentificationViewController.h"
/** 弹窗Cell */
#import "CenterBallTableCell.h"
/** 输入框Cell */
#import "CenterTextFieldTableCell.h"
/** 弹窗视图 */
#import "CenterBallView.h"
/** 上传图片控制器 */
#import "LoginUpPhotoViewController.h"
/** 车辆类型model */
#import "CarTypeModel.h"

@interface LoginIdentificationViewController ()
<UITableViewDelegate,
UITableViewDataSource,
CenterBallViewDelegate,
CenterTextFieldTableCellDelegate,
CenterBallViewDelegate>

@property (nonatomic,strong)UITableView * tableView;
/** 弹出视图 */
@property (nonatomic,strong) CenterBallView * ballView;
/** 右上角Item */
@property (nonatomic,strong)UIButton * nextButton;
/** 用户输入信息 */
@property (nonatomic,strong)NSMutableDictionary * userInputDic;
/** 选中城市信息数组 */
@property (nonatomic,strong)NSMutableArray * cityArray;
/** 选中车辆信息数组 */
@property (nonatomic,strong)NSMutableArray * carInfoArray;
/** 车辆列表 */
@property (nonatomic,strong)NSMutableArray * carTypeArray;

/** 认证选择之后信息 */
@property (nonatomic,strong)NSMutableDictionary * attestationInfoDic;
/** 车辆类型ID */
@property (nonatomic,copy)NSString * carTypeID;
/** 用户修改之前的车辆信息 */
@property (nonatomic,strong)CarTypeModel * carModel;
/** 用户修改之前的信息储存数组 */
@property (nonatomic,strong)NSMutableArray * attestationInfoArray;

@end

static NSString *const ballCellID = @"BallCellID";
static NSString *const textFieldCellID = @"textfFieldCellID";
@implementation LoginIdentificationViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightItem)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.viewType ==1) {
        self.title = @"认证";
    }else if(self.viewType ==2){
        self.title = @"重新认证";
    }
    [self.tableView registerClass:[CenterBallTableCell class] forCellReuseIdentifier:ballCellID];
    [self.tableView registerClass:[CenterTextFieldTableCell class] forCellReuseIdentifier:textFieldCellID];
}
#pragma mark - 获取到车辆的类型
/** 获取车辆类型 */
- (void)getCarType{
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Query" proc:@"QSP_GET_VEHICLETYPE" pars:mutDic];
    self.carTypeArray = @[].mutableCopy;
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [self.carTypeArray addObjectsFromArray:[CarTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"msg"]]];
        self.ballView.carTypeArray = self.carTypeArray;
        [self setUserComeInData];
    } error:^(id error) {
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 点击方法
/** 点击下一步 */
- (void)clickRightItem{
    
    if (self.viewType ==2) {
        for (int i=0; i<self.attestationInfoArray.count; i++) {
            NSString * str = self.attestationInfoArray[i];
            if (i==1) {
                if ([str isEqualToString:@"同城运输"]) {
                    [self.attestationInfoDic setObject:@"1" forKey:@(i+1)];
                }else{
                    [self.attestationInfoDic setObject:self.cityArray[i] forKey:@(i+1)];
                }
            }else{
                [self.attestationInfoDic setObject:str forKey:@(i+1)];
            }
        }
    }else{
        for (int i=0; i<3; i++) {
            if (i==1) {
                NSString * transportation = self.cityArray[i];
                if ([transportation isEqualToString:@"同城运输"]) {
                    [self.attestationInfoDic setObject:@"1" forKey:@(i+1)];
                }
            }else{
                [self.attestationInfoDic setObject:self.cityArray[i] forKey:@(i+1)];
            }
        }
        [self.attestationInfoDic setObject:self.userInputDic[@"CarBrand"] forKey:@(4)];
        [self.attestationInfoDic setObject:self.userInputDic[@"CarCode"] forKey:@(5)];
        [self.attestationInfoDic setObject:self.userInputDic[@"UserName"] forKey:@(6)];
        [self.attestationInfoDic setObject:self.userInputDic[@"company"] forKey:@(7)];
        for (int i=0; i<3; i++) {
            [self.attestationInfoDic setObject:self.carInfoArray[i] forKey:@(i+8)];
        }
    }
    NSArray * allValue = [self.attestationInfoDic allValues];
    for (NSString *str in  allValue) {
        if ([str isEqualToString:@""] || [str isEqualToString:@"未设定"]) {
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入完整的用户信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
    }
    LoginUpPhotoViewController * loginUpPhotoVc = [[LoginUpPhotoViewController alloc]init];
    loginUpPhotoVc.viewType = self.viewType;
    loginUpPhotoVc.carTypeID = self.carTypeID;
    loginUpPhotoVc.attestationInfoDic = self.attestationInfoDic;
    [self.navigationController pushViewController:loginUpPhotoVc animated:YES];
    
}

- (void)setViewType:(NSInteger)viewType{
    _viewType = viewType;
    [self getCarType];
    [self setUserComeInData];
}
/** 设置从个人中心页面进入时的数据 */
- (void)setUserComeInData{
    self.attestationInfoArray = [NSMutableArray array];
        /** 车辆品牌 */
        NSString * vehiclebrand = [UserModel sharedUserInfo].vehiclebrand;
        /** 车牌号 */
        NSString * vehicleno = [UserModel sharedUserInfo].vehicleno;
        /** 用户名字 */
        NSString * username = [UserModel sharedUserInfo].username;
        /** 公司ID */
        NSString * companyID = [UserModel sharedUserInfo].companyid;
    /** 设置车型ID */
        self.carTypeID = [UserModel sharedUserInfo].vehicletypeid;

    
        for (int i=0; i<self.carTypeArray.count; i++) {
            CarTypeModel * model = self.carTypeArray[i];
            if ([[UserModel sharedUserInfo].vehicletypeid isEqualToString:model.id]) {
                self.carModel = model;
            }
        }
        NSString * carName = self.carModel.vehiclemodel;
        NSString * carVolumn = self.carModel.volumn;
        NSString * carWeight = self.carModel.weight;
        if (carName ==nil || [carName isEqualToString:@""]) {
            carName = @"未设置";
        }
        if (carVolumn ==nil || [carVolumn isEqualToString:@""]) {
            carVolumn = @"未设置";
        }
        if (carWeight ==nil || [carWeight isEqualToString:@""]) {
            carWeight = @"未设置";
        }
        NSString * ysType = @"";
        if ([[UserModel sharedUserInfo].ystype isEqualToString:@"1"]) {
            ysType = @"同城运输";
        }else{
            ysType = @"长途运输";
        }
        self.attestationInfoArray = [NSMutableArray arrayWithObjects:@"全市通",ysType,@"广州市",vehiclebrand,vehicleno,username,companyID,carName,carVolumn,carWeight, nil];
        [self.tableView registerClass:[CenterBallTableCell class] forCellReuseIdentifier:ballCellID];
        [self.tableView registerClass:[CenterTextFieldTableCell class] forCellReuseIdentifier:textFieldCellID];
        [self.tableView reloadData];
}
#pragma mark - 代理方法
/**
 点击弹出视图调用方法

 @param index 选择的类型
 @param selectString   返回字符串
 */
- (void)clickSelectType:(NSInteger)index selectObj:(NSString *)selectString{

    if (index<4) {
        if (self.viewType ==2) {
            [self.attestationInfoArray replaceObjectAtIndex:index-1 withObject:selectString];
        }else{
            [self.cityArray replaceObjectAtIndex:index-1 withObject:selectString];
        }
        [self.tableView reloadData];
    }else{
        if (self.viewType == 1) {
            for (int i=0; i<self.carTypeArray.count; i++) {
                CarTypeModel * model = self.carTypeArray[i];
                if ([selectString isEqualToString:model.id]) {
                    NSArray * contentAry = @[model.vehiclemodel,model.volumn,model.weight];
                    self.carTypeID = selectString;
                    for (int i=0; i<3; i++) {
                        [self.carInfoArray replaceObjectAtIndex:i withObject:contentAry[i]];
                    }
                    [self.tableView reloadData];
                }
            }
        }else{
            for (int i=0; i<self.carTypeArray.count; i++) {
                CarTypeModel * model = self.carTypeArray[i];
                if ([selectString isEqualToString:model.id]) {
                    NSArray * contentAry = @[model.vehiclemodel,model.volumn,model.weight];
                    self.carTypeID = selectString;
                    for (int i=0; i<3; i++) {
                        [self.attestationInfoArray replaceObjectAtIndex:i+7 withObject:contentAry[i]];
                    }
                    [self.tableView reloadData];
                }
            }
        }
        
        
        
    }
}
/**
 Cell上输入框改变调用方法

 @param indexPath 当前修改的下标
 @param text 修改的内容
 */
- (void)textFieldValueChange:(NSIndexPath *)indexPath textChange:(NSString *)text{
    
    if (self.viewType ==1) {
        [self.userInputDic setObject:text forKey:@[@"CarBrand",@"CarCode",@"UserName",@"company"][indexPath.row-3]];
    }else{
        [self.attestationInfoArray replaceObjectAtIndex:indexPath.row withObject:text];
    }
}

#pragma mark - tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 7;
    }else{
        return 3;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCRYFrom6(45);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    view.backgroundColor = COLOR(243, 244, 245, 1);
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        if (indexPath.row<3) {
            CenterBallTableCell * cell = [tableView dequeueReusableCellWithIdentifier:ballCellID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (self.viewType ==2) {
                cell.titleLabel.text = self.attestationInfoArray[indexPath.row];
            }else{
                cell.titleLabel.text = self.cityArray[indexPath.row];
            }
            cell.contentLabel.hidden = YES;
            return cell;
        }else{
            CenterTextFieldTableCell * cell = [tableView dequeueReusableCellWithIdentifier:textFieldCellID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.titleLabel.text = @[@"车辆品牌",@"车牌号码",@"姓名",@"企业ID"][indexPath.row-3];
            if (self.viewType ==2) {
                cell.textField.text = self.attestationInfoArray[indexPath.row];
            }else{
                cell.textField.placeholder = @"请输入";
            }
            cell.cellIndexPath = indexPath;
            cell.delegate = self;
            return cell;
        }
    }else{
        CenterBallTableCell * cell = [tableView dequeueReusableCellWithIdentifier:ballCellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.text = @[@"车辆类型",@"容积",@"载重"][indexPath.row];
        if (self.viewType ==2) {
            cell.contentLabel.text = self.attestationInfoArray[indexPath.row+7];
        }else{
            cell.contentLabel.text = self.carInfoArray[indexPath.row];
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        if (indexPath.row ==0 || indexPath.row==1 || indexPath.row==2) {
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            self.ballView.type = indexPath.row + 1;
            [appDelegate.window addSubview:self.ballView];
        }
    }else{
        if (indexPath.row ==0) {
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            self.ballView.type = 4;
            [appDelegate.window addSubview:self.ballView];
        }
    }
}
#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-(TopHeight)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
        _tableView.backgroundColor = self.view.backgroundColor;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (CenterBallView *)ballView{
    if (!_ballView) {
        _ballView = [[CenterBallView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _ballView.delegate = self;
    }
    return _ballView;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:Black_Color forState:UIControlStateNormal];
        _nextButton.frame = CGRectMake(0, 0, 50, 30);
        [_nextButton addTarget:self action:@selector(clickRightItem) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}
- (NSMutableDictionary *)userInputDic{
    if (!_userInputDic) {
        _userInputDic = [NSMutableDictionary dictionary];
        for (int i=0; i<4 ; i++) {
            [_userInputDic setObject:@"" forKey:@[@"CarBrand",@"CarCode",@"UserName",@"company"][i]];
        }
    }
    return _userInputDic;
}
- (NSMutableArray *)cityArray{
    if (!_cityArray) {
        _cityArray = [NSMutableArray arrayWithObjects:@"全市通",@"同城运输",@"广州市", nil];
    }
    return _cityArray;
}
- (NSMutableArray *)carInfoArray{
    if (!_carInfoArray) {
        _carInfoArray = [NSMutableArray arrayWithObjects:@"未设定",@"未设定",@"未设定", nil];
    }
    return _carInfoArray;
}

- (NSMutableDictionary *)attestationInfoDic{
    if (!_attestationInfoDic) {
        _attestationInfoDic = [NSMutableDictionary dictionary];
        for (int i=1; i<11; i++) {
            [_attestationInfoDic setObject:@"" forKey:@(i)];
        }
    }
    return _attestationInfoDic;
}

@end
