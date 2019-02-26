//
//  ViewController.m
//  TestApp
//
//  Created by luwentao on 2019/2/25.
//  Copyright © 2019年 cmb. All rights reserved.
//

/*
 1.认证无法启动
 LAErrorBiometryNotEnrolled:面容ID未开启，无法启动认证/密码未设置，无法启动认证
 LAErrorBiometryNotAvailable:设备不支持面容ID/App无面容ID使用权限
 
 2.认证失败
 LAErrorUserCancel:用户取消
 LAErrorUserFallback：面容解锁多次失败后，用户选择输入密码
 LAErrorSystemCancel：用户将App切后台
 LAErrorInvalidContext：认证开始前context被设置为无效
 LAErrorAppCancel:认证过程中context被设置成无效
 */
#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()
@property UIButton* btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = CGRectMake(100, 100, 100, 100);
    self.btn = [[UIButton alloc] initWithFrame:rect];
    [self.btn setTitle:@"Touch ID测试" forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(testTouchID) forControlEvents:UIControlEventTouchDown];
    [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:self.btn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)testTouchID{
    LAContext *context = [[LAContext alloc] init];
    //while(YES){
        NSError *error = nil;
        BOOL res = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
        if(!res){
            //LAAutho
            switch(error.code){
                case LAErrorBiometryNotEnrolled:{
                    NSLog(@"1");
                    break;
                }
                case LAErrorBiometryNotAvailable:{
                    NSLog(@"2");
                    break;
                }
                case LAErrorPasscodeNotSet:{
                    NSLog(@"3");
                    break;
                }
                default:{
                    NSLog(@"4");
                }
            }
        }else{
            //context evaluatePolicy:<#(LAPolicy)#> localizedReason:<#(nonnull NSString *)#> reply:<#^(BOOL success, NSError * _Nullable error)reply#>
            //[context invalidate];
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"面容识别" reply:^(BOOL success, NSError * __nullable error){
                if(success){
                    NSLog(@"success");
                }else{
                    switch (error.code) {
                        case LAErrorUserFallback:{
                            NSLog(@"11");
                            break;
                        }
                        case LAErrorUserCancel:{
                            NSLog(@"12");
                            break;
                        }
                        case LAErrorAppCancel:{
                            NSLog(@"13");
                            break;
                        }
                        case LAErrorSystemCancel:{
                            NSLog(@"14");
                            break;
                        }
                        case LAErrorInvalidContext:{
                            NSLog(@"15");
                            break;
                        }
                        default:{
                            break;
                        }
                    }
                }
            }];
           
        }
    //}
}
@end
