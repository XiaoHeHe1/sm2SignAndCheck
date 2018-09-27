//
//  ViewController.m
//  sm2
//
//  Created by yfc on 16/7/11.
//  Copyright © 2016年 yfc. All rights reserved.
//

#import "ViewController.h"
#import"part4.h"
#import "part2.h"

@interface ViewController ()

@end
#define SCREEN_WIDTH_NEW ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT_NEW ([UIScreen mainScreen].bounds.size.height)
@implementation ViewController
//
//说明：openssl可以引用openssl.framework，也可以引用libcrypto.a+libssl.a
//
- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 20, 200, 50)];
//    btn.center = self.view.center;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"点击进行SM2加密解密" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 10;
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 50)];
        //    btn.center = self.view.center;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"点击进行SM2数字签名" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 10;
        btn.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:btn];
        
        [btn addTarget:self action:@selector(sedBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 150, 200, 50)];
        //    btn.center = self.view.center;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"点击进行SM2验证签名" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 10;
        btn.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:btn];
        
        [btn addTarget:self action:@selector(thirdBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

//
//数字签名
//
- (void)sedBtnClicked:(UIButton*)button {
    //    //pdf文档的第一个例子
//        test_part2(sm2_param_fp_256, TYPE_GFp, 256);
    //    //pdf文档的第二个例子
    //    test_part2(sm2_param_f2m_257, TYPE_GF2m, 257);
    
    //实际使用中
//        test_part2(sm2_param_recommand, TYPE_GFp, 256);
//    return;
    
    //用户A的id
//    NSString *userId = @"ALICE123@YAHOO.COM";
//    NSData *userId_data = [userId dataUsingEncoding:NSUTF8StringEncoding];
    NSData *userId_data = [self dataFromHexString:@"1234567887654321"];//改成不能转str的data
    
    NSLog(@"16进制的userId = %@",userId_data);
    //明文
//    NSString *data = @"message digest";
//    NSData *data_data = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data_data =  [self dataFromHexString:@"1111122222"];//改成不能转str的data

    
    NSLog(@"16进制的data = %@",data_data);
    //私钥
    NSString *pa = [@"128B2FA8 BD433C6C 068C8D80 3DFF7979 2A519A55 171B1B65 0C23661D 15897263" stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSData *pa_data = [self dataFromHexString:pa];
    //公钥
    NSString *px_ = [@"D5548C78 25CBB561 50A3506C D57464AF 8A1AE051 9DFAF3C5 8221DC81 0CAF28DD " stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *py_ = [@"92107376 8FE3D59C E54E79A4 9445CF73 FED23086 53702726 4D168946 D479533E" stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSData *px_data = [self dataFromHexString:px_];
    NSData *py_data = [self dataFromHexString:py_];
    
    //签名
    char singResultR[1024];
    char singResultS[1024];
    //传的string
//    sm2Sign([userId UTF8String],[data UTF8String],pa_data.bytes,px_data.bytes,py_data.bytes,singResultR,singResultS);
    //传data
    sm2Sign(userId_data.bytes,userId_data.length ,data_data.bytes, data_data.length,pa_data.bytes,px_data.bytes,py_data.bytes,singResultR,singResultS);

    //签名结果打印
    NSData *Rdata = [[NSData alloc]initWithBytes:singResultR length: 64 ];
    NSLog(@"密文data=%@", Rdata );
    NSLog(@"密文r str=%@",[[NSString alloc]initWithData:Rdata encoding:NSUTF8StringEncoding] );
    
    NSData *Sdata = [[NSData alloc]initWithBytes:singResultS length: 64 ];
    NSLog(@"密文data=%@", Sdata );
    NSLog(@"密文s str=%@",[[NSString alloc]initWithData:Sdata encoding:NSUTF8StringEncoding] );
    
    
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"r=%@,s=%@",[[NSString alloc]initWithData:Rdata encoding:NSUTF8StringEncoding],[[NSString alloc]initWithData:Sdata encoding:NSUTF8StringEncoding]]   delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    

    
}


//签名验证
- (void)thirdBtnClicked:(UIButton*)button {
    //用户A的id
    NSString *userId = @"ALICE123@YAHOO.COM";
    NSData *userId_data = [userId dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"16进制的userId = %@",userId_data);
    //明文
    NSString *data = @"message digest";
    NSData *data_data = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"16进制的data = %@",data_data);
    //公钥
    NSString *px_ = [@"D5548C78 25CBB561 50A3506C D57464AF 8A1AE051 9DFAF3C5 8221DC81 0CAF28DD " stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *py_ = [@"92107376 8FE3D59C E54E79A4 9445CF73 FED23086 53702726 4D168946 D479533E" stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSData *px_data = [self dataFromHexString:px_];
    NSData *py_data = [self dataFromHexString:py_];
    
    //r
    NSString *r = @"077BA4656350DAEEA3656EE042DDECE22D5E8DCA4882CB20080AD26E2CB62E9F";
    NSData *rData = [self dataFromHexString:r];
    //s
    NSString *s = @"2BF329F4AFF86EEE0F924888DDE20BF12A21B638A3B0F1FCA70395C4BE00D0AC";
    NSData *sData = [self dataFromHexString:s];
    
   int result = sm2CheckSign([userId UTF8String],[data UTF8String],px_data.bytes,py_data.bytes,rData.bytes,sData.bytes);

         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%d",result]   delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
 
}

- (void)btnClicked:(UIButton*)button {
    
    {
        //使用固定的公钥加密
        NSString *mingwen = @"123457";
        char miwen[1024];
        sm2JiaMi(sm2_param_recommand, TYPE_GFp, 256, [mingwen UTF8String], miwen);
        //密文前面多个04  在用其他工具对密文解密时需要去掉
        NSData *miwendata =  [[NSData alloc]initWithBytes:miwen length: mingwen.length+32+64 +2];
        NSLog(@"密文data=%@",  miwendata );
    }
    
    {
        //使用自己已知的公钥加密和解密
        
        //本例中的私钥是写死的：sm2_param_d_B[2]
            //"00000000008f8b37dc19d95550fd06c1cacd43fe165f80e3b80242f0c66a733",
            //"00000000008f8b37dc19d95550fd06c1cacd43fe165f80e3b80242f0c66a733",
        //本例中的一个公钥是（使用时去掉空格）：
            //@"F5AB4BCC 007AF4C3 862CF413 57C035AE 090B39B3 A7204E2D E888753E 99EC507A"
            //@"BE394FC1 0F50FC59 F6586DF7 B493150E 5DF7F575 BC1214FE D849E967 D15993FF"
        
        NSString *mingwen = @"123458";
        
        //因为miwen之前设置的是100所以运行后会崩溃，现在改成1024崩溃解除
        char miwen[1024];
        NSString *px_ = [@"83B4A4DE96A4D70F4AAF81826982D748EF22EA28BE9D44DE0A44248A36BB0A07" stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *py_ = [@"E481C0D9EE8A98D4EEB6D6C6D7E74F8E3E707C8A438529492E663CD4373A2F24" stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSData *px_data = [self dataFromHexString:px_];
        NSData *py_data = [self dataFromHexString:py_];
        sm2JiaMiWithPublicKey(sm2_param_recommand, TYPE_GFp, 256, (char*)[mingwen UTF8String], miwen, px_data.bytes, py_data.bytes);
        //密文前面多个04  在用其他工具对密文解密时需要去掉
        NSData *miwendata = [[NSData alloc]initWithBytes:miwen length: mingwen.length+32+64 +2];
        NSLog(@"密文data=%@", miwendata );
        
        
        //解密和加密类似将char数组转成nsdata再转成nsstring
        //手动传入私钥pri_进行解密
        
        char output[100];
        NSString *pri_ = [@"000000000000000000000000000000000000000000000000000000000000000E" stringByReplacingOccurrencesOfString:@" " withString:@""];
        sm2JiemiWithPrivateKey(sm2_param_recommand, TYPE_GFp, 256, miwen, (char*)[pri_ UTF8String], output);
        NSString *mingwenout = [[NSString alloc]initWithCString:output encoding:NSUTF8StringEncoding];
        NSLog(@"---解密后%@---",mingwenout);
    
    
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, button.frame.origin.y + 70, SCREEN_WIDTH_NEW, SCREEN_HEIGHT_NEW - button.frame.origin.y - button.frame.size.height)];
        textView.text = [NSString stringWithFormat:@"加密：\n明文是：%@\n公钥是px:%@ py:%@\n密文是%@",mingwen,px_,py_,miwendata];
        textView.text = [textView.text stringByAppendingFormat:@"\n\n解密：\n明文是：%@",mingwenout];
        
        [self.view addSubview:textView];
}
}
- (NSData *)dataFromHexString:(NSString *)input {
    const char *chars = [input UTF8String];
    int i = 0;
    NSUInteger len = input.length;
    
    NSMutableData *data = [NSMutableData dataWithCapacity:len / 2];
    char byteChars[3] = {'\0','\0','\0'};
    unsigned long wholeByte;
    
    while (i < len) {
        byteChars[0] = chars[i++];
        byteChars[1] = chars[i++];
        wholeByte = strtoul(byteChars, NULL, 16);
        [data appendBytes:&wholeByte length:1];
    }
    return data;
}
@end
