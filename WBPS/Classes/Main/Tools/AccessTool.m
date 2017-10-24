//
//  AccessTool.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/9.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "AccessTool.h"

@implementation AccessTool

+ (void)saveUserInfo{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *userInfoPath = [path stringByAppendingPathComponent:@"userInfo.data"];
    [NSKeyedArchiver archiveRootObject:[UserModel sharedUserInfo] toFile:userInfoPath];
}

+ (void)loadUserInfo{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *userInfoPath = [path stringByAppendingPathComponent:@"userInfo.data"];
    /** 读取信息 */
    UserModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:userInfoPath];
    
    [UserModel sharedUserInfo].companyid = model.companyid;
    [UserModel sharedUserInfo].lastpointdate = model.lastpointdate;
    [UserModel sharedUserInfo].CapitalAccount = model.CapitalAccount;
    [UserModel sharedUserInfo].vehiclebrand = model.vehiclebrand;
    [UserModel sharedUserInfo].pwd = model.pwd;
    [UserModel sharedUserInfo].id = model.id;
    [UserModel sharedUserInfo].userid = model.userid;
    [UserModel sharedUserInfo].token = model.token;
    [UserModel sharedUserInfo].username = model.username;
    [UserModel sharedUserInfo].usermb = model.usermb;
    [UserModel sharedUserInfo].headimepath = model.headimepath;
    [UserModel sharedUserInfo].usertype = model.usertype;
    [UserModel sharedUserInfo].checkstate = model.checkstate;
    [UserModel sharedUserInfo].lng = model.lng;
    [UserModel sharedUserInfo].lat = model.lat;
    [UserModel sharedUserInfo].checkremark = model.checkremark;
    [UserModel sharedUserInfo].clsbzcode = model.clsbzcode;
    [UserModel sharedUserInfo].xszcode = model.xszcode;
    [UserModel sharedUserInfo].yycode = model.yycode;
    [UserModel sharedUserInfo].vehicleno = model.vehicleno;
    [UserModel sharedUserInfo].idcode = model.idcode;
    [UserModel sharedUserInfo].jszcode = model.jszcode;
    [UserModel sharedUserInfo].sheng = model.sheng;
    [UserModel sharedUserInfo].city = model.city;
    [UserModel sharedUserInfo].area = model.area;
    [UserModel sharedUserInfo].addr = model.addr;
    [UserModel sharedUserInfo].earea = model.earea;
    [UserModel sharedUserInfo].loadstate = model.loadstate;
    [UserModel sharedUserInfo].freevolumn = model.freevolumn;
    [UserModel sharedUserInfo].volumn = model.volumn;
    [UserModel sharedUserInfo].weight = model.weight;
    [UserModel sharedUserInfo].freeweight = model.freeweight;
    [UserModel sharedUserInfo].vehicletypeid = model.vehicletypeid;
    [UserModel sharedUserInfo].zc = model.zc;
    [UserModel sharedUserInfo].pc = model.pc;
    [UserModel sharedUserInfo].ystype = model.ystype;
    [UserModel sharedUserInfo].gls = model.gls;
    [UserModel sharedUserInfo].jszenddate = model.jszenddate;
    [UserModel sharedUserInfo].score = model.score;
    [UserModel sharedUserInfo].glssum = model.glssum;
    [UserModel sharedUserInfo].fetchcount = model.fetchcount;
    [UserModel sharedUserInfo].gid = model.gid;
    [UserModel sharedUserInfo].imagepid = model.imagepid;
}



@end
