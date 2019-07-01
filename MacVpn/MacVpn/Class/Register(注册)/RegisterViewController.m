//
//  RegisterViewController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/7/1.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

/** 用户名 */
@property (weak) IBOutlet NSTextField *account;
/** 密码 */
@property (weak) IBOutlet NSSecureTextField *password;
/** 确认密码 */
@property (weak) IBOutlet NSSecureTextField *againPsw;
/** 确认按钮 */
@property (weak) IBOutlet NSButton *registerBtn;
//加载
@property (strong,nonatomic) NSProgressIndicator *indicator;

@end

@implementation RegisterViewController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [self.window setContentSize:NSMakeSize(500, 400)];
    
    self.window.restorable = NO;
    
    [self initShow];
}


#pragma mark --- 注册方法

- (IBAction)registerAction:(NSButton *)sender {
    
    if(self.account.stringValue.length < 1){
        
        [self show:@"提示" andMessage:@"请输入用户名"];
        
        return;
        
    }else if (self.password.stringValue.length < 1){
        
        [self show:@"提示" andMessage:@"请设置密码"];
        
        return;
        
    }else if (self.againPsw.stringValue.length < 1){
        
        [self show:@"提示" andMessage:@"请再次输入密码"];
        
        return;
    }
    
    if(![self.password.stringValue isEqualToString:self.againPsw.stringValue]){
        
        [self show:@"提示" andMessage:@"两次输入的密码不一致，请重新输入"];
        
        return;
    }
    

    
    [self registerAccount];
    
}


-(void)registerAccount{
    
//    self.indicator.hidden = NO;
//
//    [self.indicator startAnimation:nil];
//
//    self.registerBtn.enabled = NO;
//
//    L2CWeakSelf(self);
//
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//
//    parameters[@"inputname"] = SafeString(self.account.stringValue);
//    parameters[@"inputpwd"] = SafeString(self.password.stringValue);
//
//    [AFNHelper macPost:Macvpn_Register parameters:parameters success:^(id responseObject) {
//
//        NSDictionary *dict = responseObject;
//
//        NSString *message = SafeString(dict[@"result"][@"message"]);
//
//        if([dict[@"result"][@"result"] isEqualToString:@"1"]){
//
//            NSAlert *alert = [[NSAlert alloc]init];
//
//            alert.messageText = @"提示";
//
//            alert.informativeText = @"注册信息已提交,等待管理员审批";
//
//            //设置提示框的样式
//            alert.alertStyle = NSAlertStyleWarning;
//
//            [alert beginSheetModalForWindow:self.window completionHandler:^(NSModalResponse returnCode) {
//
//                [weakself.window orderOut:nil];//关闭当前窗口
//
//            }];
//
//        }else{
//
//            [weakself show:@"提示" andMessage:message];
//
//        }
//
//        weakself.indicator.hidden = YES;
//
//        [weakself.indicator stopAnimation:nil];
//
//        weakself.registerBtn.enabled = YES;
//
//    } andFailed:^(id error) {
//
//        [weakself show:@"提示" andMessage:@"请求服务器失败"];
//
//        weakself.indicator.hidden = YES;
//
//        [weakself.indicator stopAnimation:nil];
//
//        weakself.registerBtn.enabled = YES;
//    }];
    
    
    NSAlert *alert = [[NSAlert alloc]init];
    
    alert.messageText = @"提示";
    
    alert.informativeText = @"注册信息已提交,等待管理员审批";
    
    //设置提示框的样式
    alert.alertStyle = NSAlertStyleWarning;
    
    [alert beginSheetModalForWindow:self.window completionHandler:^(NSModalResponse returnCode) {
        
        [self.window orderOut:nil];//关闭当前窗口
        
    }];
}


/**
 提示
 
 @param title 名称
 @param message 提示内容
 */
-(void)show:(NSString *)title andMessage:(NSString *)message{
    
    NSAlert *alert = [[NSAlert alloc]init];
    
    alert.messageText = title;
    
    alert.informativeText = message;
    
    //设置提示框的样式
    alert.alertStyle = NSAlertStyleWarning;
    
    [alert beginSheetModalForWindow:self.window completionHandler:nil];
    
}


//初始化加载动画

-(void)initShow{
    
    self.indicator = [[NSProgressIndicator alloc]initWithFrame:CGRectMake(230, 200, 40, 40)];
    
    self.indicator.style = NSProgressIndicatorSpinningStyle;
    
    self.indicator.controlSize = NSControlSizeRegular;
    
    [self.indicator sizeToFit];
    
    [self.window.contentView addSubview:self.indicator];
    
    self.indicator.hidden = YES;
}


@end
