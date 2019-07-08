//
//  CustomMessageCellView.m
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/24.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "CustomMessageCellView.h"

@interface CustomMessageCellView()

/** 内容 */
@property (weak) IBOutlet NSTextField *content;

/** 标题 */
@property (weak) IBOutlet NSTextField *titleName;

/** 时间 */
@property (weak) IBOutlet NSTextField *timeL;

@end

@implementation CustomMessageCellView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(void)refreshWithModel:(MessageModel *)model{
    
    self.content.stringValue = SafeString(model.content);
    
    self.timeL.stringValue = SafeString(model.issue);
    
    self.titleName.stringValue = SafeString(model.title);
}

@end
