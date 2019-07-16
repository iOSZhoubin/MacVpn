//
//  IPSourcesViewController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/24.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "IPSourcesViewController.h"
#import "ResourcesCellView.h"
#import "IPSourcesModel.h"

@interface IPSourcesViewController ()<NSTableViewDelegate,NSTableViewDataSource>
@property (weak) IBOutlet NSTextField *noSources;

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
    
    IPSourcesModel *model = self.dataArray[row];
    
    [cellView refreshWithModel:model];
    
    return cellView;
}

//单击某一行
- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    
    NSTableView *tableView = notification.object;
    
    NSInteger selectRow = tableView.selectedRow;
    
    if(selectRow >= 0){
        
        IPSourcesModel *model = self.dataArray[selectRow];
        
        if([model.ip_type isEqualToString:@"http"] || [model.ip_type isEqualToString:@"https"]){

            NSString *ip = SafeString(model.ip);

            NSString *port = SafeString(model.port);

            NSString *url = [NSString stringWithFormat:@"%@://%@:%@",model.ip_type,ip,port];

            [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:url]];
            
            //拷贝链接地址
            NSPasteboard *aPasteboard = [NSPasteboard generalPasteboard]; //获取粘贴板对象
            
            [aPasteboard clearContents]; //清空粘贴板之前的内容
            
            NSData *aData = [url dataUsingEncoding:NSUTF8StringEncoding];
            
            [aPasteboard setData:aData forType:NSPasteboardTypeString];
            
            [JumpPublicAction showAlert:@"提示" andMessage:@"链接地址已拷贝，如未响应可打开浏览器粘贴进行访问" window:self.view.window];
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
        
        if([SafeString(dict[@"message"]) isEqualToString:@"error"]){
            
            [JumpPublicAction showAlert:@"提示" andMessage:@"会话已超时，请重新登录" window:weakself.view.window];

        }else{
            
            NSArray *array = dict[@"result"];
            
            weakself.dataArray  = [IPSourcesModel mj_objectArrayWithKeyValuesArray:array];
            
            if(weakself.showAlert == YES){
                
                if(weakself.dataArray.count > 0){
                    
                    [JumpPublicAction showAlert:@"提示" andMessage:@"加载数据成功" window:weakself.view.window];
                    
                }else{
                    
                    [JumpPublicAction showAlert:@"提示" andMessage:@"暂未查询到数据" window:weakself.view.window];
                }
            }
            
            if(weakself.dataArray.count > 0){
                
                weakself.noSources.hidden = YES;
                
            }else{
                
                weakself.noSources.hidden = NO;
            }
            
            [weakself.tableView reloadData];
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
