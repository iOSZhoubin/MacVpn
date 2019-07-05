//
//  AFNHelper.m
//  Jump
//
//  Created by jumpapp1 on 2018/12/13.
//  Copyright © 2018年 zb. All rights reserved.
//

#import "AFNHelper.h"

@implementation AFNHelper

#pragma mark ---- Mac 封装网络请求

//GET请求 - XML
+(void)macGet:(NSString *)url parameters:(NSDictionary *)parameters success:(SuccessBlock)success andFailed:(FailedBlock)failed{

   
    NSDictionary *ipInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"mac_userInfo"];
    
    NSString *ipAddress = SafeString(ipInfo[@"ipAddress"]);
    
    NSString *port = SafeString(ipInfo[@"port"]);
    
    NSString *urlStr = [NSString stringWithFormat:@"https://%@:%@%@",ipAddress,port,url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    JumpLog(@"url == %@",urlStr);
    
    JumpLog(@"parameters == %@",parameters);
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSData *data = responseObject;
            
            NSString *str = [data mj_JSONString];
            
            NSArray *array = [str mj_JSONObject];
            
            NSDictionary *dict;
            
            if([str isEqualToString:@"{\"sessionTimeout\":\"true\"}"]){
                
                dict = @{@"message":@"error"};
                
            }else if(array.count > 0){
                
                dict = @{@"result":array};
                
            }else{
                
                dict = @{@"result":str};
            }
            
            success(dict);
            
            JumpLog(@"%@",dict);
            
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        JumpLog(@"%@",error);

        failed(error);

    }];
   
}


//POST请求
+(void)macPost:(NSString *)url parameters:(NSDictionary *)parameters success:(SuccessBlock)success andFailed:(FailedBlock)failed{
    
    NSDictionary *ipInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"mac_userInfo"];
    
    NSString *ipAddress = SafeString(ipInfo[@"ipAddress"]);
    
    NSString *port = SafeString(ipInfo[@"port"]);
    
    NSString *urlStr = [NSString stringWithFormat:@"https://%@:%@%@",ipAddress,port,url];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = 10.f;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    
    JumpLog(@"url == %@",urlStr);
    JumpLog(@"parameters == %@",parameters);
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSData *data = responseObject;
            
            NSString *str = [data mj_JSONString];
            
            NSArray *array = [str mj_JSONObject];
            
            NSDictionary *dict;
            
            if([str isEqualToString:@"{\"sessionTimeout\":\"true\"}"]){
                
                dict = @{@"message":@"error"};
                
            }else if(array.count > 0){
                
                dict = @{@"result":array};
                
            }else{
                
                dict = @{@"result":str};
            }
            
            success(dict);
            
            JumpLog(@"%@",dict);
            
        });
    
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failed(error);

    }];
    
}


@end



