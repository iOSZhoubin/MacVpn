//
//  loginViewController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/14.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "loginViewController.h"
#import "FirstWindowController.h"
#import "RegisterViewController.h"



@interface loginViewController ()

//登录成功后显示的窗口
@property (strong,nonatomic) FirstWindowController *firstWc;
//帐户名
@property (weak) IBOutlet NSTextField *accountL;
//密码
@property (weak) IBOutlet NSSecureTextField *passwordL;
//ip地址
@property (weak) IBOutlet NSTextField *ipaddress;
//端口号
@property (weak) IBOutlet NSTextField *portL;
//加载
@property (strong,nonatomic) NSProgressIndicator *indicator;
//登录按钮
@property (weak) IBOutlet NSButton *loginBtn;

@property (strong,nonatomic) RegisterViewController *registerVc;

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.firstWc = [[FirstWindowController alloc]initWithWindowNibName:@"FirstWindowController"];
    
    self.registerVc = [[RegisterViewController alloc]initWithWindowNibName:@"RegisterViewController"];

    //如果有保存用户名，IP地址和端口号，那么就直接赋值
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"mac_userInfo"];

    if(userInfo){
        
        self.accountL.stringValue = SafeString(userInfo[@"account"]);
        self.ipaddress.stringValue = SafeString(userInfo[@"ipAddress"]);
        self.portL.stringValue = SafeString(userInfo[@"port"]);
    }

    [self initShow];
}


#pragma mark --- 登录

- (IBAction)loginAction:(NSButton *)sender {
    
    if(SafeString(self.accountL.stringValue).length < 1){
        
        [JumpPublicAction showAlert:@"提示" andMessage:@"请输入用户名" window:self.mainWC];

        return;

    }else if (SafeString(self.passwordL.stringValue).length < 1){

        [JumpPublicAction showAlert:@"提示" andMessage:@"请输入密码" window:self.mainWC];

        return;

    }else if (SafeString(self.ipaddress.stringValue).length < 1){

        [JumpPublicAction showAlert:@"提示" andMessage:@"请输入服务器域名" window:self.mainWC];

        return;

    }else if (SafeString(self.portL.stringValue).length < 1){

        [JumpPublicAction showAlert:@"提示" andMessage:@"请输入端口号" window:self.mainWC];

        return;
    }
    
    NSDictionary *mudict = @{
                             @"account":SafeString(self.accountL.stringValue),
                             @"ipAddress":SafeString(self.ipaddress.stringValue),
                             @"port":SafeString(self.portL.stringValue),
                             @"password":SafeString(self.passwordL.stringValue)
                             };
    
    //存入数组并同步
    [[NSUserDefaults standardUserDefaults] setObject:mudict forKey:@"mac_userInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self loadAction];
}

-(void)loadAction{

    self.indicator.hidden = NO;

    self.loginBtn.enabled = NO;

    [self.indicator startAnimation:nil];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    parameters[@"inputname"] = SafeString(self.accountL.stringValue);
    parameters[@"inputpsw"] = SafeString(self.passwordL.stringValue);
    parameters[@"login"] = @"1";
    parameters[@"enevs"] = @"login";
    parameters[@"ios"] = @"ios";

    L2CWeakSelf(self);

    [AFNHelper macPost:Macvpn_LoginIn parameters:parameters success:^(id responseObject) {

        NSDictionary *dict = responseObject;

        if([dict[@"result"][@"result"] isEqualToString:@"success"]){

            [weakself.firstWc.window orderFront:nil];//显示要跳转的窗口

            [[weakself.firstWc window] center];//显示在屏幕中间

            [weakself.mainWC orderOut:nil];//关闭当前窗口

            [weakself.registerVc.window orderOut:nil];//关闭注册窗口

        }else{
            
            NSString *message = SafeString(dict[@"result"][@"msg"]);

            [JumpPublicAction showAlert:@"提示" andMessage:message window:weakself.view.window];
        }

        weakself.indicator.hidden = YES;

        weakself.loginBtn.enabled = YES;

        [weakself.indicator stopAnimation:nil];

    } andFailed:^(id error) {

        weakself.loginBtn.enabled = YES;

        weakself.indicator.hidden = YES;

        [weakself.indicator stopAnimation:nil];
    
        [JumpPublicAction showAlert:@"提示" andMessage:@"登录失败，请检查IP地址端口号以及账号密码是否正确" window:weakself.view.window];

    }];
}

//初始化加载动画

-(void)initShow{
    
    self.indicator = [[NSProgressIndicator alloc]initWithFrame:CGRectMake(400, 300, 40, 40)];
    
    self.indicator.style = NSProgressIndicatorSpinningStyle;
    
    self.indicator.controlSize = NSControlSizeRegular;
    
    [self.indicator sizeToFit];
    
    [self.view addSubview:self.indicator];
    
    self.indicator.hidden = YES;
}



#pragma mark --- 忘记密码

- (IBAction)forgetPassw:(NSButton *)sender {
        
    [JumpPublicAction showAlert:@"提示" andMessage:@"请您与管理员联系" window:self.view.window];
}


#pragma mark --- 注册

- (IBAction)registerAction:(NSButton *)sender {
    
    [self.registerVc.window orderFront:nil];//显示要跳转的窗口
    
    [[self.registerVc window] center];//显示在屏幕中间
    
}

@end
