//
//  SetingViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/22.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "SetingViewController.h"
/** 开关按钮Cell */
#import "SetingSwithTableCell.h"
/** 弹窗Cell */
#import "SetingPopupTableCell.h"
/** 弹出视图 */
#import "SetingPopupView.h"


@interface SetingViewController ()
<UITableViewDelegate,
UITableViewDataSource,
SetingPopupViewDelegate,
SetingSwithTableCellDelegate
>
//{
//    SystemSoundID soundID;//铃声
//
//}

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)SetingPopupView * ballView;

@property (nonatomic,strong)AVPlayer * player;
/** 音频 */
@property (nonatomic,strong)NSMutableArray * voiceArray;
/** 接单类型 */
@property (nonatomic,strong)NSMutableArray * receptionArray;
/** 接单详情 */
@property (nonatomic,strong)NSMutableArray * receptionInfoArray;

@end

static NSString *const swithCellID = @"swithCellID";
static NSString *const popupCellID = @"popupCellID";
@implementation SetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"接单设置";

    
    [self.tableView registerClass:[SetingSwithTableCell class] forCellReuseIdentifier:swithCellID];
    [self.tableView registerClass:[SetingPopupTableCell class] forCellReuseIdentifier:popupCellID];
    
}
#pragma mark - 数据处理
- (void)upUserEditData{

    NSMutableDictionary * mutDic = @{}.mutableCopy;
    [mutDic setObject:[UserModel sharedUserInfo].userid forKey:@"userid"];
    [mutDic setObject:self.receptionArray[0] forKey:@"zc"];
    [mutDic setObject:self.receptionArray[1] forKey:@"pc"];
    [mutDic setObject:self.receptionInfoArray[1] forKey:@"earea"];
    if ([self.receptionInfoArray[0] isEqualToString:@"1公里"]) {
        [mutDic setObject:@"1" forKey:@"gls"];
    }else if ([self.receptionInfoArray[0] isEqualToString:@"5公里"]){
        [mutDic setObject:@"5" forKey:@"gls"];
    }else{
        [mutDic setObject:@"20" forKey:@"gls"];
    }
    NSMutableDictionary * upData = @{}.mutableCopy;
    upData = [NetWorkingManager combinationObj:@"Modify" proc:@"USP_UPDATE_CHAUFFERINFO_EAREA_APP" pars:mutDic];
    [[NetWorkingManager sharedManager]POSTWithParameters:upData success:^(id responseObject) {
        [MBProgressHUD showSuccess:@"修改成功"];
        [self setUserModel];
        [self.tableView reloadData];
    } error:^(id error) {
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)setUserModel{
    NSMutableDictionary * userSetingDic = @{}.mutableCopy;
    if ([self.receptionInfoArray[0] isEqualToString:@"1公里"]) {
        [userSetingDic setObject:@"1" forKey:@"gls"];
    }else if ([self.receptionInfoArray[0] isEqualToString:@"5公里"]){
        [userSetingDic setObject:@"5" forKey:@"gls"];
    }else{
        [userSetingDic setObject:@"20" forKey:@"gls"];
    }
    [userSetingDic setObject:self.receptionArray[0]  forKey:@"zc"];
    [userSetingDic setObject:self.receptionArray[1]  forKey:@"pc"];

    [UserModel setUserInfoModelWithDict:userSetingDic];
    [AccessTool saveUserInfo];
}
#pragma mark - 代理点击方法
/**
 点击弹窗页面调用方法
 
 @param index  弹窗的类型   1 接收范围  2 目的地区域
 @param selectString 返回的字符串
 */
- (void)clickSelectButton:(NSInteger)index selectObj:(NSString *)selectString{
    [self.receptionInfoArray replaceObjectAtIndex:index-1 withObject:selectString];
    
    [self upUserEditData];
}

/**
 当开关状态改变的时候调用的方法
 
 @param indexPath 改变的下标
 @param state 改变的内容
 */
- (void)switchValueChangeWithIndexPath:(NSIndexPath *)indexPath withState:(NSString *)state{
    if (indexPath .section==0) {
        [self.voiceArray replaceObjectAtIndex:indexPath.row withObject:state];
        if (indexPath.row == 0) {
            [[NSUserDefaults standardUserDefaults]setObject:self.voiceArray[indexPath.row] forKey:OrderVoice];
            if ([state isEqualToString:@"1"]) {
                [[NSNotificationCenter defaultCenter]postNotificationName:PlayVideo object:self userInfo:nil];
            }
        }else{
            [[NSUserDefaults standardUserDefaults]setObject:self.voiceArray[indexPath.row] forKey:OrderShake];
            if ([state isEqualToString:@"1"]) {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }
        }
        [MBProgressHUD showSuccess:@"修改成功"];
    }else{
        [self.receptionArray replaceObjectAtIndex:indexPath.row withObject:state];
        [self upUserEditData];
    }
}
///** 播放音频 */
//-(void)playCallSound{
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//    NSString *path = [[NSBundle mainBundle]pathForResource:@"neworder" ofType:@"mp3"];
//    NSURL *audioPath = [NSURL fileURLWithPath:path];
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(audioPath), &soundID);
//    AudioServicesAddSystemSoundCompletion(soundID,NULL,NULL,EMSystemSoundFinishedPlayingCall,NULL);
//    AudioServicesPlaySystemSound(soundID);
//}
//
///** 系统铃声播放完成后的回调 */
//void EMSystemSoundFinishedPlayingCall(SystemSoundID sound_id, void* user_data){
//    AudioServicesDisposeSystemSoundID(sound_id);
//}

#pragma mark - tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCRYFrom6(45);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    headerView.backgroundColor = COLOR(243, 244, 245, 1);
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section <2) {
        SetingSwithTableCell * cell = [tableView dequeueReusableCellWithIdentifier:swithCellID];
        cell.titleLabel.text = @[@[@"新订单提示音",@"震动"],@[@"接收专车单",@"接收拼车单"]][indexPath.section][indexPath.row];
        cell.cellIndexPath = indexPath;
        cell.switchState = @[self.voiceArray,self.receptionArray][indexPath.section][indexPath.row];
        cell.delegate = self;
        return cell;
    }else{
        SetingPopupTableCell * cell = [tableView dequeueReusableCellWithIdentifier:popupCellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.text = @[@"接收距离",@"目的区域"][indexPath.row];
        cell.contentLabel.text = self.receptionInfoArray[indexPath.row];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==2) {
        AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.ballView.type = indexPath.row+1;
        [appdelegate.window addSubview:self.ballView];
    }
}

