//
//  SecurityNSString.h
//  Jump
//
//  Created by jumpapp1 on 2018/12/24.
//  Copyright © 2018年 zb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityNSString : NSObject

/**
 若字符串为 nil 则返回 @""
 避免 字符串 为空
 */
+ (NSString *)safeStr:(NSString *)string;

@end
