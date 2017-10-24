//
//  AboutAndFAQViewController.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/11.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "AboutAndFAQViewController.h"

@interface AboutAndFAQViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView * webView;

@end

@implementation AboutAndFAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * urlStr;
    if (self.viewType ==1) {
        self.title = @"关于我们";
        urlStr = @"http://121.14.59.106:8090/aboutus/about.html";
    }else if (self.viewType ==2){
        self.title = @"常见问题";
        urlStr = @"http://121.14.59.106:8090/aboutus/problem.html";
    }

    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showActivityIndicator];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideActivityIndicator];
}

#pragma mark - 懒加载
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-(TopHeight))];
        _webView.scrollView.bounces = NO;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}


@end
