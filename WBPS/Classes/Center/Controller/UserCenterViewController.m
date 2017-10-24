//
//  UserCenterViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/21.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "UserCenterViewController.h"
#import "CenterHeaderView.h"
/** 弹窗Cell */
#import "CenterBallTableCell.h"
/** 输入框Cell */
#import "CenterTextFieldTableCell.h"
/** 弹窗视图 */
#import "CenterBallView.h"
/** 认证按钮 */
#import "LoginIdentificationViewController.h"
/** 车辆类型模型 */
#import "CarTypeModel.h"
@interface UserCenterViewController ()
<UITableViewDelegate,
UITableViewDataSource,
CenterBallViewDelegate,
CenterHeaderDelegate,
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
TZImagePickerControllerDelegate>

/** 列表 */
@property (nonatomic,strong)UITableView * tableView;
/** 头视图 */
@property (nonatomic,strong)CenterHeaderView * headerView;
/** 弹出视图 */
@property (nonatomic,strong) CenterBallView * ballView;

/** 车辆列表 */
@property (nonatomic,strong)NSMutableArray * carTypeArray;
/** 用户信息存放数组 */
@property (nonatomic,strong)NSMutableArray * attestationInfoArray;
/** 当前车辆的数据模型 */
@property (nonatomic,strong)CarTypeModel * carModel;
/** 选中的头像的图片 */
@property (nonatomic,strong)UIImage * image;

@end
static NSString *const ballCellID = @"BallCellID";
static NSString *const textFieldCellID = @"textfFieldCellID";
@implementation UserCenterViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(clickSaveButton)];
    
    self.navigationItem.rightBarButtonItem = rightItem;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self disposalData];
    [self loadData];

    [self getCarType];
  
}
#pragma mark - 数据处理
/** 实时获取一下个人信息 */
- (void)loadData{
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    NSMutableDictionary * upData =@{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Query" proc:@"QSP_GET_FETCHORDER_COUNT_APP" pars:mutDic];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        NSDictionary * dic = responseObject[@"msg"][0];
        [UserModel setUserInfoModelWithDict:dic];
        [AccessTool saveUserInfo];
        [self.headerView setData];
        [self disposalData];
    } error:^(id error) {
    } failure:^(NSError *error) {
    }];
}
/** 获取车辆类型 */
- (void)getCarType{
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Query" proc:@"QSP_GET_VEHICLETYPE" pars:mutDic];
    self.carTypeArray = @[].mutableCopy;
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [self.carTypeArray addObjectsFromArray:[CarTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"msg"]]];
        self.ballView.carTypeArray = self.carTypeArray;
        [self disposalData];
    } error:^(id error) {
    } failure:^(NSError *error) {
    }];
}
/** 整理用户数据 */
- (void)disposalData{
    
    /** 车辆品牌 */
    NSString * vehiclebrand = [UserModel sharedUserInfo].vehiclebrand;
    /** 车牌号 */
    NSString * vehicleno = [UserModel sharedUserInfo].vehicleno;
    /** 用户名字 */
    NSString * username = [UserModel sharedUserInfo].username;
    /** 公司ID */
    NSString * companyID = [UserModel sharedUserInfo].companyid;

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
    self.attestationInfoArray = [NSMutableArray arrayWithObjects:@"全市通",@"同城运输",vehiclebrand,vehicleno,username,companyID,carName,carVolumn,carWeight, nil];
    [self.tableView registerClass:[CenterBallTableCell class] forCellReuseIdentifier:ballCellID];
    [self.tableView registerClass:[CenterTextFieldTableCell class] forCellReuseIdentifier:textFieldCellID];
    
    [self.tableView reloadData];
}
/** 上传用户头像 */
- (void)upUserTitleImage{

    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    [mutDic setObject:@"0" forKey:@"imagetypeid"];
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"UploadImage" proc:@"USP_ADD_VEHICLEIMAGE_APP" pars:mutDic userPhone:[UserModel sharedUserInfo].usermb];
    [MBProgressHUD showActivityIndicator];
    [NetWorkingManager POSTWithImageArray:@[self.image] upDic:upData fileName:@"" success:^(id responseObject) {
        [MBProgressHUD showSuccess:@"上传成功"];
        
        /** 发送通知，更换头像 */
        [[NSNotificationCenter defaultCenter]postNotificationName:LoadTitleImage object:nil userInfo:@{@"image":self.image}];
         
    } error:^(id error) {
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - 点击方法
/** 点击保存按钮调用方法 */
- (void)clickSaveButton{
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    [mutDic setObject:[UserModel sharedUserInfo].idcode forKey:@"idcode"];
    [mutDic setObject:[UserModel sharedUserInfo].jszcode forKey:@"jszcode"];
    [mutDic setObject:@"1990-01-01" forKey:@"jszenddate"];
    if (self.carModel.id == nil || self.carModel.id == NULL || [self.carModel.id isEqualToString:@""]) {
        self.carModel.id = @"0";
    }
    [mutDic setObject:self.carModel.id forKey:@"vehicletypeid"];
    [mutDic setObject:self.attestationInfoArray[2] forKey:@"vehiclebrand"];
    [mutDic setObject:self.attestationInfoArray[3] forKey:@"vehicleno"];
    [mutDic setObject:self.attestationInfoArray[8] forKey:@"weight"];
    [mutDic setObject:self.attestationInfoArray[7] forKey:@"volumn"];
    [mutDic setObject:[UserModel sharedUserInfo].yycode forKey:@"yycode"];
    [mutDic setObject:[UserModel sharedUserInfo].clsbzcode forKey:@"clsbzcode"];
    [mutDic setObject:[UserModel sharedUserInfo].username forKey:@"username"];
    [mutDic setObject:[UserModel sharedUserInfo].xszcode forKey:@"xszcode"];
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Modify" proc:@"USP_ADD_CHAUFFERINFO_APP" pars:mutDic];
    [MBProgressHUD showActivityIndicator];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [MBProgressHUD showSuccess:@"保存成功"];
    } error:^(id error) {
    } failure:^(NSError *error) {
    }];
}

