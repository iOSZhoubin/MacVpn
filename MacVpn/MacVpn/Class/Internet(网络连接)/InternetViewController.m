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
    // Do view setup here.


}


#pragma mark --- 生成配置文件

- (IBAction)setFile:(NSButton *)sender {
    
    JumpLog(@"生成文件");
}

@end
