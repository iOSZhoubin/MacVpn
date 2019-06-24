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

@property (weak) IBOutlet NSView *customerView;

@property (weak) IBOutlet NSTextField *webTitle;


@property (strong,nonatomic) IPSourcesViewController *ipVc;
@property (strong,nonatomic) WebSourcesViewController *webVc;

@end

@implementation ResourcesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ipVc = [[IPSourcesViewController alloc]initWithNibName:@"IPSourcesViewController" bundle:nil];
    self.webVc = [[WebSourcesViewController alloc]initWithNibName:@"WebSourcesViewController" bundle:nil];
    
    self.ipVc.view.frame  = [self returnvcFrame];
    self.webVc.view.frame  = [self returnvcFrame];
    
    self.webTitle.hidden = YES;
    
    [self.customerView addSubview:self.ipVc.view];

}



#pragma mark --- ip点击方法

- (IBAction)ipAction:(NSButton *)sender {
    
    self.webTitle.hidden = YES;
    
    [self.ipVc.view removeFromSuperview];
    [self.webVc.view removeFromSuperview];
    
    [self.customerView addSubview:self.ipVc.view];
}

#pragma mark --- web点击方法

- (IBAction)webAction:(NSButton *)sender {
    
    self.webTitle.hidden = NO;
    
    [self.ipVc.view removeFromSuperview];
    [self.webVc.view removeFromSuperview];
    
    [self.customerView addSubview:self.webVc.view];
}


-(NSRect)returnvcFrame{
    
    NSRect rect = CGRectMake(0, 0, self.customerView.frame.size.width, self.customerView.frame.size.height);
    
    return rect;
}
@end