#pragma mark - 子视图代理方法
/**
 点击弹出视图调用方法
 
 @param index 选择的类型
 @param selectString   返回字符串
 */
- (void)clickSelectType:(NSInteger)index selectObj:(NSString *)selectString{
    
    if (index ==4) {
        for (int i=0; i<self.carTypeArray.count; i++) {
            CarTypeModel * model = self.carTypeArray[i];
            if ([selectString isEqualToString:model.id]) {
                self.carModel = model;
                [self.attestationInfoArray replaceObjectAtIndex:6 withObject:self.carModel.vehiclemodel];
                [self.attestationInfoArray replaceObjectAtIndex:7 withObject:self.carModel.volumn];
                [self.attestationInfoArray replaceObjectAtIndex:8 withObject:self.carModel.weight];
                [self.tableView reloadData];
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
    [self.attestationInfoArray replaceObjectAtIndex:indexPath.row withObject:text];
}
/**
     点击认证按钮调用方法
 */
- (void)clickAgainButton{
    LoginIdentificationViewController *loginIdentificationVc = [[LoginIdentificationViewController alloc]init];
    loginIdentificationVc.viewType = 2;
    [self.navigationController pushViewController:loginIdentificationVc animated:YES];
}
/**
     点击头像选择按钮
 */
- (void)selectTitleImage{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机", nil];
    [sheet showInView:self.view];
}

#pragma mark - tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 6;
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
        if (indexPath.row<2) {
            CenterBallTableCell * cell = [tableView dequeueReusableCellWithIdentifier:ballCellID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.titleLabel.text = self.attestationInfoArray[indexPath.row];
            cell.contentLabel.hidden = YES;
            return cell;
        }else{
            CenterTextFieldTableCell * cell = [tableView dequeueReusableCellWithIdentifier:textFieldCellID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.titleLabel.text = @[@"车辆品牌",@"车辆号牌",@"姓名",@"企业ID"][indexPath.row-2];
            cell.textField.text = self.attestationInfoArray[indexPath.row];
            return cell;
        }
    }else{
            CenterBallTableCell * cell = [tableView dequeueReusableCellWithIdentifier:ballCellID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.titleLabel.text = @[@"车辆类型",@"容积",@"载重"][indexPath.row];
            cell.contentLabel.text = self.attestationInfoArray[indexPath.row+6];
            cell.contentLabel.hidden = NO;
            return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        if (indexPath.row ==0 || indexPath.row==1) {
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate.window addSubview:self.ballView];
        }
    }else{
        if (indexPath.row ==0) {
            if (self.carTypeArray.count <1) {
                return;
            }
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            self.ballView.type = 4;
            [appDelegate.window addSubview:self.ballView];
        }
    }
}
#pragma mark - 操作表代理方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            //相册
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto){
                 self.image = photos[0];
                 if (self.image) {
                     [self shearImage];
                 }
             }];
//            imagePickerVc.navigationBar.barTintColor = White_Color;
            // 设置是否可以选择视频/原图
            imagePickerVc.allowPickingVideo = NO;
            imagePickerVc.allowPickingOriginalPhoto = NO;
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
            break;
        case 1:{
            /** 调用系统相机 */
            UIImagePickerController *CameraPicker = [[UIImagePickerController alloc] init];
            CameraPicker.delegate = self;
            CameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:CameraPicker animated:YES completion:nil];
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if(authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
                //无权限
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请在iPhone的“设置-隐私”选项中，允许微步配送访问你的摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                return;
            }
        }
            break;
        case 2:
            return;
            break;
        default:
            break;
    }
}
#pragma mark - 图库代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:^{}];
    if (!image) {
        return;
    }
    self.image = image;
    [self shearImage];
}
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    [self dismissViewControllerAnimated:YES completion:^{}];
//}
/** 剪切图片 */
- (void)shearImage{
    LECropPictureViewController *cropPictureController = [[LECropPictureViewController alloc] initWithImage:self.image andCropPictureType:LECropPictureTypeRect];
    cropPictureController.cropFrame = CGRectMake(50, 50, 250, 250);
    cropPictureController.borderColor = [UIColor grayColor];
    cropPictureController.borderWidth = 1.0;
    cropPictureController.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cropPictureController.photoAcceptedBlock = ^(UIImage *croppedPicture){
        self.image = croppedPicture;
        self.headerView.userTitleImage.image = self.image;
        [self upUserTitleImage];
    };
    [self presentViewController:cropPictureController animated:NO completion:nil];
}
#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-(TopHeight)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.headerView;
        _tableView.bounces = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (CenterHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[CenterHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _headerView.delegate = self;
    }
    return _headerView;
}
- (CenterBallView *)ballView{
    if (!_ballView) {
        _ballView = [[CenterBallView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _ballView.delegate = self;
    }
    return _ballView;
}

@end
