//
//  UserModel.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/9.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (instancetype)sharedUserInfo{
    static UserModel * userModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userModel = [[UserModel alloc]init];
    });
    return userModel;
}
+ (void)setUserInfoModelWithDict:(NSDictionary *)dict{
    if (dict == nil){
        return;
    }
    if ([dict objectForKey:@"companyid"]){
        [UserModel sharedUserInfo].companyid =[NSString stringWithFormat:@"%@",[dict objectForKey:@"companyid"]];
    }
    
    if ([dict objectForKey:@"lastpointdate"]){
        [UserModel sharedUserInfo].lastpointdate =[NSString stringWithFormat:@"%@",[dict objectForKey:@"lastpointdate"]];
    }
    if ([dict objectForKey:@"CapitalAccount"]){
        [UserModel sharedUserInfo].CapitalAccount =[NSString stringWithFormat:@"%@",[dict objectForKey:@"CapitalAccount"]];
    }
    if ([dict objectForKey:@"vehiclebrand"]){
        [UserModel sharedUserInfo].vehiclebrand =[NSString stringWithFormat:@"%@",[dict objectForKey:@"vehiclebrand"]];
    }
    if ([dict objectForKey:@"pwd"]){
        [UserModel sharedUserInfo].pwd =[NSString stringWithFormat:@"%@",[dict objectForKey:@"pwd"]];
    }
    if ([dict objectForKey:@"id"]){
        [UserModel sharedUserInfo].id =[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
    }
    if ([dict objectForKey:@"userid"]){
        [UserModel sharedUserInfo].userid =[NSString stringWithFormat:@"%@",[dict objectForKey:@"userid"]];
    }
    if ([dict objectForKey:@"token"]){
        [UserModel sharedUserInfo].token =[NSString stringWithFormat:@"%@",[dict objectForKey:@"token"]];
    }
    if ([dict objectForKey:@"username"]){
        [UserModel sharedUserInfo].username =[NSString stringWithFormat:@"%@",[dict objectForKey:@"username"]];
    }
    if ([dict objectForKey:@"usermb"]){
        [UserModel sharedUserInfo].usermb =[NSString stringWithFormat:@"%@",[dict objectForKey:@"usermb"]];
    }
    if ([dict objectForKey:@"headimepath"]){
        [UserModel sharedUserInfo].headimepath =[NSString stringWithFormat:@"%@",[dict objectForKey:@"headimepath"]];
    }
    if ([dict objectForKey:@"usertype"]){
        [UserModel sharedUserInfo].usertype =[NSString stringWithFormat:@"%@",[dict objectForKey:@"usertype"]];
    }
    if ([dict objectForKey:@"checkstate"]){
        [UserModel sharedUserInfo].checkstate =[NSString stringWithFormat:@"%@",[dict objectForKey:@"checkstate"]];
    }
    if ([dict objectForKey:@"lng"]){
        [UserModel sharedUserInfo].lng =[NSString stringWithFormat:@"%@",[dict objectForKey:@"lng"]];
    }
    if ([dict objectForKey:@"lat"]){
        [UserModel sharedUserInfo].lat =[NSString stringWithFormat:@"%@",[dict objectForKey:@"lat"]];
    }
    if ([dict objectForKey:@"checkremark"]){
        [UserModel sharedUserInfo].checkremark =[NSString stringWithFormat:@"%@",[dict objectForKey:@"checkremark"]];
    }
    if ([dict objectForKey:@"clsbzcode"]){
        [UserModel sharedUserInfo].clsbzcode =[NSString stringWithFormat:@"%@",[dict objectForKey:@"clsbzcode"]];
    }
    if ([dict objectForKey:@"xszcode"]){
        [UserModel sharedUserInfo].xszcode =[NSString stringWithFormat:@"%@",[dict objectForKey:@"xszcode"]];
    }
    if ([dict objectForKey:@"yycode"]){
        [UserModel sharedUserInfo].yycode =[NSString stringWithFormat:@"%@",[dict objectForKey:@"yycode"]];
    }
    if ([dict objectForKey:@"vehicleno"]){
        [UserModel sharedUserInfo].vehicleno =[NSString stringWithFormat:@"%@",[dict objectForKey:@"vehicleno"]];
    }
    if ([dict objectForKey:@"idcode"]){
        [UserModel sharedUserInfo].idcode =[NSString stringWithFormat:@"%@",[dict objectForKey:@"idcode"]];
    }
    if ([dict objectForKey:@"jszcode"]){
        [UserModel sharedUserInfo].jszcode =[NSString stringWithFormat:@"%@",[dict objectForKey:@"jszcode"]];
    }
    if ([dict objectForKey:@"sheng"]){
        [UserModel sharedUserInfo].sheng =[NSString stringWithFormat:@"%@",[dict objectForKey:@"sheng"]];
    }
    if ([dict objectForKey:@"city"]){
        [UserModel sharedUserInfo].city =[NSString stringWithFormat:@"%@",[dict objectForKey:@"city"]];
    }
    if ([dict objectForKey:@"area"]){
        [UserModel sharedUserInfo].area =[NSString stringWithFormat:@"%@",[dict objectForKey:@"area"]];
    }
    if ([dict objectForKey:@"addr"]){
        [UserModel sharedUserInfo].addr =[NSString stringWithFormat:@"%@",[dict objectForKey:@"addr"]];
    }
    if ([dict objectForKey:@"earea"]){
        [UserModel sharedUserInfo].earea =[NSString stringWithFormat:@"%@",[dict objectForKey:@"earea"]];
    }
    if ([dict objectForKey:@"loadstate"]){
        [UserModel sharedUserInfo].loadstate =[NSString stringWithFormat:@"%@",[dict objectForKey:@"loadstate"]];
    }
    if ([dict objectForKey:@"freevolumn"]){
        [UserModel sharedUserInfo].freevolumn =[NSString stringWithFormat:@"%@",[dict objectForKey:@"freevolumn"]];
    }
    if ([dict objectForKey:@"volumn"]){
        [UserModel sharedUserInfo].volumn =[NSString stringWithFormat:@"%@",[dict objectForKey:@"volumn"]];
    }
    if ([dict objectForKey:@"weight"]){
        [UserModel sharedUserInfo].weight =[NSString stringWithFormat:@"%@",[dict objectForKey:@"weight"]];
    }
    if ([dict objectForKey:@"freeweight"]){
        [UserModel sharedUserInfo].freeweight =[NSString stringWithFormat:@"%@",[dict objectForKey:@"freeweight"]];
    }
    if ([dict objectForKey:@"vehicletypeid"]){
        [UserModel sharedUserInfo].vehicletypeid =[NSString stringWithFormat:@"%@",[dict objectForKey:@"vehicletypeid"]];
    }
    if ([dict objectForKey:@"zc"]){
        [UserModel sharedUserInfo].zc =[NSString stringWithFormat:@"%@",[dict objectForKey:@"zc"]];
    }
    if ([dict objectForKey:@"pc"]){
        [UserModel sharedUserInfo].pc =[NSString stringWithFormat:@"%@",[dict objectForKey:@"pc"]];
    }
    if ([dict objectForKey:@"ystype"]){
        [UserModel sharedUserInfo].ystype =[NSString stringWithFormat:@"%@",[dict objectForKey:@"ystype"]];
    }
    if ([dict objectForKey:@"gls"]){
        [UserModel sharedUserInfo].gls =[NSString stringWithFormat:@"%@",[dict objectForKey:@"gls"]];
    }
    if ([dict objectForKey:@"jszenddate"]){
        [UserModel sharedUserInfo].jszenddate =[NSString stringWithFormat:@"%@",[dict objectForKey:@"jszenddate"]];
    }
    if ([dict objectForKey:@"score"]){
        [UserModel sharedUserInfo].score =[NSString stringWithFormat:@"%@",[dict objectForKey:@"score"]];
    }
    if ([dict objectForKey:@"glssum"]){
        [UserModel sharedUserInfo].glssum =[NSString stringWithFormat:@"%@",[dict objectForKey:@"glssum"]];
    }
    if ([dict objectForKey:@"fetchcount"]){
        [UserModel sharedUserInfo].fetchcount =[NSString stringWithFormat:@"%@",[dict objectForKey:@"fetchcount"]];
    }
    if ([dict objectForKey:@"gid"]) {
        [UserModel sharedUserInfo].gid = [NSString stringWithFormat:@"%@",[dict objectForKey:@"gid"]];
    }
    if ([dict objectForKey:@"imagepid"]) {
        [UserModel sharedUserInfo].imagepid = [NSString stringWithFormat:@"%@",[dict objectForKey:@"imagepid"]];
    }
    
}

- (id)initWithCoder:(NSCoder *)deCoder {
    if (self = [super init]) {
        
        self.companyid = [deCoder decodeObjectForKey:@"companyid"];
        self.lastpointdate = [deCoder decodeObjectForKey:@"lastpointdate"];
        self.CapitalAccount = [deCoder decodeObjectForKey:@"CapitalAccount"];
        self.vehiclebrand = [deCoder decodeObjectForKey:@"vehiclebrand"];
        self.pwd = [deCoder decodeObjectForKey:@"pwd"];
        self.id = [deCoder decodeObjectForKey:@"id"];
        self.userid = [deCoder decodeObjectForKey:@"userid"];
        self.token = [deCoder decodeObjectForKey:@"token"];
        self.username = [deCoder decodeObjectForKey:@"username"];
        self.usermb = [deCoder decodeObjectForKey:@"usermb"];
        self.headimepath = [deCoder decodeObjectForKey:@"headimepath"];
        self.usertype = [deCoder decodeObjectForKey:@"usertype"];
        self.checkstate = [deCoder decodeObjectForKey:@"checkstate"];
        self.lng = [deCoder decodeObjectForKey:@"lng"];
        self.lat = [deCoder decodeObjectForKey:@"lat"];
        self.checkremark = [deCoder decodeObjectForKey:@"checkremark"];
        self.clsbzcode = [deCoder decodeObjectForKey:@"clsbzcode"];
        self.xszcode = [deCoder decodeObjectForKey:@"xszcode"];
        self.yycode = [deCoder decodeObjectForKey:@"yycode"];
        self.vehicleno = [deCoder decodeObjectForKey:@"vehicleno"];
        self.idcode = [deCoder decodeObjectForKey:@"idcode"];
        self.jszcode = [deCoder decodeObjectForKey:@"jszcode"];
        self.sheng = [deCoder decodeObjectForKey:@"sheng"];
        self.city = [deCoder decodeObjectForKey:@"city"];
        self.area = [deCoder decodeObjectForKey:@"area"];
        self.addr = [deCoder decodeObjectForKey:@"addr"];
        self.earea = [deCoder decodeObjectForKey:@"earea"];
        self.loadstate = [deCoder decodeObjectForKey:@"loadstate"];
        self.freevolumn = [deCoder decodeObjectForKey:@"freevolumn"];
        self.volumn = [deCoder decodeObjectForKey:@"volumn"];
        self.weight = [deCoder decodeObjectForKey:@"weight"];
        self.vehicletypeid = [deCoder decodeObjectForKey:@"vehicletypeid"];
        self.pc = [deCoder decodeObjectForKey:@"pc"];
        self.zc = [deCoder decodeObjectForKey:@"zc"];
        self.ystype = [deCoder decodeObjectForKey:@"ystype"];
        self.gls = [deCoder decodeObjectForKey:@"gls"];
        self.jszenddate = [deCoder decodeObjectForKey:@"jszenddate"];
        self.score = [deCoder decodeObjectForKey:@"score"];
        self.glssum = [deCoder decodeObjectForKey:@"glssum"];
        self.fetchcount = [deCoder decodeObjectForKey:@"fetchcount"];
        self.gid = [deCoder decodeObjectForKey:@"gid"];
        self.imagepid = [deCoder decodeObjectForKey:@"imagepid"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)enCoder {
    
    [enCoder encodeObject:_companyid forKey:@"companyid"];
    [enCoder encodeObject:_lastpointdate forKey:@"lastpointdate"];
    [enCoder encodeObject:_CapitalAccount forKey:@"CapitalAccount"];
    [enCoder encodeObject:_vehiclebrand forKey:@"vehiclebrand"];
    [enCoder encodeObject:_pwd forKey:@"pwd"];
    [enCoder encodeObject:_id forKey:@"id"];
    [enCoder encodeObject:_userid  forKey:@"userid"];
    [enCoder encodeObject:_token forKey:@"token"];
    [enCoder encodeObject:_username forKey:@"username"];
    [enCoder encodeObject:_usermb forKey:@"usermb"];
    [enCoder encodeObject:_headimepath forKey:@"headimepath"];
    [enCoder encodeObject:_usertype forKey:@"usertype"];
    [enCoder encodeObject:_checkstate forKey:@"checkstate"];
    [enCoder encodeObject:_lng forKey:@"lng"];
    [enCoder encodeObject:_lat forKey:@"lat"];
    [enCoder encodeObject:_checkremark forKey:@"checkremark"];
    [enCoder encodeObject:_clsbzcode forKey:@"clsbzcode"];
    [enCoder encodeObject:_xszcode forKey:@"xszcode"];
    [enCoder encodeObject:_yycode forKey:@"yycode"];
    [enCoder encodeObject:_vehicleno forKey:@"vehicleno"];
    [enCoder encodeObject:_idcode forKey:@"idcode"];
    [enCoder encodeObject:_jszcode forKey:@"jszcode"];
    [enCoder encodeObject:_sheng forKey:@"sheng"];
    [enCoder encodeObject:_city forKey:@"city"];
    [enCoder encodeObject:_area forKey:@"area"];
    [enCoder encodeObject:_addr forKey:@"addr"];
    [enCoder encodeObject:_earea forKey:@"earea"];
    [enCoder encodeObject:_loadstate forKey:@"loadstate"];
    [enCoder encodeObject:_freevolumn forKey:@"freevolumn"];
    [enCoder encodeObject:_volumn forKey:@"volumn"];
    [enCoder encodeObject:_weight forKey:@"weight"];
    [enCoder encodeObject:_vehicletypeid forKey:@"vehicletypeid"];
    [enCoder encodeObject:_pc forKey:@"pc"];
    [enCoder encodeObject:_zc forKey:@"zc"];
    [enCoder encodeObject:_ystype forKey:@"ystype"];
    [enCoder encodeObject:_gls forKey:@"gls"];
    [enCoder encodeObject:_jszenddate forKey:@"jszenddate"];
    [enCoder encodeObject:_score forKey:@"score"];
    [enCoder encodeObject:_glssum forKey:@"glssum"];
    [enCoder encodeObject:_fetchcount forKey:@"fetchcount"];
    [enCoder encodeObject:_gid forKey:@"gid"];
    
}


@end
