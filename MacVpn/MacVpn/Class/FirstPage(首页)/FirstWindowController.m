//
//  FirstWindowController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/14.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "FirstWindowController.h"
#import "InternetViewController.h"

@interface FirstWindowController ()

@property (strong,nonatomic) InternetViewController *internerVc;

@end

@implementation FirstWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.internerVc = [[InternetViewController alloc]initWithNibName:@"InternetViewController" bundle:nil];
    
    [self.window setContentView:self.internerVc.view];
    
}

@end
