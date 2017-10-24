//
//  LoginUpPhotoViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/26.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "LoginUpPhotoViewController.h"
/** Cell */
#import "LoginUpPhotoTableCell.h"
/** 弹出视图 */
#import "LoginPopupHintView.h"
/** 主控制器 */
#import "HomeViewController.h"
/** 用户中心 */
#import "UserCenterViewController.h"
/** 用户图片信息model */
#import "CertificateImageModel.h"
@interface LoginUpPhotoViewController ()
<UITableViewDelegate,
UITableViewDataSource,
LoginUpPhotoCellDelegate,
LoginPoPupHintViewDelegate,
TZImagePickerControllerDelegate,
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@property (nonatomic,strong)UITableView * tableView;
/** cell的下标 */
@property (nonatomic,strong)NSIndexPath * cellIndexPath;
/** 弹出视图 */
@property (nonatomic,strong)LoginPopupHintView * popupView;
/** 用户输入的个人信息 */
@property (nonatomic,strong)NSMutableDictionary * userInfoMutDic;
/** 用户选择的证件图片 */
@property (nonatomic,strong)NSMutableArray <UIImage *>* imageMutAry;
/** tableView脚视图 */
@property (nonatomic,strong)UIView * footerView;
/** 确认图片是否重选 */
@property (nonatomic,strong)NSMutableDictionary * imageSelectDic;

/** 从服务器拿到图片的信息 */
@property (nonatomic,strong)NSMutableArray <CertificateImageModel *>* imageModelArray;
/** 图片链接 */
@property (nonatomic,strong)NSMutableArray * loadImageUrlArray;

@end

static NSString *const upPhotoCellID = @"upPhotoCellID";
@implementation LoginUpPhotoViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:UIImageName(@"back") style:UIBarButtonItemStyleDone target:self action:@selector(back)];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"认证";
   
    [self setImageArrayOfViewType];
    [self.tableView registerClass:[LoginUpPhotoTableCell class] forCellReuseIdentifier:upPhotoCellID];
}
#pragma mark - 获取图片
- (void)getImage{
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].imagepid forKey:@"pid"];
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData =  [NetWorkingManager combinationObj:@"Query" proc:@"QSP_GET_IMAGEPATH_BYPID_APP" pars:mutDic];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [self.imageModelArray addObjectsFromArray:[CertificateImageModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"msg"]]];
        [self getImageUrl];
    } error:^(id error) {
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 设置图片
- (void)setImageArrayOfViewType{
    self.imageMutAry = [NSMutableArray array];
    for (int i=0; i<4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@[@"photo_id",@"photo_driving_license",@"photo_car_license",@"photo_opration_license"][i]]];
        [self.imageMutAry addObject:image];
    }
    [self.tableView reloadData];
    if (self.viewType == 2) {
        [self getImage];
    }
}
#pragma mark - 整理图片链接
- (void)getImageUrl{
    NSArray * ary = @[@"身份证",@"驾驶证",@"行驶证",@"营运证"];
    for (int i=0; i<ary.count;i++) {
        NSString * imagetype = ary[i];
        for (CertificateImageModel * model in  self.imageModelArray) {
            if ([model.imagetype isEqualToString:imagetype]) {
                [self.loadImageUrlArray addObject:model.imagepath];
                
                NSURL * shareImageUrl = [NSURL URLWithString:[kImageBaseUrl stringByAppendingString:model.imagepath]];
                [[SDWebImageManager sharedManager]loadImageWithURL:shareImageUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                    
                } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                    if (error) {
                        [self.imageSelectDic setObject:@"2" forKey:@[@"userImage",@"driveImage",@"travelImage",@"operationImage"][i]];
                        [self.imageMutAry replaceObjectAtIndex:i withObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@",@[@"photo_id",@"photo_driving_license",@"photo_car_license",@"photo_opration_license"][i]]]];
                    }else{
                        [self.imageSelectDic setObject:@"2" forKey:@[@"userImage",@"driveImage",@"travelImage",@"operationImage"][i]];
                        [self.imageMutAry replaceObjectAtIndex:i withObject:image];
//                        [self.imageMutAry addObject:image];
                    }
                    [self.tableView reloadData];
                }];
            }
        }
    }
    
}

