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



- (IBAction)refreshMessage:(NSButton *)sender {
    
    JumpLog(@"获取消息数据");
}


@end
