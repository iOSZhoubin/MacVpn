//
//  WebSourcesViewController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/24.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "WebSourcesViewController.h"
#import <WebKit/WebKit.h>

@interface WebSourcesViewController ()

@property (weak) IBOutlet WebView *webView;

@end

@implementation WebSourcesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlString = @"http://www.baidu.com";

    [[self.webView  mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    
//    [[self.webView mainFrame] loadHTMLString:htmlStr baseURL:[NSURL URLWithString:@"https://10.0.7.200"]];
}


//加载完成
- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame{
   
    JumpLog(@"~~~~~加载完成~~~~~");
    
}

//加载失败
- (void)webView:(WebView *)sender didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame{
   
    JumpLog(@"~~~~~加载失败~~~~~");
}



@end
