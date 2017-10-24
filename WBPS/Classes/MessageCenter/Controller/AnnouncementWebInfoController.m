//
//  AnnouncementWebInfoController.m
//  WBPS
//
//  Created by 董立峥 on 2017/10/16.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "AnnouncementWebInfoController.h"

@interface AnnouncementWebInfoController ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView * webView;

@end

@implementation AnnouncementWebInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)setVcTitle:(NSString *)vcTitle{
    _vcTitle = vcTitle;
    self.title = _vcTitle;
}
- (void)setInfoUrl:(NSString *)infoUrl{
    _infoUrl = infoUrl;
    NSURL * url = [NSURL URLWithString:_infoUrl];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url];
    [self.webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showActivityIndicator];
    NSLog(@"已经开始加载");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideActivityIndicator];
    NSLog(@"已经结束加载");
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}

@end
