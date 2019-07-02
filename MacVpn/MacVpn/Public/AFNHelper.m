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


//GET请求
+(void)macGet:(NSString *)url parameters:(NSDictionary *)parameters success:(SuccessBlock)success andFailed:(FailedBlock)failed{
    
    NSDictionary *ipInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"mac_userInfo"];

    NSString *ipAddress = SafeString(ipInfo[@"ipAddress"]);
    
    NSString *port = SafeString(ipInfo[@"port"]);
    
    NSString *str1 = [NSString stringWithFormat:@"http://%@:%@%@",ipAddress,port,url];

    NSString *str = [self parameterStringByDict:parameters];
    
    str1 = [str1 stringByAppendingFormat:@"?%@",str];
    
    NSURL *urlStr = [NSURL URLWithString:str1];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlStr cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{

            if(!error){
                
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
                
            }else{
                
                failed(error);
            }
            
        });
  
    }];
    
    [dataTask resume];
}


//POST请求
+(void)macPost:(NSString *)url parameters:(NSDictionary *)parameters success:(SuccessBlock)success andFailed:(FailedBlock)failed{
    
    NSDictionary *ipInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"mac_userInfo"];

    NSString *ipAddress = SafeString(ipInfo[@"ipAddress"]);
    
    NSString *port = SafeString(ipInfo[@"port"]);
    
    NSString *str = [NSString stringWithFormat:@"https://%@:%@%@",ipAddress,port,url];
    
    NSURL *urlStr = [NSURL URLWithString:str];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlStr cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    request.HTTPMethod = @"POST";
    
    NSString *body = [self parameterStringByDict:parameters];
    
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    JumpLog(@"url == %@",urlStr);
    JumpLog(@"parameters == %@",parameters);
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{ 
            
            if(!error){
                
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
                
            }else{
                
                failed(error);
            }
            
        });

    }];
    
    [dataTask resume];
}



+(NSString *)parameterStringByDict:(NSDictionary *)dict{
    
    NSMutableString *muString = [[NSMutableString alloc]init];
    NSString *str = @"";
    
    if(dict){
        
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            [muString appendFormat:@"%@=%@&",key,obj];
        }];
        
        str = [muString substringToIndex:muString.length-1];
    }
    
    return str;
}




@end
