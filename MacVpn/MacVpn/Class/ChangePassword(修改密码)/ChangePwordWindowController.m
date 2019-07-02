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
//原始密码
@property (weak) IBOutlet NSSecureTextField *oldPassword;
//新密码
@property (weak) IBOutlet NSSecureTextField *newsPassword;
//确认密码
@property (weak) IBOutlet NSSecureTextField *againpassword;
//确认按钮
@property (weak) IBOutlet NSButton *sureBtn;

@property (strong,nonatomic) NSProgressIndicator *indicator;

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
            
            [JumpPublicAction showAlert:@"提示" andMessage:@"修改密码失败" window:weakself.window];

        }
        
        weakself.sureBtn.enabled = YES;
        
        weakself.indicator.hidden = YES;
        
        [weakself.indicator stopAnimation:nil];
        
    } andFailed:^(id error) {
        
        weakself.sureBtn.enabled = YES;
        
        weakself.indicator.hidden = YES;
        
        [weakself.indicator stopAnimation:nil];
        
        [JumpPublicAction showAlert:@"提示" andMessage:@"请求服务器失败" window:weakself.window];

    }];
    
}




#pragma mark --- 提示框

-(void)show:(NSString *)title andMessage:(NSString *)message{
    
    NSAlert *alert = [[NSAlert alloc]init];
    
    alert.messageText = title;
    
    alert.informativeText = message;
    
    //设置提示框的样式
    alert.alertStyle = NSAlertStyleWarning;
    
    [alert beginSheetModalForWindow:self.window completionHandler:^(NSModalResponse returnCode) {
     
        [self.loginWc.window orderFront:nil];//显示要跳转的窗口
        [self.loginWc.window center];//显示在屏幕中间
        [self.window orderOut:nil];//关闭修改密码窗口
        [self.mainWc orderOut:nil];//关闭主页面窗口
            
        
    }];
}


//初始化加载动画

-(void)initShow{
    
    self.indicator = [[NSProgressIndicator alloc]initWithFrame:CGRectMake(300, 400, 40, 40)];
    
    self.indicator.style = NSProgressIndicatorSpinningStyle;
    
    self.indicator.controlSize = NSControlSizeRegular;
    
    [self.indicator sizeToFit];
    
    [self.window.contentView addSubview:self.indicator];
    
    self.indicator.hidden = YES;
}

@end
