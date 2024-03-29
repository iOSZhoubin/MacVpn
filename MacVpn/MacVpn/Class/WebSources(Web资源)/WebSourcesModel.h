//
//  WebSourcesModel.h
//  MacVpn
//
//  Created by jumpapp1 on 2019/7/16.
//  Copyright © 2019年 zb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebSourcesModel : NSObject

//名称
@property (copy,nonatomic) NSString *res_name;
//ip地址
@property (copy,nonatomic) NSString *res_title;
//端口号
@property (copy,nonatomic) NSString *res_type;
//网络类型
@property (copy,nonatomic) NSString *res_url;


@end

NS_ASSUME_NONNULL_END
