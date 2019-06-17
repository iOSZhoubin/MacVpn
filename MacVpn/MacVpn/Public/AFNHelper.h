//
//  AFNHelper.h
//  Jump
//
//  Created by jumpapp1 on 2018/12/13.
//  Copyright © 2018年 zb. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void (^SuccessBlock)(id responseObject);
typedef void (^FailedBlock)(id error);

@interface AFNHelper : AFHTTPSessionManager


/**
 get 网络请求
 @param url 连接地址
 @param parameters 参数
 @param success 成功回调
 @param failed 失败回调
 */
+(void)macGet:(NSString *)url parameters:(NSDictionary *)parameters success:(SuccessBlock)success andFailed:(FailedBlock)failed;



/**
 post 网络请求
 @param url 连接地址
 @param parameters 参数
 @param success 成功回调
 @param failed 失败回调
 */
+(void)macPost:(NSString *)url parameters:(NSDictionary *)parameters success:(SuccessBlock)success andFailed:(FailedBlock)failed;







@end
