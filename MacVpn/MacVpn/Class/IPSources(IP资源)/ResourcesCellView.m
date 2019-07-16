//
//  ResourcesCellView.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/24.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "ResourcesCellView.h"

@interface ResourcesCellView()

//资源名称
@property (weak) IBOutlet NSTextField *name;
//ip地址
@property (weak) IBOutlet NSTextField *ipAddress;
//端口号
@property (weak) IBOutlet NSTextField *port;
//箭头
@property (weak) IBOutlet NSImageView *pushView;

@end

@implementation ResourcesCellView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

//刷新ip资源
-(void)refreshWithIPModel:(IPSourcesModel *)model{

    self.name.stringValue = SafeString(model.resource_name);
    self.ipAddress.stringValue = SafeString(model.ip);
    self.port.stringValue = SafeString(model.port);
    
    if([model.ip_type isEqualToString:@"http"] || [model.ip_type isEqualToString:@"https"]){
        
        self.pushView.hidden = NO;
        
    }else{
        
        self.pushView.hidden = YES;
    }
}

//刷新Web资源
-(void)refreshWithWebModel:(WebSourcesModel *)model{

    self.name.stringValue = SafeString(model.resource_name);
    self.ipAddress.stringValue = SafeString(model.ip);
    self.port.stringValue = SafeString(model.port);
}

@end
