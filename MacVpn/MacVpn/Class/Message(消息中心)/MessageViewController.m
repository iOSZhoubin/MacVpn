//
//  MessageViewController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/17.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "MessageViewController.h"
#import "CustomMessageCellView.h"

@interface MessageViewController ()<NSTableViewDelegate,NSTableViewDataSource>

//刷新按钮
@property (weak) IBOutlet NSButton *refreshBtn;
//tableview
@property (weak) IBOutlet NSTableView *tableView;
//数据源
@property (strong,nonatomic) NSMutableArray *dataArray;

@property (strong,nonatomic) NSProgressIndicator *indicator;

//是否显示提示信息
@property (assign,nonatomic) BOOL showAlert;

@end


@implementation MessageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    
    [self.tableView registerNib:[[NSNib alloc] initWithNibNamed:@"CustomMessageCellView" bundle:nil] forIdentifier:@"CustomMessageCellView"];

    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.showAlert = NO;
    
    [self initShow];
    
    [self loadMessageList];
}



#pragma mark ---  NSTableViewDelegate,NSTableViewDataSource

//返回行数
-(NSInteger) numberOfRowsInTableView:(NSTableView *)tableView{
    
    return self.dataArray.count;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    CustomMessageCellView *cellView = [tableView makeViewWithIdentifier:@"CustomMessageCellView" owner:self];
    
    NSDictionary *dict = self.dataArray[row];

    cellView.content.stringValue = SafeString(dict[@"content"]);
    cellView.timeL.stringValue = SafeString(dict[@"issue"]);
    cellView.titleName.stringValue = SafeString(dict[@"title"]);
    
    return cellView;
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


#pragma mark -- 刷新

- (IBAction)refreshMessage:(NSButton *)sender {
    
    JumpLog(@"获取消息数据");
    
    self.indicator.hidden = NO;
    
    self.refreshBtn.enabled = NO;
    
    self.showAlert = YES;
    
    [self.indicator startAnimation:nil];

    [self loadMessageList];
}


#pragma mark --- 获取列表数据

-(void)loadMessageList{
    
    L2CWeakSelf(self);
    
    [AFNHelper macPost:Macvpn_MessageCenter parameters:nil success:^(id responseObject) {
                
        NSDictionary *dict = responseObject;
        
        if(![SafeString(dict[@"result"]) isEqualToString:@"[]"]){
            
            NSArray *array = dict[@"result"];
            
            JumpLog(@"%@",dict);
            
            weakself.dataArray = array.mutableCopy;
            
        }
        
        if(weakself.showAlert == YES){
            
            if(weakself.dataArray.count > 0){
                
                [JumpPublicAction showAlert:@"提示" andMessage:@"加载数据成功" window:weakself.view.window];
                
            }else{
                
                [JumpPublicAction showAlert:@"提示" andMessage:@"暂未查询到数据" window:weakself.view.window];
            }
        }

        [weakself.tableView reloadData];

        weakself.indicator.hidden = YES;
        
        weakself.refreshBtn.enabled = YES;
        
        [weakself.indicator stopAnimation:nil];
        
    } andFailed:^(id error) {
        
        weakself.indicator.hidden = YES;
        
        weakself.refreshBtn.enabled = YES;
        
        [weakself.indicator stopAnimation:nil];
        
        if(weakself.showAlert == YES){
        
            [JumpPublicAction showAlert:@"提示" andMessage:@"请求服务器失败" window:weakself.view.window];

        }
    }];
}


@end
