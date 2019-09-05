//
//  MessageViewController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/17.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "MessageViewController.h"
#import "CustomMessageCellView.h"
#import "MessageModel.h"

@interface MessageViewController ()<NSTableViewDelegate,NSTableViewDataSource>

//无数据
@property (weak) IBOutlet NSTextField *noMessage;
//刷新按钮
@property (weak) IBOutlet NSButton *refreshBtn;
//tableview
@property (weak) IBOutlet NSTableView *tableView;
//数据源
@property (strong,nonatomic) NSMutableArray *dataArray;
//加载动画
@property (strong,nonatomic) NSProgressIndicator *indicator;
//是否显示提示信息
@property (assign,nonatomic) BOOL showAlert;//回到主界面

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
    
    MessageModel *model = self.dataArray[row];
    
    [cellView refreshWithModel:model];
    
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
        
        if([SafeString(dict[@"message"]) isEqualToString:@"error"]){
            
            [JumpPublicAction showAlert:@"提示" andMessage:@"会话已超时，请重新登录" window:weakself.view.window];

        }else{
            
            NSArray *array = dict[@"result"];
            
            weakself.dataArray  = [MessageModel mj_objectArrayWithKeyValuesArray:array];

            if(weakself.showAlert == YES){
                
                if(weakself.dataArray.count > 0){
                    
                    [JumpPublicAction showAlert:@"提示" andMessage:@"加载数据成功" window:weakself.view.window];
                    
                }else{
                    
                    [JumpPublicAction showAlert:@"提示" andMessage:@"暂未查询到数据" window:weakself.view.window];
                    
                }
            }
            
            if(weakself.dataArray.count > 0){
                
                weakself.noMessage.hidden = YES;
                
            }else{
                
                weakself.noMessage.hidden = NO;
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

            [JumpPublicAction showAlert:@"提示" andMessage:@"请求服务器失败" window:weakself.view.window];

        }
    }];
      
}





@end
