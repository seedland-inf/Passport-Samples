//
//  UserInfoModel.h
//  TestPassport
//
//  Created by SeedLandMac on 2017/12/13.
//  Copyright © 2017年 SeedLandMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

// 用户id
@property (nonatomic, copy) NSString *userID;

// 手机号
@property (nonatomic, copy) NSString *mobile;

// 用户昵称
@property (nonatomic, copy) NSString *nickname;

// 验证sign
@property (nonatomic, copy) NSString *signString;

// Token
@property (nonatomic, copy) NSString *tokenString;


/**
 本地化存储
 */
- (void)saveInfo;


/**
 载入本地化数据
 */
- (void)loadInfo;


/**
 清除数据
 */
- (void)clearInfo;

@end
