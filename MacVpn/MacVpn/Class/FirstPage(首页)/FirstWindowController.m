//
//  FirstWindowController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/14.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "FirstWindowController.h"
#import "InternetViewController.h"
#import "ResourcesViewController.h"
#import "MessageViewController.h"
#import "UserViewController.h"
#import "JumpMorealertViewController.h"
#import "MainWindowController.h"
#import "HelpVpnViewController.h"

@interface FirstWindowController ()

//网络连接
@property (weak) IBOutlet NSButton *interBtn;
//资源列表
@property (weak) IBOutlet NSButton *resourceBtn;
//消息中心
@property (weak) IBOutlet NSButton *messageBtn;
//个人中心
@property (weak) IBOutlet NSButton *userBtn;
//帮助
@property (weak) IBOutlet NSButton *helpBtn;

/** 网络连接 */
@property (strong) IBOutlet InternetViewController *internetVc;
/** 资源列表 */
@property (strong) IBOutlet ResourcesViewController *resourcesVc;
/** 消息中心 */
@property (strong) IBOutlet MessageViewController *messageVc;
/** 个人中心 */
@property (strong) IBOutlet UserViewController *userVc;
/** 帮助 */
@property (strong) IBOutlet HelpVpnViewController *helpVc;

@property (weak) IBOutlet NSView *customerView;

//回到主界面
@property(nonatomic,strong) MainWindowController *loginWc;

//提示框
@property(nonatomic,strong) NSPopover *firstPopover;
//提示框
@property(nonatomic,strong) JumpMorealertViewController *morealertVC;

@property (strong,nonatomic) NSTimer *timer;

@property (assign,nonatomic) NSInteger failNum;

@end

@implementation FirstWindowController


- (NSPopover *)firstPopover
{
    if(!_firstPopover)
    {
        _firstPopover=[[NSPopover alloc]init];
        
        _firstPopover.appearance = [NSAppearance appearanceNamed:NSAppearanceNameAqua];
        
        _firstPopover.contentViewController = self.morealertVC;
        
        _firstPopover.behavior = NSPopoverBehaviorTransient;
        
        _firstPopover.contentSize = NSMakeSize(180, 150);
        
    }
    return _firstPopover;
}

- (JumpMorealertViewController *)morealertVC
{
    if(!_morealertVC)
    {
        _morealertVC = [[JumpMorealertViewController alloc]init];
        
        _morealertVC.mainWc = self.window;
    }
    return _morealertVC;
}


- (void)windowDidLoad {
    [super windowDidLoad];
    
    AppDelegate *appdelegate = [NSApp delegate];
    
    appdelegate.windowVc = self;
    
    //注册
    self.internetVc = [[InternetViewController alloc]initWithNibName:@"InternetViewController" bundle:nil];
    
    self.resourcesVc = [[ResourcesViewController alloc]initWithNibName:@"ResourcesViewController" bundle:nil];
    
    self.messageVc = [[MessageViewController alloc]initWithNibName:@"MessageViewController" bundle:nil];

    self.userVc = [[UserViewController alloc]initWithNibName:@"UserViewController" bundle:nil];

    self.loginWc = [[MainWindowController alloc]initWithWindowNibName:@"MainWindowController"];

    self.helpVc = [[HelpVpnViewController alloc]initWithNibName:@"HelpVpnViewController" bundle:nil];

    self.helpVc.timer = self.timer;

    self.helpVc.mainWc = self.window;
    
    //设置大小
    self.internetVc.view.frame  = [self returnvcFrame];
    
    self.resourcesVc.view.frame = [self returnvcFrame];

    self.messageVc.view.frame = [self returnvcFrame];

    self.userVc.view.frame = [self returnvcFrame];
    
    self.helpVc.view.frame = [self returnvcFrame];

    
    [self.window.contentView addSubview:self.internetVc.view];
    
    self.failNum = 0;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0f  //间隔时间
                                                         target:self
                                                       selector:@selector(longConnect)
                                                       userInfo:nil
                                                        repeats:YES];
    
}


#pragma mark --- 网络连接

- (IBAction)internetAction:(NSButton *)sender {
    
    [sender setImage:[NSImage imageNamed:@"home1"]];
    [self.resourceBtn setImage:[NSImage imageNamed:@"sources2"]];
    [self.messageBtn setImage:[NSImage imageNamed:@"message2"]];
    [self.userBtn setImage:[NSImage imageNamed:@"me2"]];
    [self.helpBtn setImage:[NSImage imageNamed:@"me2"]];

    [self.internetVc.view removeFromSuperview];
    [self.resourcesVc.view removeFromSuperview];
    [self.messageVc.view removeFromSuperview];
    [self.userVc.view removeFromSuperview];
    [self.helpVc.view removeFromSuperview];

    [self.window.contentView addSubview:self.internetVc.view];
    
}

#pragma mark --- 资源列表

- (IBAction)resourcesAction:(NSButton *)sender {
    
    [sender setImage:[NSImage imageNamed:@"sources1"]];
    [self.interBtn setImage:[NSImage imageNamed:@"home2"]];
    [self.messageBtn setImage:[NSImage imageNamed:@"message2"]];
    [self.userBtn setImage:[NSImage imageNamed:@"me2"]];
    [self.helpBtn setImage:[NSImage imageNamed:@"me2"]];

    [self.internetVc.view removeFromSuperview];
    [self.resourcesVc.view removeFromSuperview];
    [self.messageVc.view removeFromSuperview];
    [self.userVc.view removeFromSuperview];
    [self.helpVc.view removeFromSuperview];

    [self.window.contentView addSubview:self.resourcesVc.view];

}

