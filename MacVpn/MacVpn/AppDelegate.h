//
//  AppDelegate.h
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/14.
//  Copyright © 2019年 zb. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CoreData/CoreData.h>
#import "MainWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (strong,nonatomic) MainWindowController *mainWindowC;

@property (strong,nonatomic) NSWindowController *windowVc;


@end

