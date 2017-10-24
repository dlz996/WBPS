//
//  AppDelegate.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/21.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "BasicNavigationVontroller.h"
#import <NotificationCenter/NotificationCenter.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<JPUSHRegisterDelegate,UNUserNotificationCenterDelegate,UIAlertViewDelegate>
{
    SystemSoundID soundID;//铃声
}

/** 推送过来的消息 */
@property (nonatomic,strong)NSDictionary * pushMessage;

@end
//15919983486 123456

//13530741336   dk123456

@implementation AppDelegate
//F40F74DF-6DB9-47EC-942E-FA2DF43A9AB0
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    /***       -----       ***/
    [AccessTool loadUserInfo];
    [AMapServices sharedServices].apiKey = AMap;

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (token.length>0) {
        HomeViewController * homeVc = [[HomeViewController alloc]init];
        BasicNavigationVontroller * basicNag = [[BasicNavigationVontroller alloc]initWithRootViewController:homeVc];
        self.window.rootViewController =basicNag;
    }else{
        LoginViewController * loginVc = [[LoginViewController alloc]init];
        BasicNavigationVontroller * basicNag = [[BasicNavigationVontroller alloc]initWithRootViewController:loginVc];
        self.window.rootViewController = basicNag;
    }

    self.window.backgroundColor = White_Color;
    [self.window makeKeyAndVisible];
    [self IQKeyBoardManager];
    
 
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playCallSound) name:PlayVideo object:nil];
    
    /**   ---------------  **/
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];

    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:@"81b6a7b1690354c8c6e7017e"
                          channel:nil
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
    if (IS_IOS10_OR_LATER) {  //IOS10 之后采用UNUserNotificationCenter注册通知
        if (@available(iOS 10.0, *)) {
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            center.delegate = self;
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (!error) {
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                    NSLog(@"succeeded!");
                }
            }];
        } else {
            // Fallback on earlier versions
        }
    }else{ //IOS10 之前注册通知
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge |UIUserNotificationTypeSound |UIUserNotificationTypeAlert) categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
    }
    return YES;
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    [self playCallSound];
    self.pushMessage = userInfo;
    
    NSString *apnCount = userInfo[@"aps"][@"alert"];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"推送信息" message:apnCount delegate:self cancelButtonTitle:@"查看" otherButtonTitles:nil, nil];
    [alert show];
    
    //判断应用是在前台还是后台
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        NSLog(@"应用在前台时间推送===========");
    }else{
        NSLog(@"应用在后台时间推送===========");
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:JPushMessageKey object:self userInfo:self.pushMessage];
}
/** 播放音频 */
-(void)playCallSound{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    NSString *path = [[NSBundle mainBundle]pathForResource:@"neworder" ofType:@"mp3"];
    NSURL *audioPath = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(audioPath), &soundID);
    AudioServicesAddSystemSoundCompletion(soundID,NULL,NULL,EMSystemSoundFinishedPlayingCall,NULL);
    AudioServicesPlaySystemSound(soundID);
}
/** 系统铃声播放完成后的回调 */
void EMSystemSoundFinishedPlayingCall(SystemSoundID sound_id, void* user_data){
    AudioServicesDisposeSystemSoundID(sound_id);
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    // Required, iOS 7 Support
//    [JPUSHService handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
//}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}




/**   --=-=-=-=-=-=-=-*/

- (void)applicationWillResignActive:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    __block  UIBackgroundTaskIdentifier bgTask;
    
    bgTask= [application beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(),^{if(bgTask !=UIBackgroundTaskInvalid){
            bgTask=UIBackgroundTaskInvalid;
        }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        dispatch_async(dispatch_get_main_queue(),^{if(bgTask !=UIBackgroundTaskInvalid){
            bgTask=UIBackgroundTaskInvalid;
        }
        });
    });
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"应用已经开始活跃");

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}





- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter]removeObserver:PlayVideo];
    [[NSNotificationCenter defaultCenter]removeObserver:JPushMessageKey];
    NSLog(@"app即将被杀死");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
//    [self saveContext];
}

/** 键盘管理 */
-(void)IQKeyBoardManager{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}

@end
