//
//  AbnormalViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/13.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "AbnormalViewController.h"
/** 图片选择Cell */
#import "SignOrderCollectionCell.h"
/** 异常类型操作弹窗 */
#import "SetingPopupView.h"
/** 订单详情页 */
#import "OrderInfoViewController.h"
/** 主页面 */
#import "HomeViewController.h"
@interface AbnormalViewController ()
<UITextViewDelegate,
SetingPopupViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
TZImagePickerControllerDelegate,
SignOrderRemoImageDelegate>

/** 异常类型背景 */
@property (nonatomic,strong)UIView * typeBgView;
/** 异常标题 */
@property (nonatomic,strong)UILabel * typeTitle;
/** 异常类型输入框 */
@property (nonatomic,strong)UIButton * typeButton;

/** 异常详情视图 */
@property (nonatomic,strong)UIView * infoBgView;
/** 异常详情标题 */
@property (nonatomic,strong)UILabel * infoTitle;
/** 异常内容textView */
@property (nonatomic,strong)UITextView * infoTextView;

/** textView提示文本 */
@property (nonatomic,strong)UILabel * placeholderLabel;
/** 弹出视图 */
@property (nonatomic,strong)SetingPopupView * ballView;
/** 上传按钮 */
@property (nonatomic,strong)UIButton * upDataButton;
/** 请添加图片按钮 */
@property (nonatomic,strong)UILabel * addHint;
/** 图片展示数组 */
@property (nonatomic,strong)UICollectionView * collectionView;
/** 选择图片数组 */
@property (nonatomic,strong)NSMutableArray * selectImageArray;

@end

static NSString *const CollectionCellID = @"CollectionCellID";
@implementation AbnormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"异常";
    
    self.selectImageArray = [NSMutableArray array];
    [self.collectionView registerClass:[SignOrderCollectionCell class] forCellWithReuseIdentifier:CollectionCellID];

    [self setSubViewAutoLayout];
    
}
#pragma mark - 点击方法
/** 点击事故类型按钮 */
- (void)clickTypeButton{
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.ballView.type = 3;
    [appdelegate.window addSubview:self.ballView];
}
/** 点击上传信息按钮 */
- (void)clickUpDataButton{
    if (self.viewType ==2) {
        NSLog(@"事故");
        NSMutableDictionary * mutDic = @{}.mutableCopy;
        [mutDic setObject:self.mainOrderID forKey:@"orderid"];
        [mutDic setObject:self.infoTextView.text forKey:@"accidentcontent"];
        [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"sjid"];
        NSMutableDictionary * upData = @{}.mutableCopy;
        upData = [NetWorkingManager combinationObj:@"UploadImage" proc:@"USP_ADD_accident_APP" pars:mutDic userPhone:[UserModel sharedUserInfo].usermb];
        [MBProgressHUD showActivityIndicator];
        [NetWorkingManager POSTWithImageArray:self.selectImageArray upDic:upData fileName:@"" success:^(id responseObject) {
            [MBProgressHUD hideActivityIndicator];
            [MBProgressHUD showSuccess:@"上报成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                for (UIViewController * vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[HomeViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            });
        } error:^(id error) {
        } failure:^(NSError *error) {
        }];
    }else{
        NSMutableDictionary * mutDic = @{}.mutableCopy;
        [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"sjid"];
        [mutDic setObject:self.mainOrderID forKey:@"orderid"];
        [mutDic setObject:self.subOrderID forKey:@"orderinfoid"];
        [mutDic setObject:self.typeButton.titleLabel.text forKey:@"badtype"];
        [mutDic setObject:self.infoTextView.text forKey:@"badcontent"];
        NSMutableDictionary * upData =@{}.mutableCopy;
        upData = [NetWorkingManager combinationObj:@"UploadImage" proc:@"USP_ADD_BAD_APP" pars:mutDic userPhone:[UserModel sharedUserInfo].usermb];
        [MBProgressHUD showActivityIndicator];
        [NetWorkingManager POSTWithImageArray:self.selectImageArray upDic:upData fileName:@"" success:^(id responseObject) {
            [MBProgressHUD hideActivityIndicator];
            [MBProgressHUD showSuccess:@"上报成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                for (UIViewController * vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[OrderInfoViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            });
        } error:^(id error) {
        } failure:^(NSError *error) {
        }];
    }
}

#pragma mark - 子页面代理方法
/**
 点击弹窗页面调用方法
 
 @param index  弹窗的类型   1 接收范围  2 目的地区域
 @param selectString 返回的字符串
 */
- (void)clickSelectButton:(NSInteger)index selectObj:(NSString *)selectString{
    [self.typeButton setTitle:selectString forState:UIControlStateNormal];
    
}
#pragma mark - 删除图片代理方法
- (void)remoImageOf:(NSIndexPath *)indexPath{
    [self.selectImageArray removeObjectAtIndex:indexPath.row];
    [self.collectionView reloadData];
}
#pragma mark - textView代理方法
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0 ){
        _placeholderLabel.text = @"输入问题描述";
    }else{
        _placeholderLabel.text = @"";
    }
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

- (void)setViewType:(NSInteger)viewType{
    _viewType = viewType;
    if (_viewType ==1) {
        self.title = @"异常";
    }else{
        self.title = @"事故";
    }
}
#pragma mark - 约束
- (void)setSubViewAutoLayout{
    WS(weakself);
    
    CGFloat top = iPhoneX?94:74;
    
    if (self.viewType ==1) {
        [weakself.typeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.offset(top);
            make.height.offset(55);
        }];
        
        [weakself.typeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.typeBgView.mas_centerY);
            make.left.offset(10);
            make.width.offset(82);
        }];
        
        [weakself.typeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.typeBgView.mas_centerY);
            make.left.equalTo(weakself.typeTitle.mas_right).offset(5);
            make.height.offset(40);
            make.width.offset(100);
        }];
        
    }

    [weakself.infoBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        if (self.viewType ==1) {
            make.top.equalTo(weakself.typeBgView.mas_bottom).offset(10);
        }else{
            make.top.offset(top);
        }
        make.height.offset(120);
    }];
    
    [weakself.infoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(5);
        make.height.offset(20);
    }];
    
    [weakself.infoTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.bottom.offset(-10);
        make.top.equalTo(weakself.infoTitle.mas_bottom);
    }];
    [weakself.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.centerY.equalTo(weakself.infoTextView.mas_centerY);
    }];
    
    [weakself.upDataButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.bottom.right.offset(-10);
        make.height.offset(SCRYFrom6(40));
    }];
    
    [weakself.addHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(weakself.infoBgView.mas_bottom).offset(5);
        make.height.offset(18);
    }];
    [weakself.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(weakself.addHint.mas_bottom).offset(2);
        make.bottom.equalTo(weakself.upDataButton.mas_top);
    }];
    
    
}


