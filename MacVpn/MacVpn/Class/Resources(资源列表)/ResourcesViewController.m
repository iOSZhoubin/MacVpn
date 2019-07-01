//
//  ResourcesViewController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/17.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "ResourcesViewController.h"
#import "IPSourcesViewController.h"
#import "WebSourcesViewController.h"

@interface ResourcesViewController ()

/** 视图view */
@property (weak) IBOutlet NSView *customerView;
/** 标题 */
@property (weak) IBOutlet NSTextField *webTitle;
/** ip资源 */
@property (strong,nonatomic) IPSourcesViewController *ipVc;
/** web资源 */
@property (strong,nonatomic) WebSourcesViewController *webVc;

@end

@implementation ResourcesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ipVc = [[IPSourcesViewController alloc]initWithNibName:@"IPSourcesViewController" bundle:nil];
    self.webVc = [[WebSourcesViewController alloc]initWithNibName:@"WebSourcesViewController" bundle:nil];
    
    NSRect rect1 = CGRectMake(0, 0, self.customerView.frame.size.width, self.customerView.frame.size.height);
    NSRect rect2 = CGRectMake(0, 60, self.customerView.frame.size.width, self.customerView.frame.size.height);

    self.ipVc.view.frame  = rect1;
    self.webVc.view.frame  = rect2;
    
    self.webTitle.stringValue = @"IP 资源";
    
    [self.customerView addSubview:self.ipVc.view];

}



#pragma mark --- ip点击方法

- (IBAction)ipAction:(NSButton *)sender {
    
    self.webTitle.stringValue = @"IP 资源";

    [self.ipVc.view removeFromSuperview];
    [self.webVc.view removeFromSuperview];
    
    
    [self.customerView addSubview:self.ipVc.view];
}

#pragma mark --- web点击方法

- (IBAction)webAction:(NSButton *)sender {
    
    self.webTitle.stringValue = @"Web 资源";

    [self.ipVc.view removeFromSuperview];
    [self.webVc.view removeFromSuperview];
    

    [self.customerView addSubview:self.webVc.view];
}

@end
