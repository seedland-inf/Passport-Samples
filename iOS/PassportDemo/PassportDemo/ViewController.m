//
//  ViewController.m
//  TestPassport
//
//  Created by SeedLandMac on 2017/11/10.
//  Copyright © 2017年 SeedLandMac. All rights reserved.
//

#import "ViewController.h"
#import "SDKitManager.h"
#import "UserInfoModel.h"
#import "SDPassportKit.h"


@interface ViewController ()

@property (nonatomic, strong) UILabel *loginLab;
@property (nonatomic, strong) UILabel *mobileLab;
@property (nonatomic, strong) UILabel *nicknameLab;
@property (nonatomic, strong) UILabel *userIDLab;
@property (nonatomic, strong) UILabel *tokenContentLab;
@property (nonatomic, strong) UILabel *signContentLab;

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *logoutButton;
@property (nonatomic, strong) UIButton *modifyButton;

@property (nonatomic, strong) UserInfoModel *userInfo;

@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.userInfo = [[UserInfoModel alloc] init];
    [self.userInfo loadInfo];
    
    CGFloat fontsize = 16;
    CGFloat labelHeight = 20;
    CGFloat x = 30;
    CGFloat y = 40;
    
    UILabel *loginStatus = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 200, labelHeight)];
    [loginStatus setFont:[UIFont systemFontOfSize:fontsize]];
    [loginStatus setText:@"登录状态：未登录"];
    [loginStatus setTextColor:[UIColor blueColor]];
    self.loginLab = loginStatus;
    [self.view addSubview:loginStatus];
    
    UILabel *mobileLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y * 2, 200, labelHeight)];
    [mobileLabel setFont:[UIFont systemFontOfSize:fontsize]];
    [mobileLabel setText:@"手机号：13078838633"];
    [mobileLabel setTextColor:[UIColor blueColor]];
    self.mobileLab = mobileLabel;
    [self.view addSubview:mobileLabel];
    
    UILabel *nickNamelabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y * 3, 200, labelHeight)];
    [nickNamelabel setFont:[UIFont systemFontOfSize:fontsize]];
    [nickNamelabel setText:@"昵称：User_13078838633"];
    [nickNamelabel setTextColor:[UIColor blueColor]];
    self.nicknameLab = nickNamelabel;
    [self.view addSubview:nickNamelabel];
    
    UILabel *userIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y * 4, 200, labelHeight)];
    [userIDLabel setFont:[UIFont systemFontOfSize:fontsize]];
    [userIDLabel setText:@"用户ID：306"];
    [userIDLabel setTextColor:[UIColor blueColor]];
    self.userIDLab = userIDLabel;
    [self.view addSubview:userIDLabel];
    
    UILabel *tokenLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y * 5, 60, labelHeight)];
    [tokenLabel setFont:[UIFont systemFontOfSize:fontsize]];
    [tokenLabel setText:@"Token："];
    [tokenLabel setTextColor:[UIColor blueColor]];
    [self.view addSubview:tokenLabel];
    
    UILabel *tokenContextLabel = [[UILabel alloc] initWithFrame:CGRectMake(x + tokenLabel.frame.size.width - 5, y * 5 - 20, 220, labelHeight * 6)];
    [tokenContextLabel setNumberOfLines:7];
    [tokenContextLabel setFont:[UIFont systemFontOfSize:fontsize - 4]];
    [tokenContextLabel setText:@"HIjDMLDyuln4yNH/+81/e+2iD0FMczuMdIc3Tp2eZtxrqm4sXcUKV3upJ781hljzfOrePyUhY6MHsajLBa97w28VjnAVLW9Si0SDR9ML8ktk4XQBS5srpzlNsdvOvx9jaOix40xPEMAhhSrnLD+g722QM66ccwTflRhYNAStqw8="];
    [tokenContextLabel setTextColor:[UIColor blueColor]];
    self.tokenContentLab = tokenContextLabel;
    [self.view addSubview:tokenContextLabel];
    
    UILabel *signLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y * 6 + labelHeight * 6 - 20, 60, labelHeight)];
    [signLabel setFont:[UIFont systemFontOfSize:fontsize]];
    [signLabel setText:@"Sign："];
    [signLabel setTextColor:[UIColor blueColor]];
    [self.view addSubview:signLabel];
    
    UILabel *signContextLabel = [[UILabel alloc] initWithFrame:CGRectMake(x + tokenLabel.frame.size.width - 5, y * 6 + labelHeight * 6 - 40, 220, labelHeight * 6)];
    [signContextLabel setNumberOfLines:7];
    [signContextLabel setFont:[UIFont systemFontOfSize:fontsize - 4]];
    [signContextLabel setText:@"qSx+3LBOWWM9bQkY8h/tiVoI/cIewbkzUtpKnDyLlGZ78oro+7BdLdkPBDOA2zOzZKSeXsYGHLxH9rpW86KP3k98OayWx//TGu/Nnt4bQUwvPSWn4Xqv5fRuvzAEPILkSldW2YF1PiaAz76jYQNA6fXhJAs4bKlKnbRBLP4dBns="];
    [signContextLabel setTextColor:[UIColor blueColor]];
    self.signContentLab = signContextLabel;
    [self.view addSubview:signContextLabel];
    
    CGRect buttonframe = CGRectMake(200, y - 5, 100, 30);
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginBtn setFrame:buttonframe];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(onLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.borderWidth = 1.0;
    loginBtn.layer.borderColor = [UIColor blueColor].CGColor;
    loginBtn.layer.cornerRadius = 5.0f;
    self.loginButton = loginBtn;
    [self.view addSubview:loginBtn];
    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logoutBtn setFrame:buttonframe];
    [logoutBtn setTitle:@"退出" forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(onLogoutButton:) forControlEvents:UIControlEventTouchUpInside];
    logoutBtn.layer.borderWidth = 1.0;
    logoutBtn.layer.borderColor = [UIColor blueColor].CGColor;
    logoutBtn.layer.cornerRadius = 5.0f;
    self.logoutButton = logoutBtn;
    [self.view addSubview:logoutBtn];
    
    UIButton *modifyPasswordBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [modifyPasswordBtn setFrame:CGRectMake(80, 450, 100, 30)];
    [modifyPasswordBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [modifyPasswordBtn addTarget:self action:@selector(onModifyButton:) forControlEvents:UIControlEventTouchUpInside];
    modifyPasswordBtn.layer.borderWidth = 1.0;
    modifyPasswordBtn.layer.borderColor = [UIColor blueColor].CGColor;
    modifyPasswordBtn.layer.cornerRadius = 5.0f;
    self.modifyButton = modifyPasswordBtn;
    [self.view addSubview:modifyPasswordBtn];
    
//    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [registerBtn setFrame:CGRectMake(50, 320, 100, 30)];
//    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
//    [registerBtn addTarget:self action:@selector(onRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:registerBtn];
    
    [self updateStatus];
}

