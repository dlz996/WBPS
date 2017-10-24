//
//  SignOrderViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/28.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "SignOrderViewController.h"

/** 添加银行卡cell */
#import "AddBankCardTableCell.h"
/** 图片选择CollectionCell */
#import "SignOrderCollectionCell.h"
/** 订单详情列表页 */
#import "OrderInfoViewController.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import <AVFoundation/AVFoundation.h>

@interface SignOrderViewController ()
<UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
TZImagePickerControllerDelegate,
SignOrderRemoImageDelegate,
AddBankCardTableCellDelegate>

/** tableView */
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UICollectionView * collectionView;
/** 选择图片数组 */
@property (nonatomic,strong)NSMutableArray * selectImageArray;
/** 添加提醒 */
@property (nonatomic,strong)UILabel * addHint;
/** 上传数据按钮 */
@property (nonatomic,strong)UIButton * upDataButton;
/** 签收人信息 */
@property (nonatomic,strong)NSMutableDictionary * userInfoDic;
/** 用户当前的位置 */
@property (nonatomic) CLLocationCoordinate2D centerCoordinate;

@end
static NSString *const CellID = @"CellID";
static NSString *const CollectionCellID = @"CollectionCellID";
@implementation SignOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"上传照片"];
    [self.tableView registerClass:[AddBankCardTableCell class] forCellReuseIdentifier:CellID];
    [self.collectionView registerClass:[SignOrderCollectionCell class] forCellWithReuseIdentifier:CollectionCellID];
    [self setSubViewAutoLayout];
    [self getUserLocation];
}
- (void)getUserLocation{
    [[LWLocationManager sharedManager]getLocationSuccess:^(CLLocationCoordinate2D coordinate) {
        self.centerCoordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
    } Regeocode:^(AMapLocationReGeocode *regeocode) {
        
    } error:^(id error) {
        
    }];
}
#pragma mark - 数据处理
- (void)setModel:(TaskInfoModel *)model{
    _model = model;
}
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate{
    _centerCoordinate = centerCoordinate;
}
- (void)clickUpDataButton{
    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].userid
               forKey:@"userid"];
    [mutDic setObject:self.model.mainid forKey:@"orderid"];
    [mutDic setObject:self.model.gid forKey:@"orderinfoid"];
    [mutDic setObject:@(self.centerCoordinate.latitude) forKey:@"lat"];
    [mutDic setObject:@(self.centerCoordinate.longitude) forKey:@"lng"];
    [mutDic setObject:self.userInfoDic[@"username"] forKey:@"qsman"];
    [mutDic setObject:self.userInfoDic[@"userNO"] forKey:@"qsmancode"];
    
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"UploadImage" proc:@"USP_UPDATE_ORDERSIGN_APP" pars:mutDic userPhone:[UserModel sharedUserInfo].usermb];
    [MBProgressHUD showActivityIndicator];
    [NetWorkingManager POSTWithImageArray:self.selectImageArray upDic:upData fileName:@"" success:^(id responseObject) {
        [MBProgressHUD showSuccess:@"签收成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (UIViewController * vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[OrderInfoViewController class]]){
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        });
    } error:^(id error) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - Cell代理方法
