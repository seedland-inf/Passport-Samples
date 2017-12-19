//
//  UserInfoModel.m
//  TestPassport
//
//  Created by SeedLandMac on 2017/12/13.
//  Copyright © 2017年 SeedLandMac. All rights reserved.
//

#import "UserInfoModel.h"


#define USER_INFO_ID @"userID"
#define USER_INFO_MOBILE @"mobile"
#define USER_INFO_NICKNAME @"nickname"
#define USER_INFO_SIGN @"sign"
#define USER_INFO_TOKEN @"token"


@implementation UserInfoModel

- (void)saveInfo
{
    [[NSUserDefaults standardUserDefaults] setObject:_mobile forKey:USER_INFO_MOBILE];
    [[NSUserDefaults standardUserDefaults] setObject:_userID forKey:USER_INFO_ID];
    [[NSUserDefaults standardUserDefaults] setObject:_nickname forKey:USER_INFO_NICKNAME];
    [[NSUserDefaults standardUserDefaults] setObject:_tokenString forKey:USER_INFO_TOKEN];
    [[NSUserDefaults standardUserDefaults] setObject:_signString forKey:USER_INFO_SIGN];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loadInfo
{
    self.mobile = [[NSUserDefaults standardUserDefaults] objectForKey:USER_INFO_MOBILE];
    self.userID = [[NSUserDefaults standardUserDefaults] objectForKey:USER_INFO_ID];
    self.nickname = [[NSUserDefaults standardUserDefaults] objectForKey:USER_INFO_NICKNAME];
    self.tokenString =[[NSUserDefaults standardUserDefaults] objectForKey:USER_INFO_TOKEN];
    self.signString = [[NSUserDefaults standardUserDefaults] objectForKey:USER_INFO_SIGN];
}

- (void)clearInfo
{
    self.mobile = @"";
    self.userID = @"";
    self.nickname = @"";
    self.tokenString = @"";
    self.signString = @"";
    
    [self saveInfo];
}

@end
