//
//  QLMainNavigationBar.h
//  QiongLiao
//
//  Created by 怪蜀黍 on 16/9/11.
//  Copyright © 2016年 QiongLiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QLMainNavigationBar : NSObject
/**
 *  自定义导航栏以及状态栏
 *
 *  @param tintColor          导航栏字体颜色
 *  @param barTintColor       导航栏颜色
 *  @param statusBarViewColor 状态栏背景
 *  @param statusBarStyle     状态栏类型
 */
+(void)navigationBarChangeForViewController:(UIViewController*)viewController navigationBarWithTintColor:(UIColor *)tintColor BarTintColor:(UIColor *)barTintColor StatusBarStyle:(UIStatusBarStyle)statusBarStyle;
@end