#pragma mark - 数据处理
/** 上传数据 */
- (void)upImageToServer{
    NSArray * imageSelectValues = [self.imageSelectDic allValues];
    for (int i=0; i<imageSelectValues.count; i++) {
        NSString * String = imageSelectValues[i];
        if ([String isEqualToString:@"1"]) {
            [MBProgressHUD showError:@"请选择图片"];
            return;
        }
    }
    NSArray * userinfoArray =  [self.userInfoMutDic allValues];
    for (int i=0; i<userinfoArray.count; i++) {
        NSString * String = userinfoArray[i];
        if ([String isEqualToString:@""]) {
            [MBProgressHUD showError:@"请输入信息"];
            return;
        }
    }
    
    NSArray * typeFileArray = @[@"2",@"3",@"4",@"5"];
    for (int i=0; i<4; i++) {
        [self upImageToServer:typeFileArray[i] image:self.imageMutAry[i]];
    }
    [self upUserInfoToServer];
}
/** 上传图片到服务器 */
- (void)upImageToServer:(NSString *)imageType image:(UIImage *)image{
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    [mutDic setObject:imageType forKey:@"imagetypeid"];
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [self combinationObj:@"UploadImage" proc:@"USP_ADD_VEHICLEIMAGE_APP" pars:mutDic userPhone:[UserModel sharedUserInfo].usermb];
    NSArray * ary = [NSArray arrayWithObjects:image, nil];

    [NetWorkingManager POSTWithImageArray:ary upDic:upData fileName:@"" success:^(id responseObject){
    } error:^(id error) {
    } failure:^(NSError *error) {
    }];
}
/** 上传用户信息到服务器 */
- (void)upUserInfoToServer{
  
    NSMutableDictionary * userDic = @{}.mutableCopy;
    [userDic setObject:[UserModel sharedUserInfo].gid forKey:@"userid"];
    [userDic setObject:self.userInfoMutDic[@"userID"] forKey:@"idcode"];
    [userDic setObject:self.userInfoMutDic[@"driveID"] forKey:@"jszcode"];
    [userDic setObject:@"1990-01-01" forKey:@"jszenddate"];
    [userDic setObject:self.carTypeID forKey:@"vehicletypeid"];
    [userDic setObject:self.attestationInfoDic[@(5)] forKey:@"vehicleno"];
    [userDic setObject:self.attestationInfoDic[@(4)] forKey:@"vehiclebrand"];
    [userDic setObject:self.attestationInfoDic[@(10)] forKey:@"weight"];
    [userDic setObject:self.attestationInfoDic[@(9)] forKey:@"volumn"];
    [userDic setObject:self.userInfoMutDic[@"travelID"] forKey:@"xszcode"];
    [userDic setObject:self.userInfoMutDic[@"operationID"] forKey:@"yycode"];
    [userDic setObject:self.attestationInfoDic[@(6)] forKey:@"username"];
    [userDic setObject:self.attestationInfoDic[@(7)] forKey:@"companyid"];
    
    NSString * ysType = @"";
    if ([self.attestationInfoDic[@(2)] isEqualToString:@"同城运输"]) {
        ysType = @"1";
    }else{
        ysType = @"2";
    }
    [userDic setObject:ysType forKey:@"ystype"];
    
    
    // 车辆识别证号  传空
    [userDic setObject:@"" forKey:@"clsbzcode"];
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Modify" proc:@"USP_ADD_CHAUFFERINFO_APP" pars:userDic];
    [MBProgressHUD showActivityIndicator];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        if (self.viewType ==1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSString * userID = [UserModel sharedUserInfo].userid;
                NSString *strUrl = [userID stringByReplacingOccurrencesOfString:@"-" withString:@""];
                [JPUSHService setTags:nil alias:strUrl fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                    //            NSLog(@"设置别名");
                }];
                AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                HomeViewController * homeVc = [[HomeViewController alloc]init];
                appdelegate.window.rootViewController = [[BasicNavigationVontroller alloc]initWithRootViewController:homeVc];
            });
        }else{
            for (UIViewController * vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[UserCenterViewController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }
    } error:^(id error) {
    } failure:^(NSError *error) {
    }];
}

