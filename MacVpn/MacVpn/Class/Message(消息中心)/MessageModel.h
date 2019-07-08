//
//  MessageModel.h
//  MacVpn
//
//  Created by jumpapp1 on 2019/7/8.
//  Copyright © 2019年 zb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : NSObject

//名称
@property (nonatomic,copy) NSString *title;
//内容
@property (nonatomic,copy) NSString *content;
//时间
@property (nonatomic,copy) NSString *issue;

@end

NS_ASSUME_NONNULL_END
