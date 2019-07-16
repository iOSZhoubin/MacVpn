//
//  JumpMorealertViewController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/20.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "JumpMorealertViewController.h"
#import "MainWindowController.h"
#import "ChangePwordWindowController.h"

@interface JumpMorealertViewController ()

//登录界面
@property (strong,nonatomic) MainWindowController *loginWc;
//修改密码
@property (strong,nonatomic) ChangePwordWindowController *changepWc;
//用户名
@property (weak) IBOutlet NSTextField *accountL;
//服务器
@property (weak) IBOutlet NSTextField *serverL;

@property (strong,nonatomic) NSAlert *alert;

@end

@implementation JumpMorealertViewController


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
    
    self.loginWc = [[MainWindowController alloc]initWithWindowNibName:@"MainWindowController"];
    self.changepWc = [[ChangePwordWindowController alloc]initWithWindowNibName:@"ChangePwordWindowController"];

    //如果有保存用户名，IP地址和端口号，那么就直接赋值
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"mac_userInfo"];
    
    self.accountL.stringValue = [NSString stringWithFormat:@"用户名：%@",SafeString(userInfo[@"account"])];
    self.serverL.stringValue = [NSString stringWithFormat:@"服务器：%@",SafeString(userInfo[@"ipAddress"])];
}

#pragma mark --- 修改密码

- (IBAction)changePassword:(NSButton *)sender {
    
    [self.changepWc.window orderFront:nil];//显示要跳转的窗口
    
    self.changepWc.mainWc = self.mainWc;
    
    [[self.changepWc window] center];//显示在屏幕中间
    
}

#pragma mark --- 退出登录

- (IBAction)loginout:(NSButton *)sender {

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
