//
//  WeblistSourcesViewCell.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/7/18.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "WeblistSourcesViewCell.h"

@interface WeblistSourcesViewCell()

//名称
@property (weak) IBOutlet NSTextField *titleName;
//类型
@property (weak) IBOutlet NSTextField *typeL;

@end

@implementation WeblistSourcesViewCell

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

//刷新Web资源
-(void)refreshWithWebModel:(WebSourcesModel *)model{
    
    self.titleName.stringValue = SafeString(model.res_name);
    self.typeL.stringValue = SafeString(model.res_type);
}

@end
