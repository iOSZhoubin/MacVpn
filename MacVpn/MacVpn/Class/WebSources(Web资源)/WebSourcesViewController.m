//
//  WebSourcesViewController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/24.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "WebSourcesViewController.h"
#import <WebKit/WebKit.h>

@interface WebSourcesViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (weak) IBOutlet WKWebView *webView;

@property (strong,nonatomic) NSProgressIndicator *indicator;

@end

@implementation WebSourcesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    
    [self initShow];
    
    [self loadHtml];
}

-(void)loadHtml{
    
    NSString *CSS= @"<style type=\"text/css\">img{ width:100%;}</style>";
    
    NSString *body = @"<h1 style=\"text-align: center;\">关于全市展开卫生检查的通知</h1><img src=\"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1561527074501&di=4c9240af62757ccdd15b639885c18ead&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Fa1b9a6ab35f1a8443f6c9f6e8a72955f99c858511defc-cqXL5G_fw658\" </img> <img src=\"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=687516638,2332654868&fm=26&gp=0.jpg\"></img><div><a href=\"https://www.baidu.com\">百度</a> <span>西安交大捷普网络科技有限公司</span></div>";
    
    
    NSString * htmlString = [NSString stringWithFormat:@"<html><meta charset=\"UTF-8\"><header>%@</header><body>%@</body></html>",CSS,body];
    
    [self.webView loadHTMLString:htmlString baseURL:nil];
    
}


#pragma mark -- 实现WKNavigationDelegate委托协议

//开始加载时调用

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{

    JumpLog(@"开始加载");
    
}

//当内容开始返回时调用

-(void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
    JumpLog(@"内容开始返回");
}

//加载完成之后调用

-(void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
    JumpLog(@"加载完成");
    
    self.indicator.hidden = YES;
    
    [self.indicator stopAnimation:nil];
    
}

//加载失败时调用

-(void)webView:(WKWebView *)webView didFailLoadWithError:(nonnull NSError *)error{
    
    JumpLog(@"加载失败 error : %@",error.description);

    [JumpPublicAction showAlert:@"提示" andMessage:@"加载失败" window:self.view.window];

}


#pragma mark -- 刷新

- (IBAction)refreshWebSource:(NSButton *)sender {
    
    self.indicator.hidden = NO;
    
    [self.indicator startAnimation:nil];
    
    [self loadHtml];
}


//初始化加载动画

-(void)initShow{
    
    self.indicator = [[NSProgressIndicator alloc]initWithFrame:CGRectMake(300, 400, 40, 40)];
    
    self.indicator.style = NSProgressIndicatorSpinningStyle;
    
    self.indicator.controlSize = NSControlSizeRegular;
    
    [self.indicator sizeToFit];
    
    [self.view addSubview:self.indicator];
    
    self.indicator.hidden = YES;
}




@end
