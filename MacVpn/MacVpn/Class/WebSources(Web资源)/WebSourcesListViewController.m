//
//  WebSourcesListViewController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/7/16.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "WebSourcesListViewController.h"
#import "WeblistSourcesViewCell.h"
#import "WebSourcesModel.h"

@interface WebSourcesListViewController ()<NSTableViewDelegate,NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;
//无数据显示
@property (weak) IBOutlet NSTextField *noWebsources;
//刷新按钮
@property (weak) IBOutlet NSButton *refreshBtn;
//数据源
@property (strong,nonatomic) NSMutableArray *dataArray;
//加载动画
@property (strong,nonatomic) NSProgressIndicator *indicator;
//只在点击刷新时展示提示信息
@property (assign,nonatomic) BOOL showAlert;

@end

@implementation WebSourcesListViewController

-(NSMutableArray *)dataArray{
    
    if(!_dataArray){
        
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[[NSNib alloc] initWithNibNamed:@"WeblistSourcesViewCell" bundle:nil] forIdentifier:@"WeblistSourcesViewCell"];
    
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
    
    return 70;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    WeblistSourcesViewCell *cellView = [tableView makeViewWithIdentifier:@"WeblistSourcesViewCell" owner:self];
    
    WebSourcesModel *model = self.dataArray[row];
    
    [cellView refreshWithWebModel:model];
    
    return cellView;
}

//单击某一行
- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    
    NSTableView *tableView = notification.object;

    NSInteger selectRow = tableView.selectedRow;

    if(selectRow >= 0){
        
        WebSourcesModel *model = self.dataArray[selectRow];

        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:model.res_url]];

        //拷贝链接地址
        NSPasteboard *aPasteboard = [NSPasteboard generalPasteboard]; //获取粘贴板对象

        [aPasteboard clearContents]; //清空粘贴板之前的内容

        NSData *aData = [model.res_url dataUsingEncoding:NSUTF8StringEncoding];

        [aPasteboard setData:aData forType:NSPasteboardTypeString];

        [JumpPublicAction showAlert:@"提示" andMessage:@"链接地址已拷贝，如未响应可打开浏览器粘贴进行访问" window:self.view.window];
        
    }

    JumpLog(@"点击了第%ld行",selectRow);
}

#pragma mark --- 请求列表数据

-(void)loadIpsourceList{
    
    JumpLog(@"请求数据");
    
    L2CWeakSelf(self);
    
    [AFNHelper macPost:Macvpn_WebList parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = responseObject;
        
        JumpLog(@"%@",dict);
        
        if([SafeString(dict[@"message"]) isEqualToString:@"error"]){
            
            [JumpPublicAction showAlert:@"提示" andMessage:@"会话已超时，请重新登录" window:weakself.view.window];
            
        }else{
            
            NSArray *array = dict[@"result"];
            
            weakself.dataArray  = [WebSourcesModel mj_objectArrayWithKeyValuesArray:array];
            
            if(weakself.showAlert == YES){
                
                if(weakself.dataArray.count > 0){
                    
                    [JumpPublicAction showAlert:@"提示" andMessage:@"加载数据成功" window:weakself.view.window];
                    
                }else{
                    
                    [JumpPublicAction showAlert:@"提示" andMessage:@"暂未查询到数据" window:weakself.view.window];
                }
            }
            
            if(weakself.dataArray.count > 0){
                
                weakself.noWebsources.hidden = YES;
                
            }else{
                
                weakself.noWebsources.hidden = NO;
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

- (IBAction)refreshAction:(NSButton *)sender {
    
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
