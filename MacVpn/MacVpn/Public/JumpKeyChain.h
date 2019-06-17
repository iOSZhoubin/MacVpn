//
//  JumpKeyChain.h
//  Jump
//
//  Created by jumpapp1 on 2018/12/13.
//  Copyright © 2018年 zb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JumpKeyChain : NSObject

/**
 通过可以来查找对应的值

 @param key 对应的key值
 @return value
 */
+ (id)getKeychainDataForKey:(NSString *)key;

/**
 保存到keychain中

 @param data 需要保存的数据
 @param key 对应的key
 */
+ (void)addKeychainData:(id)data forKey:(NSString *)key;

/**
 从keychain中删除key所对应的值

 @param key 需要删除的key
 */
+ (void)deleteKeychainDataForKey:(NSString *)key;

/**
 增加共享值

 @param data 需要保存的数据
 @param key 对应的key值
 */
+ (void)addShareKeyChainData:(id)data forKey:(NSString *)key;

/**
 * 获取UUID的方法
 */
+ (NSString *)getUUID;


/**
 * 从Keychain获取UUID的方法
 */
+ (NSString *)firstGetUUIDInKeychain;


/**
 * 获取到UUID后存入系统中的keychain中，保证以后每次可以得到相同的唯一标志
 * 不用添加plist文件，当程序删除后重装，仍可以得到相同的唯一标示
 * 但是当系统升级或者刷机后，系统中的钥匙串会被清空，再次获取的UUID会与之前的不同
 * @return keychain中存储的UUID
 */
+ (NSString *)getUUIDInKeychain;

/**
 * 删除存储在keychain中的UUID
 * 如果删除后，重新获取用户的UUID会与之前的UUID不同
 * 一般不删只替换
 */
+ (void)deleteKeyChain;


@end
