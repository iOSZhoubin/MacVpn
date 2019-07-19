//
//  MainWindowController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/14.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "MainWindowController.h"
#import "loginViewController.h"

@interface MainWindowController ()

@property (strong,nonatomic) loginViewController *loginVc;

@end

@implementation MainWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    AppDelegate *appdelegate = [NSApp delegate];
    
    appdelegate.windowVc = self;

    [self.window setContentSize:NSMakeSize(800, 600)];
    
    self.window.restorable = NO;
    
    self.loginVc = [[loginViewController alloc]initWithNibName:@"loginViewController" bundle:nil];
    
    self.loginVc.mainWC = self.window;
    
    [self.window setContentView:self.loginVc.view];
}



@end
