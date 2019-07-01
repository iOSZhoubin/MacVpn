//
//  IPSourcesViewController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/24.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "IPSourcesViewController.h"
#import "ResourcesCellView.h"

@interface IPSourcesViewController ()<NSTableViewDelegate,NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;
//数据源
@property (strong,nonatomic) NSMutableArray *dataArray;

@property (strong,nonatomic) NSProgressIndicator *indicator;

@end

@implementation IPSourcesViewController


-(NSMutableArray *)dataArray{
    
    if(!_dataArray){
        
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[[NSNib alloc] initWithNibNamed:@"ResourcesCellView" bundle:nil] forIdentifier:@"ResourcesCellView"];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self initShow];
}


#pragma mark ---  NSTableViewDelegate,NSTableViewDataSource

//返回行数
-(NSInteger) numberOfRowsInTableView:(NSTableView *)tableView{
    
    return 3;
}

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    
    return 95;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    ResourcesCellView *cellView = [tableView makeViewWithIdentifier:@"ResourcesCellView" owner:self];
    
    NSDictionary *dict;
    
    [cellView refreshWithDict:dict];
    
    return cellView;
}

//单击某一行
- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    
    NSTableView *tableView = notification.object;
    
    NSInteger selectRow = tableView.selectedRow;
    
    if(selectRow >= 0){
        
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    }

    JumpLog(@"点击了第%ld行",selectRow);
}

#pragma mark --- 请求列表数据

-(void)loadIpsourceList{
    
    JumpLog(@"请求数据");
    //    [JumpPublicAction showAlert:@"提示" andMessage:@"请输入描述" window:self.view.window];

}



#pragma mark --- 刷新

- (IBAction)refreshIpSource:(NSButton *)sender {
    
    self.indicator.hidden = NO;
    
    [self.indicator startAnimation:nil];
    
    [self loadIpsourceList];
}


//初始化加载动画

-(void)initShow{
    
    self.indicator = [[NSProgressIndicator alloc]initWithFrame:CGRectMake(280, 400, 40, 40)];
    
    self.indicator.style = NSProgressIndicatorSpinningStyle;
    
    self.indicator.controlSize = NSControlSizeRegular;
    
    [self.indicator sizeToFit];
    
    [self.view addSubview:self.indicator];
    
    self.indicator.hidden = YES;
}

@end
