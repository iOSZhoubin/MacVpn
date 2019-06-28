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

@property (weak) IBOutlet NSTableView *tableView;
//数据源
@property (strong,nonatomic) NSMutableArray *dataArray;

@property (strong,nonatomic) NSProgressIndicator *indicator;

@end


@implementation MessageViewController


-(NSMutableArray *)dataArray{
    
    if(!_dataArray){
        
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[[NSNib alloc] initWithNibNamed:@"CustomMessageCellView" bundle:nil] forIdentifier:@"CustomMessageCellView"];

    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self initShow];
}



#pragma mark ---  NSTableViewDelegate,NSTableViewDataSource

//返回行数
-(NSInteger) numberOfRowsInTableView:(NSTableView *)tableView{
    
    return 10;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    CustomMessageCellView *cellView = [tableView makeViewWithIdentifier:@"CustomMessageCellView" owner:self];
    
    cellView.content.stringValue = @"这是一测试的消息123";

    return cellView;
}


//初始化加载动画

-(void)initShow{
    
    self.indicator = [[NSProgressIndicator alloc]initWithFrame:CGRectMake(300, 400, 40, 40)];
    
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
    
    [self.indicator startAnimation:nil];

    [self loadMessageList];
}


#pragma mark --- 获取列表数据

-(void)loadMessageList{
    
//    [JumpPublicAction showAlert:@"提示" andMessage:@"请输入描述" window:self.view.window];

}


@end
