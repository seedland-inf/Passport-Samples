//
//  ViewController.m
//  PassportDemo
//
//  Created by SeedLandMac on 2017/12/5.
//  Copyright © 2017年 Qizhigang. All rights reserved.
//

#import "ViewController.h"
//#import "SDKitUtility.h"
//#import "SDKitManager.h"


@interface ViewController ()

@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginBtn setFrame:CGRectMake(50, 100, 100, 30)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(onLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *modifyPasswordBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [modifyPasswordBtn setFrame:CGRectMake(50, 150, 100, 30)];
    [modifyPasswordBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [modifyPasswordBtn addTarget:self action:@selector(onModifyButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modifyPasswordBtn];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [registerBtn setFrame:CGRectMake(50, 200, 100, 30)];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(onRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logoutBtn setFrame:CGRectMake(50, 250, 100, 30)];
    [logoutBtn setTitle:@"退出" forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(onLogoutButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onLoginButton:(UIButton *)sender
{
//    [[SDKitManager shareKitManager] openLoginViewAndAllowClose:YES];
}

- (void)onModifyButton:(UIButton *)sender
{
//    [[SDKitManager shareKitManager] openModifyPasswordView];
}

- (void)onRegisterButton:(UIButton *)sender
{
//    [[SDKitManager shareKitManager] openRegisterView];
}

- (void)onLogoutButton:(UIButton *)sender
{
//    [[SDKitManager shareKitManager] logoutAccount];
}

@end
