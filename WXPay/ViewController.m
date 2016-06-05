//
//  ViewController.m
//  WXPay
//
//  Created by 曲天白 on 16/6/5.
//  Copyright © 2016年 曲天白. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)payAction{
    [NetWorkTool dingiD:[self generateTradeNO] success:^(NSDictionary *responseObject) {
        /** appid */
        NSString *appid           = responseObject[@"result"][@"appid"];
        /** 商家向财付通申请的商家id */
        NSString *partnerId       = responseObject[@"result"][@"partnerid"];
        /** 预支付订单 */
        NSString *prepayId        = responseObject[@"result"][@"prepayid"];
        /** 随机串，防重发 */
        NSString *nonceStr        = responseObject[@"result"][@"noncestr"];
        /** 时间戳，防重发 */
        NSString *timeStamp       = responseObject[@"result"][@"timestamp"];
        /** 商家根据财付通文档填写的数据和签名 */
        NSString *package         = responseObject[@"result"][@"package"];
        /** 商家根据微信开放平台文档对数据做的签名 */
        NSString *sign            = responseObject[@"result"][@"sign"];
        
        
        //生成URLscheme
        NSString *str = [NSString stringWithFormat:@"weixin://app/%@/pay/?nonceStr=%@&package=Sign%%3DWXPay&partnerId=%@&prepayId=%@&timeStamp=%@&sign=%@&signType=SHA1",appid,nonceStr,partnerId,prepayId,[NSString stringWithFormat:@"%d",[timeStamp intValue] ],sign];
        
        
//        NSString *str = [NSString stringWithFormat:@"weixin://app/%@/pay/?nonceStr=%@&package=Sign%%3DWXPay&partnerId=%@&prepayId=%@&timeStamp=%@&sign=%@&signType=SHA1",responseObject[@"result"][@"appid"],responseObject[@"result"][@"noncestr"],responseObject[@"result"][@"partnerid"],responseObject[@"result"][@"prepayid"],[NSString stringWithFormat:@"%d",[responseObject[@"result"][@"timestamp"] intValue]],responseObject[@"result"][@"sign"]];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
   
    
}

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}




-(void)viewDidAppear:(BOOL)animated{
    [self payAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