- (void)setCarTypeID:(NSString *)carTypeID{
    _carTypeID = carTypeID;
}
- (void)setAttestationInfoDic:(NSMutableDictionary *)attestationInfoDic{
    _attestationInfoDic = attestationInfoDic;
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setViewType:(NSInteger)viewType{
    _viewType = viewType;
    if (self.viewType == 2) {
        [self.userInfoMutDic setObject:[UserModel sharedUserInfo].idcode forKey:@"userID"];
        [self.userInfoMutDic setObject:[UserModel sharedUserInfo].jszcode forKey:@"driveID"];
        [self.userInfoMutDic setObject:[UserModel sharedUserInfo].xszcode forKey:@"travelID"];
        [self.userInfoMutDic setObject:[UserModel sharedUserInfo].yycode forKey:@"operationID"];
    }
}

#pragma mark - 图片选择处理方法
- (void)imageEdit:(UIImage *)image{

    //使用一个字典记录图片是否改变，省去比对图片的区别
   [self.imageSelectDic setObject:@"2" forKey:@[@"userImage",@"driveImage",@"travelImage",@"operationImage"][self.cellIndexPath.row]];
    
    [self.imageMutAry replaceObjectAtIndex:self.cellIndexPath.row withObject:image];
    NSArray * loadAry = @[self.cellIndexPath];
    [self.tableView reloadRowsAtIndexPaths:loadAry withRowAnimation:UITableViewRowAnimationNone];
}

#pragma makr - 自定义代理方法
/**
 点击标题图片调用方法
 
 @param indexPath   点击Cell的下标
 */
- (void)clickCellTitleImage:(NSIndexPath *)indexPath{
    self.cellIndexPath = indexPath;
    self.popupView.type = indexPath.row;
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.window addSubview:self.popupView];
}

/**
 输入框内值改变后调用的方法
 
 @param indexPath 改变的TextField的下标
 */
- (void)textFieldValueChange:(NSIndexPath *)indexPath textChange:(NSString *)text{
    self.cellIndexPath = indexPath;
    [self.userInfoMutDic setObject:text forKey:@[@"userID",@"driveID",@"travelID",@"operationID"][indexPath.row]];
}
/**
     弹出框中确定选择图片
 */
- (void)confirmSelectPhoto{
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.popupView removeFromSuperview];
    if (buttonIndex ==0) {
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
    }else if (buttonIndex ==1){
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto){
            if (photos) {
                [self imageEdit:photos[0]];
            }
         }];
