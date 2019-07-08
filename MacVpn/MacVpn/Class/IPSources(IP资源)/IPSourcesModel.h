//
//  IPSourcesModel.h
//  MacVpn
//
//  Created by jumpapp1 on 2019/7/8.
//  Copyright © 2019年 zb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IPSourcesModel : NSObject

//名称
@property (copy,nonatomic) NSString *resource_name;
//ip地址
@property (copy,nonatomic) NSString *ip;
//端口号
@property (copy,nonatomic) NSString *port;
//网络类型
@property (copy,nonatomic) NSString *ip_type;

@end

NS_ASSUME_NONNULL_END
