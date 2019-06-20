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

@interface FirstWindowController ()
@property (weak) IBOutlet NSButton *interBtn;
@property (weak) IBOutlet NSButton *resourceBtn;
@property (weak) IBOutlet NSButton *messageBtn;
@property (weak) IBOutlet NSButton *userBtn;

/** 网络连接 */
@property (strong) IBOutlet InternetViewController *internetVc;
/** 资源列表 */
@property (strong) IBOutlet ResourcesViewController *resourcesVc;
/** 消息中心 */
@property (strong) IBOutlet MessageViewController *messageVc;
/** 个人中心 */
@property (strong) IBOutlet UserViewController *userVc;

@property (weak) IBOutlet NSView *customerView;

//提示框
@property(nonatomic,strong) NSPopover *firstPopover;
//提示框
@property(nonatomic,strong) JumpMorealertViewController *morealertVC;


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
    //注册
    self.internetVc = [[InternetViewController alloc]initWithNibName:@"InternetViewController" bundle:nil];
    
    self.resourcesVc = [[ResourcesViewController alloc]initWithNibName:@"ResourcesViewController" bundle:nil];

    self.messageVc = [[MessageViewController alloc]initWithNibName:@"MessageViewController" bundle:nil];

    self.userVc = [[UserViewController alloc]initWithNibName:@"UserViewController" bundle:nil];

    //设置大小
    self.internetVc.view.frame  = [self returnvcFrame];
    
    self.resourcesVc.view.frame = [self returnvcFrame];

    self.messageVc.view.frame = [self returnvcFrame];

    self.userVc.view.frame = [self returnvcFrame];
    
    [self.window.contentView addSubview:self.internetVc.view];
    
}


#pragma mark --- 网络连接

- (IBAction)internetAction:(NSButton *)sender {
    
    [sender setImage:[NSImage imageNamed:@"home1"]];
    [self.resourceBtn setImage:[NSImage imageNamed:@"sources2"]];
    [self.messageBtn setImage:[NSImage imageNamed:@"message2"]];
    [self.userBtn setImage:[NSImage imageNamed:@"me2"]];

    [self.internetVc.view removeFromSuperview];
    [self.resourcesVc.view removeFromSuperview];
    [self.messageVc.view removeFromSuperview];
    [self.userVc.view removeFromSuperview];

    [self.window.contentView addSubview:self.internetVc.view];
    
}

#pragma mark --- 资源列表

- (IBAction)resourcesAction:(NSButton *)sender {
    
    [sender setImage:[NSImage imageNamed:@"sources1"]];
    [self.interBtn setImage:[NSImage imageNamed:@"home2"]];
    [self.messageBtn setImage:[NSImage imageNamed:@"message2"]];
    [self.userBtn setImage:[NSImage imageNamed:@"me2"]];
    
    [self.internetVc.view removeFromSuperview];
    [self.resourcesVc.view removeFromSuperview];
    [self.messageVc.view removeFromSuperview];
    [self.userVc.view removeFromSuperview];

    [self.window.contentView addSubview:self.resourcesVc.view];

}

#pragma mark --- 消息中心

- (IBAction)messageAction:(NSButton *)sender {
    
    [sender setImage:[NSImage imageNamed:@"message1"]];
    [self.interBtn setImage:[NSImage imageNamed:@"home2"]];
    [self.resourceBtn setImage:[NSImage imageNamed:@"sources2"]];
    [self.userBtn setImage:[NSImage imageNamed:@"me2"]];
    
    [self.internetVc.view removeFromSuperview];
    [self.resourcesVc.view removeFromSuperview];
    [self.messageVc.view removeFromSuperview];
    [self.userVc.view removeFromSuperview];
    

    [self.window.contentView addSubview:self.messageVc.view];
}

#pragma mark --- 个人中心

- (IBAction)userAction:(NSButton *)sender {
    
    [sender setImage:[NSImage imageNamed:@"me1"]];
    [self.interBtn setImage:[NSImage imageNamed:@"home2"]];
    [self.resourceBtn setImage:[NSImage imageNamed:@"sources2"]];
    [self.messageBtn setImage:[NSImage imageNamed:@"message2"]];
    
    [self.internetVc.view removeFromSuperview];
    [self.resourcesVc.view removeFromSuperview];
    [self.messageVc.view removeFromSuperview];
    [self.userVc.view removeFromSuperview];

    [self.window.contentView addSubview:self.userVc.view];
}


#pragma mark --- 更多

- (IBAction)setAction:(NSButton *)sender {
    
    [self.firstPopover showRelativeToRect:sender.frame ofView:self.window.contentView preferredEdge:NSRectEdgeMaxX];

}

-(NSRect)returnvcFrame{
    
    NSRect rect = CGRectMake(self.customerView.frame.origin.x, self.customerView.frame.origin.y, self.customerView.frame.size.width, self.customerView.frame.size.height);

    return rect;
}


@end
