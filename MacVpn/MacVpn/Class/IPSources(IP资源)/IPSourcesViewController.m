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

//刷新按钮
@property (weak) IBOutlet NSButton *refreshBtn;
//tableview
@property (weak) IBOutlet NSTableView *tableView;
//数据源
@property (strong,nonatomic) NSMutableArray *dataArray;
//加载动画
@property (strong,nonatomic) NSProgressIndicator *indicator;
//只在点击刷新时展示提示信息
@property (assign,nonatomic) BOOL showAlert;

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
    
    self.showAlert = NO;
    
    [self initShow];
    
    [self loadIpsourceList];
}


#pragma mark ---  NSTableViewDelegate,NSTableViewDataSource

//返回行数
-(NSInteger) numberOfRowsInTableView:(NSTableView *)tableView{
    
    return self.dataArray.count;
}

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    
    return 95;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    ResourcesCellView *cellView = [tableView makeViewWithIdentifier:@"ResourcesCellView" owner:self];
    
    NSDictionary *dict = self.dataArray[row];
    
    [cellView refreshWithDict:dict];
    
    return cellView;
}

//单击某一行
- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    
    NSTableView *tableView = notification.object;
    
    NSInteger selectRow = tableView.selectedRow;
    
    if(selectRow >= 0){
        
        NSString *resourcetype = SafeString(self.dataArray[selectRow][@"ip_type"]);

        if([resourcetype isEqualToString:@"http"] || [resourcetype isEqualToString:@"https"]){

            NSString *ip = SafeString(self.dataArray[selectRow][@"ip"]);

            NSString *port = SafeString(self.dataArray[selectRow][@"port"]);

            NSString *url = [NSString stringWithFormat:@"%@://%@:%@",resourcetype,ip,port];

            [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:url]];

        }
    }

    JumpLog(@"点击了第%ld行",selectRow);
}

#pragma mark --- 请求列表数据

-(void)loadIpsourceList{
    
    JumpLog(@"请求数据");
    
    L2CWeakSelf(self);
    
    [AFNHelper macPost:Macvpn_IPresource parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = responseObject;
        
        NSArray *array = dict[@"result"];
        
        if(array.count > 0){
            
            weakself.dataArray = [NSMutableArray array];
            
            [weakself.dataArray addObjectsFromArray:array];
            
            [weakself.tableView reloadData];
        
        }else{
            
            if(weakself.showAlert == YES){
                
                [JumpPublicAction showAlert:@"提示" andMessage:@"暂无资源" window:self.view.window];
            }
        }
        
        weakself.indicator.hidden = YES;
        
        weakself.refreshBtn.enabled = YES;
        
        [weakself.indicator stopAnimation:nil];
   
    } andFailed:^(id error) {
        
        weakself.indicator.hidden = YES;
        
        weakself.refreshBtn.enabled = YES;
        
        [weakself.indicator stopAnimation:nil];
        
        if(weakself.showAlert == YES){
            
            [JumpPublicAction showAlert:@"提示" andMessage:@"请求服务器失败" window:self.view.window];
        }
        
    }];
}



#pragma mark --- 刷新

- (IBAction)refreshIpSource:(NSButton *)sender {
    
    self.indicator.hidden = NO;
    
    self.showAlert = YES;
    
    self.refreshBtn.enabled = NO;
    
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
