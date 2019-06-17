//
//  SecurityNSString.m
//  Jump
//
//  Created by jumpapp1 on 2018/12/24.
//  Copyright © 2018年 zb. All rights reserved.
//

#import "SecurityNSString.h"

@implementation SecurityNSString


+ (NSString *)safeStr:(NSString *)string{
    
    if (!string) {
        return @"";
    }else{
        return string;
    }
    
}

@end
