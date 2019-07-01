//
//  InternetViewController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/17.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "InternetViewController.h"

@interface InternetViewController ()

//显示名称
@property (weak) IBOutlet NSTextField *name;
//ip地址
@property (weak) IBOutlet NSTextField *ip;
//帐户
@property (weak) IBOutlet NSTextField *account;
//密码
@property (weak) IBOutlet NSTextField *password;
//秘钥
@property (weak) IBOutlet NSTextField *passKey;

@end

@implementation InternetViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}


#pragma mark --- 生成配置文件

- (IBAction)setFile:(NSButton *)sender {
    
    if(SafeString(self.name.stringValue).length < 1){
        
        [JumpPublicAction showAlert:@"提示" andMessage:@"请输入描述" window:self.view.window];

        return;
    
    }else if (SafeString(self.ip.stringValue).length < 1){
        
        [JumpPublicAction showAlert:@"提示" andMessage:@"请输入服务器" window:self.view.window];
        
        return;
        
    }else if (SafeString(self.account.stringValue).length < 1){
        
        [JumpPublicAction showAlert:@"提示" andMessage:@"请输入帐户" window:self.view.window];
        
        return;
        
    }else if (SafeString(self.password.stringValue).length < 1){
        
        [JumpPublicAction showAlert:@"提示" andMessage:@"请输入密码" window:self.view.window];
        
        return;
        
    }
    
    BOOL isright = [self checkmobileconfigField:self.name.stringValue];
    
    if(!isright){
        
        [JumpPublicAction showAlert:@"提示" andMessage:@"描述名称只能由10位汉字、字母、数字组成" window:self.view.window];

        return;
    }
    
//    NSString *urlStr = [NSString stringWithFormat:@"https://%@:%@/createXml.php?p1=%@&p2=%@&p3=%@&p4=%@&p5=%@",SafeString(self.ip.stringValue),SafeString(self.ip.stringValue),SafeString(self.account.stringValue),SafeString(self.password.stringValue),SafeString(self.ip.stringValue),SafeString(self.name.stringValue),SafeString(self.passKey.stringValue)];
//
//    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:urlStr]];
    
    
}

-(BOOL)checkmobileconfigField:(NSString *)mobileconfigField{
    
    NSString *regular = @"^[\u4e00-\u9fa5_a-zA-Z0-9]{1,10}";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regular];
    
    BOOL isMatch = [predicate evaluateWithObject:mobileconfigField];
    
    return isMatch;
}

@end