- (void)updateStatus
{
    BOOL isLogin = NO;
    if ([[SDKitManager shareKitManager] getToken] != nil) {
        isLogin = YES;
    }
    _loginLab.text = [NSString stringWithFormat:@"登录状态：%@",isLogin?@"已登录":@"未登录"];
    _mobileLab.text = [NSString stringWithFormat:@"手机号：%@",_userInfo.mobile];
    _nicknameLab.text = [NSString stringWithFormat:@"昵称：%@",_userInfo.nickname];
    _userIDLab.text = [NSString stringWithFormat:@"用户ID：%@",_userInfo.userID];
    _tokenContentLab.text = [[SDKitManager shareKitManager] getToken];
    _signContentLab.text = @"";
    
    _loginButton.hidden = isLogin;
    _logoutButton.hidden = !isLogin;
    _modifyButton.hidden = !isLogin;
    
    NSLog(@"sdk version %@", [NSString stringWithCString:SDPassportKitVersionString encoding:NSUTF8StringEncoding]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onLoginButton:(UIButton *)sender
{
    __weak typeof(self) weakSelf = self;
    [[SDKitManager shareKitManager] openLoginViewAndAllowClose:YES loginComplete:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        weakSelf.userInfo.userID = dict[@"uid"];
        weakSelf.userInfo.nickname = dict[@"nickname"];
        weakSelf.userInfo.mobile = dict[@"mobile"];
//        weakSelf.userInfo.signString = dict[@"sign"];
        weakSelf.userInfo.tokenString = dict[@"sso_tk"];
        
        [weakSelf.userInfo saveInfo];
        [weakSelf updateStatus];
    }];
}

- (void)onModifyButton:(UIButton *)sender
{
    __weak typeof(self) weakSelf = self;
    [[SDKitManager shareKitManager] openModifyPasswordViewAndCompletion:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        weakSelf.userInfo.userID = dict[@"uid"];
        weakSelf.userInfo.nickname = dict[@"nickname"];
        weakSelf.userInfo.mobile = dict[@"mobile"];
        //        weakSelf.userInfo.signString = dict[@"sign"];
        weakSelf.userInfo.tokenString = dict[@"sso_tk"];
        
        [weakSelf.userInfo saveInfo];
        [weakSelf updateStatus];
    }];
}

- (void)onRegisterButton:(UIButton *)sender
{
    [[SDKitManager shareKitManager] openRegisterView];
}

- (void)onLogoutButton:(UIButton *)sender
{
    [[SDKitManager shareKitManager] logoutAccount];
    [_userInfo clearInfo];
    [self updateStatus];
    
    NSString *msg = @"已退出";
    NSLog(@"%@",msg);
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alt show];
}

@end
