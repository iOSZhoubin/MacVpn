//
//  CustomMessageCellView.h
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/24.
//  Copyright © 2019年 zb. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomMessageCellView : NSTableCellView

/** 内容 */
@property (weak) IBOutlet NSTextField *content;

/** 标题 */
@property (weak) IBOutlet NSTextField *titleName;

/** 时间 */
@property (weak) IBOutlet NSTextField *timeL;


@end

NS_ASSUME_NONNULL_END
