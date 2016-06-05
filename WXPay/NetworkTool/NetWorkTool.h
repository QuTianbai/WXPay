//
//  AppDelegate.m
//  1yqb
//
//  Created by 曲天白 on 15/12/11.
//  Copyright © 2015年 乙科网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"




#define SERVER_IMAGE @""//图片加载头地址
#define SUCCEED_CODE @"0"  //网络返回成功码
@interface NetWorkTool : NSObject
/**
 *  数组转json
 *
 *  @param arr 数组
 *
 *  @return 数组json
 */
+ (NSString *)NSArrayTojson:(NSArray *)arr;
/**
 *  json 转 字典
 *
 *  @param jsonStr json
 *
 *  @return 数组
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonStr;
/**
 * 字典转json
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
/**
 *  json 转 数组
 *
 *  @param jsonStr json
 *
 *  @return 数组
 */
+(NSArray *)arrayWithjsonString:(NSString *)jsonStr;


+(void)asyncNetworkingUrl:(NSString *)url andDict:(NSDictionary *)param
                  success:(void (^)(NSDictionary *responseObject))success
                  failure:(void (^)(NSError *error))failure;
/**
 *  登录
 *
 *  @param mobile   用户注册手机
 *  @param email    用户注册邮箱
 *  @param password 用户密码
 *  @param success  成功responseObject
 *  @param failure  失败error
 */
+(void)dingiD:(NSString *)mobile  success:(void (^)(NSDictionary *responseObject))success
      failure:(void (^)(NSError *error))failure;

/**
 *  获取用户信息
 *
 *  @param uid     uid
 *  @param success 成功responseObject
 *  @param failure 失败error
 */

@end
