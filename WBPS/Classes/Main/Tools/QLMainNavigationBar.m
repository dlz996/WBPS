//
//  QLMainNavigationBar.m
//  QiongLiao
//
//  Created by 怪蜀黍 on 16/9/11.
//  Copyright © 2016年 QiongLiao. All rights reserved.
//

#import "QLMainNavigationBar.h"

@implementation QLMainNavigationBar
+(void)navigationBarChangeForViewController:(UIViewController*)viewController navigationBarWithTintColor:(UIColor *)tintColor BarTintColor:(UIColor *)barTintColor StatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    [viewController.navigationController.navigationBar setTintColor:tintColor];
    viewController.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault ;
    
    NSMutableDictionary *attDict = @{}.mutableCopy;
    [attDict setObject:tintColor forKey:NSForegroundColorAttributeName];
    [viewController.navigationController.navigationBar setTitleTextAttributes:attDict];
    [viewController.navigationController.navigationBar setBarTintColor:barTintColor];
    [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle animated:NO];
}



@end
