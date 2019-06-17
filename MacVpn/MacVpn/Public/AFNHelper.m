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
    
    NSString *str = [self parameterStringByDict:parameters];
    
    url = [url stringByAppendingFormat:@"?%@",str];
    
    NSURL *urlStr = [NSURL URLWithString:url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlStr cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{

            if(!error){
                
                NSString *str = [data mj_JSONString];
                
                NSDictionary *dict = [str mj_JSONObject];
                
                JumpLog(@"%@",dict);
                
                success(dict);
                
            }else{
                
                failed(error);
            }
            
        });
  
    }];
    
    [dataTask resume];
}


//POST请求
+(void)macPost:(NSString *)url parameters:(NSDictionary *)parameters success:(SuccessBlock)success andFailed:(FailedBlock)failed{
    
    NSURL *urlStr = [NSURL URLWithString:url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlStr cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    request.HTTPMethod = @"POST";
    
    NSString *body = [self parameterStringByDict:parameters];
    
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    JumpLog(@"%@",url);
    JumpLog(@"%@",parameters);
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{ 
            
            if(!error){
                
                NSString *str = [data mj_JSONString];
                
                NSDictionary *dict = [str mj_JSONObject];
                
                JumpLog(@"%@",dict);
                
                success(dict);
                
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
