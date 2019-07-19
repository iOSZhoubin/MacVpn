//
//  HelpVpnViewController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/7/19.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "HelpVpnViewController.h"
#import "MainWindowController.h"

@interface HelpVpnViewController ()
//用户名
@property (weak) IBOutlet NSTextField *accouneName;
//ip地址
@property (weak) IBOutlet NSTextField *ipAddress;

//登录界面
@property (strong,nonatomic) MainWindowController *loginWc;
//原始密码
@property (weak) IBOutlet NSSecureTextField *oldPassword;
//新密码
@property (weak) IBOutlet NSSecureTextField *newsPassword;
//确认密码
@property (weak) IBOutlet NSSecureTextField *againpassword;
//确认按钮
@property (weak) IBOutlet NSButton *sureBtn;

@property (strong,nonatomic) NSProgressIndicator *indicator;

@property (strong,nonatomic) NSAlert *alert;

@end

@implementation HelpVpnViewController

-(NSAlert *)alert{
    
    if(!_alert){
        
        _alert = [[NSAlert alloc]init];
        
        _alert.messageText = @"提示";
        
        _alert.informativeText = @"确认退出？";
        
        [_alert addButtonWithTitle:@"确定"];
        
        [_alert addButtonWithTitle:@"取消"];
        
        //设置提示框的样式
        _alert.alertStyle = NSAlertStyleWarning;
    }
    
    return _alert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //如果有保存用户名，IP地址和端口号，那么就直接赋值
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"mac_userInfo"];
    
    self.accouneName.stringValue = SafeString(userInfo[@"account"]);
    self.ipAddress.stringValue = SafeString(userInfo[@"ipAddress"]);
    self.loginWc = [[MainWindowController alloc]initWithWindowNibName:@"MainWindowController"];
}


#pragma mark --- 确定

- (IBAction)sureAction:(NSButton *)sender {
    
    if(self.oldPassword.stringValue.length < 1){
        
        [JumpPublicAction showAlert:@"提示" andMessage:@"请输入原始密码" window:self.view.window];
        
        return;
        
    }else if (self.newsPassword.stringValue.length < 1){
        
        [JumpPublicAction showAlert:@"提示" andMessage:@"请输入新密码" window:self.view.window];
        
        return;
        
        
    }else if (self.againpassword.stringValue.length < 1){
        
        [JumpPublicAction showAlert:@"提示" andMessage:@"请再次输入新密码" window:self.view.window];
        
        return;
        
    }else if (![self.againpassword.stringValue isEqualToString:self.newsPassword.stringValue]){
        
        [JumpPublicAction showAlert:@"提示" andMessage:@"两次输入密码不同，请重新输入" window:self.view.window];
        
        return;
        
    }
    
    self.sureBtn.enabled = NO;
    
    self.indicator.hidden = NO;
    
    [self.indicator startAnimation:nil];
    
    [self changePassword];
}


-(void)changePassword{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"change_pass"] = @1;
    parameters[@"oldpass"] = SafeString(self.oldPassword.stringValue);
    parameters[@"newpass"] = SafeString(self.newsPassword.stringValue);
    
    L2CWeakSelf(self);
    
    [AFNHelper macPost:Macvpn_ChangePword parameters:parameters success:^(id responseObject) {
        
        NSDictionary *dict = responseObject;
        
        if([dict[@"result"] isEqualToString:@"1"]){
            
            [weakself show:@"提示" andMessage:@"修改密码成功,即将重新登录"];
            
        }else{
            
            [JumpPublicAction showAlert:@"提示" andMessage:@"修改密码失败" window:weakself.view.window];
            
        }
        
        weakself.sureBtn.enabled = YES;
        
        weakself.indicator.hidden = YES;
        
        [weakself.indicator stopAnimation:nil];
        
    } andFailed:^(id error) {
        
        weakself.sureBtn.enabled = YES;
        
        weakself.indicator.hidden = YES;
        
        [weakself.indicator stopAnimation:nil];
        
        [JumpPublicAction showAlert:@"提示" andMessage:@"请求服务器失败" window:weakself.view.window];
        
    }];
    
}




#pragma mark --- 提示框

-(void)show:(NSString *)title andMessage:(NSString *)message{
    
    NSAlert *alert = [[NSAlert alloc]init];
    
    alert.messageText = title;
    
    alert.informativeText = message;
    
    //设置提示框的样式
    alert.alertStyle = NSAlertStyleWarning;
    
    [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
        
        [self.loginWc.window orderFront:nil];//显示要跳转的窗口
        [self.loginWc.window center];//显示在屏幕中间
        [self.mainWc orderOut:nil];//关闭主页面窗口
        
        
    }];
}


//初始化加载动画

-(void)initShow{
    
    self.indicator = [[NSProgressIndicator alloc]initWithFrame:CGRectMake(300, 400, 40, 40)];
    
    self.indicator.style = NSProgressIndicatorSpinningStyle;
    
    self.indicator.controlSize = NSControlSizeRegular;
    
    [self.indicator sizeToFit];
    
    [self.view.window.contentView addSubview:self.indicator];
    
    self.indicator.hidden = YES;
}

//退出登录

- (IBAction)loginOut:(NSButton *)sender {
    
    [self.alert beginSheetModalForWindow:self.mainWc completionHandler:^(NSModalResponse returnCode) {
        
        if(returnCode == 1000){
            
            [self loginOutAction];
        }
        
    }];
}



-(void)loginOutAction{
    
    L2CWeakSelf(self);
    
    [self.timer invalidate];
    
    self.timer = nil;
    
    [AFNHelper macPost:Macvpn_LoginOut parameters:nil success:^(id responseObject) {
        
        [weakself.loginWc.window orderFront:nil];//显示要跳转的窗口
        
        [[weakself.loginWc window] center];//显示在屏幕中间
        
        [weakself.mainWc orderOut:nil];//关闭当前窗口
        
    } andFailed:^(id error) {
        
        [weakself.loginWc.window orderFront:nil];//显示要跳转的窗口
        
        [[weakself.loginWc window] center];//显示在屏幕中间
        
        [weakself.mainWc orderOut:nil];//关闭当前窗口
        
    }];
}

@end