//        imagePickerVc.navigationBar.barTintColor = White_Color;
        // 设置是否可以选择视频/原图
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowPickingOriginalPhoto = NO;
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}
#pragma mark - 图片处理代理方法
/** 拍照成功后返回代理 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (!image) {
        return;
    }
    [self imageEdit:image];
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
/** 拍照或者选择照片取消代理 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.imageMutAry.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCRYFrom6(130);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    view.backgroundColor = COLOR(222, 222, 222, 1);
    UILabel * hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 200, 18)];
    hintLabel.text = @"请拍摄照片上传并提交";
    hintLabel.textColor = Black_Color;
    [view addSubview:hintLabel];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoginUpPhotoTableCell * cell = [tableView dequeueReusableCellWithIdentifier:upPhotoCellID];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.titleLabel.text = @[@"请填入身份证号码",@"请填入驾驶证号码",@"请填入行驶证号码",@"请填入运营证号码"][indexPath.row];
    if (self.viewType ==2) {
        NSArray * valueAry = @[@"userID",@"driveID",@"travelID",@"operationID"];
        cell.textField.text = [self.userInfoMutDic objectForKey:valueAry[indexPath.row]];
    }
    cell.titleImage.image = self.imageMutAry[indexPath.row];
    return cell;
}
/** 数据处理 */
- (NSMutableDictionary *)combinationObj:(NSString *)method proc:(NSString *)proc pars:(NSMutableDictionary *)pars userPhone:(NSString *)userPhone{
    NSArray * ary = [pars allKeys];
    NSString * objAry = @"{\"pars\":[{";
    for (int i=0; i<ary.count; i++) {
        NSString * keyStr = ary[i];
        NSString * key = [NSString stringWithFormat:@"%@%@%@%@",@"\"",keyStr,@"\"",@":"];
        NSString * valueStr = pars[keyStr];
        NSString * value =  [NSString stringWithFormat:@"%@%@%@%@",@"\"",valueStr,@"\"",@","];
        if (i==0) {
            objAry = [objAry stringByReplacingOccurrencesOfString:@"," withString:@""];
        }
        objAry = [NSString stringWithFormat:@"%@%@",objAry,key];
        objAry = [NSString stringWithFormat:@"%@%@",objAry,value];
    }
    objAry = [NSString stringWithFormat:@"%@%@",objAry,@"}],"];
    
    NSString * url = @"\"proc\":\"";
    NSString * urlValue = proc;
    objAry = [NSString stringWithFormat:@"%@%@%@%@",objAry,url,urlValue,@"\","];
    
    NSString * phone = @"\"usermb\":\"";
    objAry = [NSString stringWithFormat:@"%@%@%@%@",objAry,phone,userPhone,@"\","];
    
    NSString * type = @"\"method\":\"";
    NSString * typeValue = method;
    NSString * typeLast = @"\"}";
    objAry = [NSString stringWithFormat:@"%@%@%@%@",objAry,type,typeValue,typeLast];
    NSLog(@"打印拼接后的字符串--->>>%@",objAry);
    
    NSMutableDictionary * returnDic = @{}.mutableCopy;
    [returnDic setObject:objAry forKey:@"pars"];
    return returnDic;
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
        self.tableView.tableFooterView = self.footerView;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (LoginPopupHintView *)popupView{
    if (!_popupView) {
        _popupView = [[LoginPopupHintView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _popupView.delegate = self;
    }
    return _popupView;
}
- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        _footerView.backgroundColor = White_Color;
        UIButton * upDataButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [upDataButton setTitle:@"提交" forState:UIControlStateNormal];
        [upDataButton setTitleColor:White_Color forState:UIControlStateNormal];
        [upDataButton setBackgroundColor:COLOR(34, 114, 230, 1)];
        upDataButton.layer.cornerRadius = 5;
        upDataButton.layer.masksToBounds = YES;
        [upDataButton addTarget:self action:@selector(upImageToServer) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:upDataButton];
        [upDataButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(20);
            make.bottom.offset(-20);
            make.left.offset(SCRXFrom6(20));
            make.right.offset(SCRXFrom6(-20));
        }];
    }
    return _footerView;
}

- (NSMutableDictionary *)userInfoMutDic{
    if (!_userInfoMutDic) {
        _userInfoMutDic = [NSMutableDictionary dictionary];
        for (int i=0; i<4; i++) {
            [_userInfoMutDic setObject:@"" forKey:@[@"userID",@"driveID",@"travelID",@"operationID"][i]];
        }
    }
    return _userInfoMutDic;
}
- (NSMutableDictionary *)imageSelectDic{
    if (!_imageSelectDic) {
        _imageSelectDic = [NSMutableDictionary dictionary];
        for (int i=0; i<4; i++) {
            [_imageSelectDic setObject:@"1" forKey:@[@"userImage",@"driveImage",@"travelImage",@"operationImage"][i]];
        }
    }
    return _imageSelectDic;
}
- (NSMutableArray *)imageModelArray{
    if (!_imageModelArray) {
        _imageModelArray = [NSMutableArray array];
    }
    return _imageModelArray;
}
- (NSMutableArray *)loadImageUrlArray{
    if (!_loadImageUrlArray) {
        _loadImageUrlArray = [NSMutableArray array];
    }
    return _loadImageUrlArray;
}
@end
