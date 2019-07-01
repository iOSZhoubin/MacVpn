//
//  UserViewController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/17.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "UserViewController.h"
#import "IntroduceViewController.h"
#import "AboutUsViewController.h"

@interface UserViewController ()

//标题
@property (weak) IBOutlet NSTextField *titleName;
//视图view
@property (weak) IBOutlet NSView *customerView;
//功能介绍
@property (strong,nonatomic) IntroduceViewController *introduceVc;
//关于我们
@property (strong,nonatomic) AboutUsViewController *aboutUsVc;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.introduceVc = [[IntroduceViewController alloc]initWithNibName:@"IntroduceViewController" bundle:nil];
    self.aboutUsVc = [[AboutUsViewController alloc]initWithNibName:@"AboutUsViewController" bundle:nil];
   
    self.introduceVc.view.frame  = [self returnvcFrame];
    self.aboutUsVc.view.frame  = [self returnvcFrame];
    
    self.titleName.stringValue = @"功能介绍";

    [self.customerView addSubview:self.introduceVc.view];

}

#pragma mark --- 功能介绍

- (IBAction)introduce:(NSButton *)sender {
    
    [self.introduceVc.view removeFromSuperview];
    [self.aboutUsVc.view removeFromSuperview];

    self.titleName.stringValue = @"功能介绍";

    [self.customerView addSubview:self.introduceVc.view];
}

#pragma mark --- 关于我们

- (IBAction)about:(NSButton *)sender {
    
    [self.introduceVc.view removeFromSuperview];
    [self.aboutUsVc.view removeFromSuperview];
    
    self.titleName.stringValue = @"关于我们";

    [self.customerView addSubview:self.aboutUsVc.view];
}


-(NSRect)returnvcFrame{
    
    NSRect rect = CGRectMake(0, 0, self.customerView.frame.size.width, self.customerView.frame.size.height);
    
    return rect;
}

@end
