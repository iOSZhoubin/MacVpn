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


-(void)refreshWithDict:(NSDictionary *)dict{
    
//    self.name.stringValue = SafeString(dict[@"resource_name"]);
//    self.ipAddress.stringValue = SafeString(dict[@"ip"]);
//    self.port.stringValue = SafeString(dict[@"port"]);
    
    self.name.stringValue = @"资源123";
    self.ipAddress.stringValue = @"10.0.7.200";
    self.port.stringValue = @"443";
    
    NSString *type = SafeString(dict[@"ip_type"]);
    
    if([type isEqualToString:@"http"] || [type isEqualToString:@"https"]){
        
        self.pushView.hidden = NO;
        
    }else{
        
        self.pushView.hidden = YES;
    }
}

@end
