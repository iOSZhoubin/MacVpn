//
//  ChangePwordWindowController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/20.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "ChangePwordWindowController.h"
#import "MainWindowController.h"

@interface ChangePwordWindowController ()

//登录界面
@property (strong,nonatomic) MainWindowController *loginWc;

//0-失败 1-成功
@property (copy,nonatomic) NSString *isSuccess;

@end

@implementation ChangePwordWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [self.window setContentSize:NSMakeSize(500, 400)];
    
    self.window.restorable = NO;
    
    self.loginWc = [[MainWindowController alloc]initWithWindowNibName:@"MainWindowController"];

}

#pragma mark --- 确定

- (IBAction)sureAction:(NSButton *)sender {
    
    [self show:@"提示" andMessage:@"修改密码成功,即将重新登录"];
    
    self.isSuccess = @"1";
}

#pragma mark --- 提示框

-(void)show:(NSString *)title andMessage:(NSString *)message{
    
    NSAlert *alert = [[NSAlert alloc]init];
    
    alert.messageText = title;
    
    alert.informativeText = message;
    
    //设置提示框的样式
    alert.alertStyle = NSAlertStyleWarning;
    
    [alert beginSheetModalForWindow:self.window completionHandler:^(NSModalResponse returnCode) {
        
        if([self.isSuccess isEqualToString:@"1"]){
            
            [self.loginWc.window orderFront:nil];//显示要跳转的窗口
            [self.loginWc.window center];//显示在屏幕中间
            [self.window orderOut:nil];//关闭修改密码窗口
            [self.mainWc orderOut:nil];//关闭主页面窗口
            
        }
    }];
}

@end
