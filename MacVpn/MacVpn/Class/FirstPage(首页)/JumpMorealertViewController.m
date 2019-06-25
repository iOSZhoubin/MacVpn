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

@end

@implementation JumpMorealertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginWc = [[MainWindowController alloc]initWithWindowNibName:@"MainWindowController"];
    self.changepWc = [[ChangePwordWindowController alloc]initWithWindowNibName:@"ChangePwordWindowController"];

}

#pragma mark --- 修改密码

- (IBAction)changePassword:(NSButton *)sender {
    
    [self.changepWc.window orderFront:nil];//显示要跳转的窗口
    
    self.changepWc.mainWc = self.mainWc;
    
    [[self.changepWc window] center];//显示在屏幕中间
    
}

#pragma mark --- 退出登录

- (IBAction)loginout:(NSButton *)sender {
    
    [self.loginWc.window orderFront:nil];//显示要跳转的窗口
    
    [[self.loginWc window] center];//显示在屏幕中间
    
    [self.mainWc orderOut:nil];//关闭当前窗口
}
@end
