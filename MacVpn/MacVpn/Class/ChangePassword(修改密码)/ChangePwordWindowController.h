//
//  ChangePwordWindowController.h
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/20.
//  Copyright © 2019年 zb. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangePwordWindowController : NSWindowController

//主window，需要关闭然后跳转到登录界面
@property (strong,nonatomic) NSWindow *mainWc;

@end

NS_ASSUME_NONNULL_END