- (void)textFieldValueChange:(NSIndexPath *)indexPath textChange:(NSString *)text{
    
    [self.userInfoDic setObject:text forKey:@[@"username",@"userNO"][indexPath.row]];
    NSLog(@"dayin wode shuju ---->>>%@",self.userInfoDic);
    NSArray * values = [self.userInfoDic allValues];
    for (int i=0; i<2; i++) {
        NSString * value = values[i];
        if ([value isEqualToString:@""]) {
            self.upDataButton.backgroundColor = COLOR(163, 164, 164, 1);
            self.upDataButton.userInteractionEnabled = NO;
            return;
        }
    }
    self.upDataButton.backgroundColor = COLOR(41, 117, 227, 1);
    self.upDataButton.userInteractionEnabled = YES;
}
#pragma mark - 操作表代理方法
/** 点击操作表调用方法 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==1) {
        NSInteger selectNumber = 5-self.selectImageArray.count;
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:selectNumber delegate:self];
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto){
             [self.selectImageArray addObjectsFromArray:photos];
             [self.collectionView reloadData];
         }];
        // 设置是否可以选择视频/原图
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowPickingOriginalPhoto = NO;
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else if (buttonIndex ==0){
        UIImagePickerController *CameraPicker = [[UIImagePickerController alloc] init];
        CameraPicker.delegate = self;
        CameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:CameraPicker animated:YES completion:nil];
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请在iPhone的“设置-隐私”选项中，允许微步配送访问你的摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
    }
}
#pragma mark - 删除图片代理方法
- (void)remoImageOf:(NSIndexPath *)indexPath{
    [self.selectImageArray removeObjectAtIndex:indexPath.row];
    [self.collectionView reloadData];
}

#pragma mark - 图片处理代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (!image) {
        return;
    }
    [self.selectImageArray addObject:image];
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
#pragma mark - collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.selectImageArray.count<5){
        return self.selectImageArray.count+1;
    }else{
        return self.selectImageArray.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == self.selectImageArray.count && self.selectImageArray.count<5){
        SignOrderCollectionCell * Cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellID forIndexPath:indexPath];
        Cell.selectImage.image = UIImageName(@"addImage");
        Cell.remoButton.hidden = YES;
        Cell.delegate = self;
        return Cell;
    }
    if (self.selectImageArray.count<=5){
        SignOrderCollectionCell * Cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellID forIndexPath:indexPath];
        [Cell.selectImage setImage:self.selectImageArray[indexPath.item]];
        Cell.remoButton.hidden = NO;
        Cell.indexPath = indexPath;
        Cell.delegate = self;
        return Cell;
    }
    return nil;
}
/**  点击CollectionItem调用的方法*/
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item >=5 || self.selectImageArray.count>=5){
        return;
    }else if (indexPath.item == self.selectImageArray.count){
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
        [sheet showInView:self.view];
    }
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    view.backgroundColor = self.view.backgroundColor;
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddBankCardTableCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.indexPath = indexPath;
    cell.titleLabel.text = @[@"签收人姓名",@"身份证号"][indexPath.row];
    cell.textField.placeholder = @[@"请输入签收人姓名",@"请输入签收人身份证号"][indexPath.row];
    cell.delegate = self;
    return cell;
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    [weakself.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        if (iPhoneX) {
            make.top.offset(88);
        }else{
            make.top.offset(64);
        }
        make.height.offset(115);
    }];
    
    [weakself.addHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.top.equalTo(weakself.tableView.mas_bottom).offset(17.5);
        make.height.offset(15);
    }];
    
    [weakself.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(weakself.addHint.mas_bottom).offset(2);
        make.bottom.equalTo(weakself.upDataButton.mas_top);
    }];
    
    
    [weakself.upDataButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.bottom.right.offset(-10);
        make.height.offset(SCRYFrom6(45));
    }];
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView
{
    if (!_collectionView){
        CGFloat itemsize = (SCREEN_WIDTH-30)/3;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(itemsize, itemsize);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        UIView * bgView = [[UIView alloc]init];
        bgView.backgroundColor = self.view.backgroundColor;
        _collectionView.backgroundView = bgView;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = White_Color;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (UIButton *)upDataButton{
    if (!_upDataButton) {
        _upDataButton = [UIButton buttonWithTitle:@"确认上传" atTitleSize:16 atTitleColor:White_Color atTarget:self atAction:@selector(clickUpDataButton)];
        _upDataButton.backgroundColor = COLOR(163, 164, 164, 1);
        _upDataButton.layer.cornerRadius = 10;
        _upDataButton.layer.masksToBounds = YES;
        _upDataButton.userInteractionEnabled = NO;
        [self.view addSubview:_upDataButton];
    }
    return _upDataButton;
}
- (NSMutableArray *)selectImageArray{
    if (!_selectImageArray) {
        _selectImageArray = [NSMutableArray array];
    }
    return _selectImageArray;
}
- (UILabel *)addHint{
    if (!_addHint) {
        _addHint = [UILabel labelWithText:@"添加图片" atColor:COLOR(163,164,165,1) atTextSize:14 atTextFontForType:@""];
        [self.view addSubview:_addHint];
    }
    return _addHint;
}
- (NSMutableDictionary *)userInfoDic{
    if (!_userInfoDic){
        _userInfoDic = [NSMutableDictionary dictionary];
        [_userInfoDic setObject:@"" forKey:@"username"];
        [_userInfoDic setObject:@"" forKey:@"userNO"];
    }
    return _userInfoDic;
}

@end
