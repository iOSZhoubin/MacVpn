//
//  JumpPublicAction.h
//  MacOSJump
//
//  Created by jumpapp1 on 2019/4/18.
//  Copyright © 2019年 zb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JumpPublicAction : NSObject

//获取设备wifi的ip地址
+(NSString *)getDeviceIPAddress;

//获取设备的Mac地址
+(NSString *)getDeviceMacAddress;

//密码转为MD5
+(NSString *)md5:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
