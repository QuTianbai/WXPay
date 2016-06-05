//
//  AppDelegate.m
//  1yqb
//
//  Created by 曲天白 on 15/12/11.
//  Copyright © 2015年 乙科网络. All rights reserved.
//

#import "NetWorkTool.h"


@implementation NetWorkTool

//将NSDictionary中的Null类型的项目转化成@""
+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self changeType:obj];
        
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

//将NSArray中的Null类型的项目转化成@""
+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self changeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}

//将NSString类型的原路返回
+(NSString *)stringToString:(NSString *)string
{
    return string;
}

//将Null类型的项目转化成@""
+(NSString *)nullToString
{
    return @"";
}

#pragma mark - 公有方法
//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self nullToString];
    }
    else
    {
        return myObj;
    }
}
/**
 *  数组转json
 *
 *  @param arr 数组
 *
 *  @return 数组json
 */
+ (NSString *)NSArrayTojson:(NSArray *)arr{
    NSError *parseError   = nil;
    
    NSData *jsonData      = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
/**
 *  json 转 字典
 *
 *  @param jsonStr json
 *
 *  @return 数组
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonStr{
    if (jsonStr == nil) {
        return nil;
    }
    NSData *jsonData      = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic     = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    return dic;
}
/**
 * 字典转json
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic {
    
    NSError *parseError   = nil;
    
    NSData *jsonData      = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
/**
 *  json 转 数组
 *
 *  @param jsonStr json
 *
 *  @return 数组
 */
+(NSArray *)arrayWithjsonString:(NSString *)jsonStr{
    if (jsonStr == nil) {
        return nil;
    }
    NSData *jsonData      = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSArray *arr          = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    return arr;
}
/**
 *  便利加载网络图片
 *
 *  @param imagV       图片容器
 *  @param imageUrlStr 图片地址字符串
 */

/**
 * 异步网络请求数据
 * @param：网络请求参数字典
 * @success：请求成功回调代码块
 * @fail:请求失败回调代码块
 */
+(void)asyncNetworkingUrl:(NSString *)url andDict:(NSDictionary *)param
                      success:(void (^)(NSDictionary *responseObject))success
                      failure:(void (^)(NSError *error))failure{
    
    //请求管理者
    AFHTTPRequestOperationManager *mgr    = [AFHTTPRequestOperationManager manager];
    
    //修改afn 支持新浪返回的JSON结构
    mgr.requestSerializer                 = [AFHTTPRequestSerializer serializer ];
    mgr.responseSerializer                = [AFJSONResponseSerializer serializer];
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 8;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",@"http://www.jujiehun.com",url];
    NSLog(@"请求的网络地址%@",urlStr);
    //发送请求
    [mgr POST:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        
        //        NSLog(@"%@",responseObject);
        //数据保护
        if (responseObject != nil) {
            NSLog(@"获取成功");
            dispatch_async(dispatch_get_main_queue(), ^{
                success([self changeType:responseObject]); //成功回调
             });
            
            return ;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取失败");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(error);//失败回调
        });
    
    }];
}
+(void)dingiD:(NSString *)mobile  success:(void (^)(NSDictionary *responseObject))success
      failure:(void (^)(NSError *error))failure{
    NSMutableDictionary*dic = [[NSMutableDictionary alloc]initWithCapacity:1];
    dic[@"package_detail"] = @"描述";
    dic[@"order_id"] = mobile;
    dic[@"total_pay"] = @"1";
    [self asyncNetworkingUrl:@"/pay/wx_new/example/makeorder.php?" andDict:dic success:success failure:failure];
}

@end
