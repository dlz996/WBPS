//
//  BasicNavigationVontroller.m
//  WBPS
//
//  Created by 董立峥 on 2017/9/21.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "BasicNavigationVontroller.h"

@interface BasicNavigationVontroller ()
/** 返回按钮 */
@property (nonatomic,strong)UIButton * backButton;
@end

@implementation BasicNavigationVontroller

// 只初始化一次
+ (void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTintColor:Black_Color];
    navBar.barStyle = UIStatusBarStyleDefault ;
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:Title_Font size:18],NSForegroundColorAttributeName:Black_Color}];
    [navBar setBarTintColor:White_Color];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [navBar setNavigationBarBottomLineHidden:YES];
//    //导航透明
//    [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [navBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}
/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationController.navigationBar.hidden = NO;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:UIImageName(@"back") style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    [super popViewControllerAnimated:animated];
    return nil;
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