#pragma mark --- 消息中心

- (IBAction)messageAction:(NSButton *)sender {
    
    [sender setImage:[NSImage imageNamed:@"message1"]];
    [self.interBtn setImage:[NSImage imageNamed:@"home2"]];
    [self.resourceBtn setImage:[NSImage imageNamed:@"sources2"]];
    [self.userBtn setImage:[NSImage imageNamed:@"me2"]];
    [self.helpBtn setImage:[NSImage imageNamed:@"me2"]];

    [self.internetVc.view removeFromSuperview];
    [self.resourcesVc.view removeFromSuperview];
    [self.messageVc.view removeFromSuperview];
    [self.userVc.view removeFromSuperview];
    [self.helpVc.view removeFromSuperview];


    [self.window.contentView addSubview:self.messageVc.view];
}

#pragma mark --- 个人中心

- (IBAction)userAction:(NSButton *)sender {
    
    [sender setImage:[NSImage imageNamed:@"me1"]];
    [self.interBtn setImage:[NSImage imageNamed:@"home2"]];
    [self.resourceBtn setImage:[NSImage imageNamed:@"sources2"]];
    [self.messageBtn setImage:[NSImage imageNamed:@"message2"]];
    [self.helpBtn setImage:[NSImage imageNamed:@"me2"]];

    [self.internetVc.view removeFromSuperview];
    [self.resourcesVc.view removeFromSuperview];
    [self.messageVc.view removeFromSuperview];
    [self.userVc.view removeFromSuperview];
    [self.helpVc.view removeFromSuperview];

    [self.window.contentView addSubview:self.userVc.view];
}

#pragma mark --- 帮助

- (IBAction)helpAction:(NSButton *)sender {

    [sender setImage:[NSImage imageNamed:@"me1"]];
    [self.interBtn setImage:[NSImage imageNamed:@"home2"]];
    [self.resourceBtn setImage:[NSImage imageNamed:@"sources2"]];
    [self.messageBtn setImage:[NSImage imageNamed:@"message2"]];
    [self.userBtn setImage:[NSImage imageNamed:@"me2"]];
    
    [self.internetVc.view removeFromSuperview];
    [self.resourcesVc.view removeFromSuperview];
    [self.messageVc.view removeFromSuperview];
    [self.userVc.view removeFromSuperview];
    [self.helpVc.view removeFromSuperview];
    
    [self.window.contentView addSubview:self.helpVc.view];
}

#pragma mark --- 更多

- (IBAction)setAction:(NSButton *)sender {
    
//    self.morealertVC.timer = self.timer;
//
//    [self.firstPopover showRelativeToRect:sender.frame ofView:self.window.contentView preferredEdge:NSRectEdgeMaxX];

}

-(NSRect)returnvcFrame{
    
    NSRect rect = CGRectMake(self.customerView.frame.origin.x, self.customerView.frame.origin.y, self.customerView.frame.size.width, self.customerView.frame.size.height);

    return rect;
}




//心跳连接
-(void)longConnect{
    
    AFHTTPRequestOperationManager *getManger = [AFHTTPRequestOperationManager manager];
    
    getManger.requestSerializer.timeoutInterval = 30;
    
    getManger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    //无条件的信任服务器上的证书
    AFSecurityPolicy *policy =  [AFSecurityPolicy defaultPolicy];
    // 客户端是否信任非法证书
    policy.allowInvalidCertificates = YES;
    // 是否在证书域字段中验证域名
    policy.validatesDomainName = NO;
    
    getManger.securityPolicy = policy;
    
    NSDictionary *dataDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"mac_userInfo"];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"inputname"] = SafeString(dataDict[@"account"]);
    parameters[@"inputpsw"] = SafeString(dataDict[@"password"]);
    parameters[@"login"] = @"1";
    parameters[@"enevs"] = @"login";
    parameters[@"ios"] = @"ios";
    
    L2CWeakSelf(self);
    
    NSDictionary *ipInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"mac_userInfo"];
    
    NSString *ipAddress = SafeString(ipInfo[@"ipAddress"]);
    
    NSString *port = SafeString(ipInfo[@"port"]);
    
    NSString *urlStr = [NSString stringWithFormat:@"https://%@:%@%@",ipAddress,port,Macvpn_heartJump];
    
    [getManger GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"hold_state"] intValue] == 1) {
        
            JumpLog(@"请求心跳成功");
            
            weakself.failNum = 0;
            
        }else{
            
            JumpLog(@"请求心跳失败");

            weakself.failNum ++;
            
            if(weakself.failNum > 2){
                
                [weakself loginOutAlert];
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        JumpLog(@"请求心跳失败");

        weakself.failNum ++;
        
        if(weakself.failNum > 2){
            
            [weakself loginOutAlert];
        }
        
    }];
}


-(void)loginOutAlert{
    
    NSAlert *alert = [[NSAlert alloc]init];
    
    alert.messageText = @"提示";
    
    alert.informativeText = @"会话已超时，请您重新登录";
    
    //设置提示框的样式
    alert.alertStyle = NSAlertStyleWarning;
    
    [self.timer invalidate];
    
    self.timer = nil;
    
    [alert beginSheetModalForWindow:self.window completionHandler:^(NSModalResponse returnCode) {
        
        [self.loginWc.window orderFront:nil];//显示要跳转的窗口
        [self.loginWc.window center];//显示在屏幕中间
        [self.window orderOut:nil];//关闭当前窗口
        
    }];
}


@end
