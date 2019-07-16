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
//刷新按钮
@property (weak) IBOutlet NSButton *refreshBtn;

@property (strong,nonatomic) NSProgressIndicator *indicator;

@property (assign,nonatomic) BOOL showAlert;

@end

@implementation WebSourcesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.UIDelegate = self;
    
    self.webView.navigationDelegate = self;
    
    self.showAlert = NO;
    
    [self initShow];
    
    [self getwebSource];
}

-(void)loadHtml:(NSString *)htmlStr{
    
    [self.webView loadHTMLString:htmlStr baseURL:nil];

}


#pragma mark -- 实现WKNavigationDelegate委托协议

//加载失败时调用

-(void)webView:(WKWebView *)webView didFailLoadWithError:(nonnull NSError *)error{
    
    JumpLog(@"加载失败 error : %@",error.description);

}


#pragma mark -- 刷新

- (IBAction)refreshWebSource:(NSButton *)sender {
    
    self.indicator.hidden = NO;
    
    self.refreshBtn.enabled = NO;
    
    self.showAlert = YES;
    
    [self.indicator startAnimation:nil];
    
    [self getwebSource];
}


//初始化加载动画

-(void)initShow{
    
    self.indicator = [[NSProgressIndicator alloc]initWithFrame:CGRectMake(280, 400, 40, 40)];
    
    self.indicator.style = NSProgressIndicatorSpinningStyle;
    
    self.indicator.controlSize = NSControlSizeRegular;
    
    [self.indicator sizeToFit];
    
    [self.view addSubview:self.indicator];
    
    self.indicator.hidden = YES;
}


#pragma mark --- 获取WebSource

-(void)getwebSource{
    
    L2CWeakSelf(self);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //如果有保存用户名，IP地址和端口号，那么就直接赋值
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"mac_userInfo"];
    
    parameters[@"ip"] =  SafeString(userInfo[@"ipAddress"]);
    parameters[@"port"] =  SafeString(userInfo[@"port"]);
    
    [AFNHelper macGet:Macvpn_Webresource parameters:parameters success:^(id responseObject) {
        
        NSDictionary *dict = responseObject;
        
        NSString *str = dict[@"result"];
        
        if(str.length > 0){
            
            if(weakself.showAlert == YES){
                
                [JumpPublicAction showAlert:@"提示" andMessage:@"数据加载成功" window:weakself.view.window];
            }
            
            [weakself loadHtml:str];
        }
        
        weakself.indicator.hidden = YES;
        
        weakself.refreshBtn.enabled = YES;
        
        [weakself.indicator stopAnimation:nil];
        
    } andFailed:^(id error) {
        
        weakself.indicator.hidden = YES;
        
        weakself.refreshBtn.enabled = YES;
        
        [weakself.indicator stopAnimation:nil];
        
        [JumpPublicAction showAlert:@"提示" andMessage:@"请求服务器失败" window:weakself.view.window];
    }];
}


@end
