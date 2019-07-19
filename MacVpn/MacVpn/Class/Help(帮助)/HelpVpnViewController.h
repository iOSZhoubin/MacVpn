//
//  HelpVpnViewController.h
//  MacVpn
//
//  Created by jumpapp1 on 2019/7/19.
//  Copyright © 2019年 zb. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelpVpnViewController : NSViewController

//主window，需要关闭然后跳转到登录界面
@property (strong,nonatomic) NSWindow *mainWc;

@property (strong,nonatomic) NSTimer *timer;


@end

NS_ASSUME_NONNULL_END