#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-(TopHeight)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (SetingPopupView *)ballView{
    if (!_ballView) {
        _ballView = [[SetingPopupView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _ballView.delegate = self;
    }
    return _ballView;
}
- (NSMutableArray *)voiceArray{
    if (!_voiceArray) {
        NSString * orderVoice = [[NSUserDefaults standardUserDefaults]objectForKey:OrderVoice];
        NSString * orderShake = [[NSUserDefaults standardUserDefaults]objectForKey:OrderShake];
        _voiceArray = [NSMutableArray arrayWithObjects:orderVoice, orderShake,nil];
    }
    return _voiceArray;
}

- (NSMutableArray *)receptionArray{
    if (!_receptionArray){
        NSString * zc = [UserModel sharedUserInfo].zc;
        NSString * pc = [UserModel sharedUserInfo].pc;
        _receptionArray = [NSMutableArray arrayWithObjects:zc,pc, nil];
    }
    return _receptionArray;
}
- (NSMutableArray *)receptionInfoArray{
    if (!_receptionInfoArray) {
        NSString * jl = [NSString stringWithFormat:@"%@公里", [UserModel sharedUserInfo].gls];
        NSString * qy = [UserModel sharedUserInfo].earea;
        _receptionInfoArray = [NSMutableArray arrayWithObjects:jl,qy, nil];
    }
    return _receptionInfoArray;
}



@end
