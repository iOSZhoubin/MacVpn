//
//  ResourcesViewController.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/17.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "ResourcesViewController.h"
#import "ResourcesCellView.h"

@interface ResourcesViewController ()<NSTableViewDelegate,NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;

//数据源
@property (strong,nonatomic) NSMutableArray *dataArray;

@end

@implementation ResourcesViewController

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
}


#pragma mark ---  NSTableViewDelegate,NSTableViewDataSource

//返回行数
-(NSInteger) numberOfRowsInTableView:(NSTableView *)tableView{
    
    return 10;
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

@end
