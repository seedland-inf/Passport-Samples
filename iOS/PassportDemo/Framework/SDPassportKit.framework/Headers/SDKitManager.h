//
//  SDKitManager.h
//  SDPassportKit
//
//  Created by SeedLandMac on 2017/11/10.
//  Copyright © 2017年 qizhigang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SDKitPassportDefine.h"


@interface SDKitManager : NSObject

/**
 获取SDK manager 单例。

 @return SDKitManager单例
 */
+ (instancetype)shareKitManager;

/**
 设置SDK的渠道号和渠道对应的秘钥key。

 @param channel 注册SDK时指定的渠道号
 @param key 注册渠道对应的key
 */
- (void)initSdkWithChannel:(NSString *)channel andKey:(NSString *)key;

/**
 刷新Token。
 */
- (void)updateToken;

/**
 获取Token。

 @return 返回Token字符串。如果，没有登录、Token无效或者过期，则返回nil。
 */
- (NSString *)getToken;

/**
 判断是否登录。

 @return YES表示登录。NO表示没有登录。
 */
- (BOOL)isLogin;

/**
 打开登录页。
 
 @param allowColse  是否允许关闭返回。即：该登录是否允许关闭。根据App需求，如需强制先登录才能后续操作的。则设置allowColse为YES.否则，为NO。
 默认为YES。允许关闭。
 @param loginSuccess 登录成功后执行该回调函数。
 */
- (void)openLoginViewAndAllowClose:(BOOL)allowColse loginComplete:(SDKitCompleteBlock)loginSuccess;

/**
 打开修改密码页

 @param modifySuccessBlock 修改密码成功后，执行该回调函数。
 */
- (void)openModifyPasswordViewAndCompletion:(SDKitCompleteBlock)modifySuccessBlock;

/**
 打开注册页
 */
- (void)openRegisterView;

/**
 退出登陆
 */
- (void)logoutAccount;

@end