#pragma mark - 懒加载
- (UIView *)typeBgView{
    if (!_typeBgView) {
        _typeBgView = [[UIView alloc]init];
        _typeBgView.backgroundColor = White_Color;
        [self.view addSubview:_typeBgView];
    }
    return _typeBgView;
}

- (UILabel *)typeTitle{
    if (!_typeTitle) {
        _typeTitle = [UILabel labelWithText:@"异常类型：" atColor:Black_Color atTextSize:16 atTextFontForType:@""];
        [self.typeBgView addSubview:_typeTitle];
    }
    return _typeTitle;
}

- (UIButton *)typeButton{
    if (!_typeButton) {
        _typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_typeButton setTitleColor:FontGray_Color forState:UIControlStateNormal];
        [_typeButton setTitle:@"请选择" forState:UIControlStateNormal];
        [_typeButton addTarget:self action:@selector(clickTypeButton) forControlEvents:UIControlEventTouchUpInside];
        [self.typeBgView addSubview:_typeButton];
    }
    return _typeButton;
}

- (UIView *)infoBgView{
    if (!_infoBgView) {
        _infoBgView = [[UIView alloc]init];
        _infoBgView.backgroundColor = White_Color;
        [self.view addSubview:_infoBgView];
    }
    return _infoBgView;
}
- (UILabel *)infoTitle{
    if (!_infoTitle) {
        _infoTitle = [UILabel labelWithText:@"问题描述：" atColor:Black_Color atTextSize:16 atTextFontForType:@""];
        [self.infoBgView addSubview:_infoTitle];
    }
    return _infoTitle;
}
- (UITextView *)infoTextView{
    if (!_infoTextView) {
        _infoTextView = [[UITextView alloc]init];
        _infoTextView.delegate = self;
        _infoTextView.font = [UIFont systemFontOfSize:16];
        [self.infoBgView addSubview:_infoTextView];
    }
    return _infoTextView;
}
- (UILabel *)placeholderLabel{
    if (!_placeholderLabel){
        _placeholderLabel = [UILabel labelWithText:@"输入问题描述" atColor:Text_Color_Three atTextSize:16 atTextFontForType:Common_Font];
        [self.infoTextView addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}

- (SetingPopupView *)ballView{
    if (!_ballView) {
        _ballView = [[SetingPopupView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _ballView.delegate = self;
    }
    return _ballView;
}
- (UIButton *)upDataButton{
    if (!_upDataButton) {
        _upDataButton = [UIButton buttonWithTitle:@"确认上传" atTitleSize:20 atTitleColor:White_Color atTarget:self atAction:@selector(clickUpDataButton)];
        _upDataButton.backgroundColor = COLOR(34, 114, 230, 1);
        _upDataButton.layer.cornerRadius = 5;
        _upDataButton.layer.masksToBounds = YES;
        [self.view addSubview:_upDataButton];
    }
    return _upDataButton;
}
- (UILabel *)addHint{
    if (!_addHint) {
        _addHint = [UILabel labelWithText:@"添加图片" atColor:FontGray_Color atTextSize:16 atTextFontForType:@""];
        [self.view addSubview:_addHint];
    }
    return _addHint;
}
- (UICollectionView *)collectionView{
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
@end
