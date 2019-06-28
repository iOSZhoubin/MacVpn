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
    
    [self addFile];
    
}


-(void)addFile{
    
    JumpLog(@"生成文件");

}

@end
