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

// 页面布局定义
typedef enum {
    SDPassportLayoutTypeDefault,        // 默认实地集团标准布局样式。
    SDPassportLayoutTypeOne,            // 布局样式一。密码登录与验证码登录在同一页面。区别于默认布局。
} SDPassportLayoutType;

//
typedef enum {
    SDPassportAutoLoginOFF,             // 默认是自动登录关闭。
    SDPassportAutoLoginON,              // 自动登录开启
} SDPassportAutoLoginType;

// 保存账号类型。
typedef enum {
    SDPassportSaveAccountNone,          // 退出登录后，不保留登录的账号和密码。默认不保留。
    SDPassportSaveAccountOnly,          // 退出登录后，仅显示账号
    SDPassportSaveAccountAndPassword,   // 退出登录后，保留账号密码。（限于使用密码登录；验证码快捷登录的，仅保留账号。）
    SDPassportSaveAccountOnlyAndNotKeyChain, // 退出登录，保存账号到本地。（非keychain记录）即:删除app账号记录一并删除。而前两项则会保存在keychain中，持久化数据。删除App不会受到影响。
} SDPassportSaveAccountType;


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
 设置SDK的测试渠道号和测试渠道对应的秘钥key。
 
 @param testChannel 注册SDK时指定的测试渠道号
 @param testKey 注册测试渠道对应的key
 */
- (void)initSdkWithTestChannel:(NSString *)testChannel andTestKey:(NSString *)testKey;

#pragma mark - 以下为配置项，不设置表示采用默认选项。默认项为集团推广色调，布局等配置。
/**
 设置布局类型。默认为SDPassportLayoutTypeDefault。即：实地默认布局方式和色调。

 @param type 布局类型。SDPassportLayoutType。目前支持两种显示模式。
 */
- (void)setLayoutType:(SDPassportLayoutType)type;

/**
 设置颜色风格。
 注：默认是实地集团蓝色色调样式。
 当设置为 - (void)setLayoutType:(SDPassportLayoutType)type;该函数后，则色调改为指定的红色色调样式。无需配置如下函数。
 若设置了指定颜色。则界面的展示色调样式将会改为指定色调样式。
 
 @param color 指定的颜色样式。
 */
- (void)setColorStyle:(UIColor *)color;

/**
 隐藏示意性图标。即：隐藏输入框左侧提示性的示意图标。
 注：如果设置了 SDPassportLayoutType为SDPassportLayoutTypeOne，则自动将左侧示意性图标隐藏。
 
 @param hidden 为YES表示隐藏。否则显示。
 */
- (void)setSchematicIconsHidden:(BOOL)hidden;

/**
 设置文本输入框textfield 左右两侧是否保留间距。
 注： 如果设置布局SDPassportLayoutTypeOne，则不保留间距。

 @param existSpace YES表示存在。NO表示不存在间距。默认，保留间距。
 */
- (void)setTextFieldExistHorizontalSpacing:(BOOL)existSpace;

/**
 注册完成后是否直接登录。

 @param autoLogin YES表示直接登录。NO表示不直接登录。
 */
- (void)setRegisterCompleteAutoLogin:(BOOL)autoLogin;

/**
 是否开启简化注册与修改操作。
 即：注册，修改，重置密码等操作无需二次确认输入操作。
 温馨提示：为避免用户在注册修改密码过程中误操作，导致不能登录。推荐采用二次确认。即，不开启简化。

 @param isOpen YES 表示开启。NO表示不开启。默认为不开启。
 */
- (void)openSimplifiedRegisterAndModify:(BOOL)isOpen;

/**
 是否关闭登录成功的提示。

 @param close YES 表示确定关闭。 NO 表示不关闭。默认为NO。
 */
- (void)setCloseLoginSuccessdTips:(BOOL)close;

/**
 设置重要说明Label是否可见。
 即：注册，忘记密码，修改密码最下方的提示信息Label是否需要展示。

 @param visible YES 表示可见。 NO 表示隐藏。
 */
- (void)setImportantExplanationLabelVisible:(BOOL)visible;

/**
 设置用户协议Label是否可见。
 即：注册页，注册按钮下方会显示公司设置的使用协议。该协议内容由后台配置。这里仅设置Label的显示，或者隐藏。

 @param visible YES 表示可见。 NO 表示隐藏。
 */
- (void)setUserAgreementLabelVisible:(BOOL)visible;

/**
 设置保存账号的类型。
 即：退出登录时保存登录的账号和密码。以方便退出后，下次登录不需要输入账号以及密码。
 默认为不记录账号密码。
 （注：若选择快捷登录，则SDPassportSaveAccountAndPassword与SDPassportSaveAccountOnly作用相同。仅记录登录账号。）

 @param type SDPassportSaveAccountType登录后保存账号密码的类型。默认为SDPassportSaveAccountNone不保存。
 */
- (void)setSaveAccountType:(SDPassportSaveAccountType)type;

#pragma mark - 系统token，以及相关状态
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
 事件信息处理。
 即：系统中的PV流量操作，以及触发按钮的操作事件的回调处理。可以用来做pv流量监控，和按钮事件的跟踪埋点。

 @param eventBlock 触发事件的回调。
 */
- (void)eventInfo:(SDKitEventBlock) eventBlock;

#pragma mark - 不带返回处理的调用方式。
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
 打开忘记密码（重置密码）窗口

 @param successBlock 重置密码成功后，执行的回调函数。
 */
- (void)openForgotPasswordViewAndCompletion:(SDKitCompleteBlock)successBlock;

/**
 打开忘记密码（重置密码）窗口 （注：亦可用作修改密码窗口。只需将参数mobile传入函数即可。）

 @param mobile 手机号码。若不填写则表示可输入手机号码。效果与前一个函数作用相同。如果填写则表示在界面上不可修改手机号。
 @param successBlock 重置密码成功后，执行的回调函数。
 */
- (void)openForgotPasswordViewAndCompletion:(NSString *)mobile completeBlock:(SDKitCompleteBlock)successBlock;

/**
 打开注册窗口

 @param successBlock 完成注册后，执行的回调。
 */
- (void)openRegisterViewAndCompletion:(SDKitCompleteBlock)successBlock;

/**
 验证码登录

 @param allowColse 是否允许关闭返回。 该参数用法与密码登录窗口一样。  -(void)openLoginViewAndAllowClose:(BOOL)allowColse loginComplete:(SDKitCompleteBlock)loginSuccess
 @param successBlock 登录成功后，执行的回调。
 */
- (void)openVerifyCodeLoginViewAndAllowClose:(BOOL)allowColse loginCompletion:(SDKitCompleteBlock)successBlock;

#pragma mark - 带返回事件的调用方式
/**
 打开登录页。
 
 @param allowColse  是否允许关闭返回。即：该登录是否允许关闭。根据App需求，如需强制先登录才能后续操作的。则设置allowColse为YES.否则，为NO。
 默认为YES。允许关闭。
 @param loginSuccess 登录成功后执行该回调函数。
 @param backBlock 调用登录页面返回按钮的时候，执行回调函数。
 */
- (void)openLoginViewAndAllowClose:(BOOL)allowColse loginComplete:(SDKitCompleteBlock)loginSuccess back:(SDKitBackBlock)backBlock;

/**
 打开修改密码页
 
 @param modifySuccessBlock 修改密码成功后，执行该回调函数。
 @param backBlock 调用修改密码返回按钮的时候，执行回调函数。
 */
- (void)openModifyPasswordViewAndCompletion:(SDKitCompleteBlock)modifySuccessBlock back:(SDKitBackBlock)backBlock;

/**
 打开忘记密码（重置密码）窗口
 
 @param successBlock 重置密码成功后，执行的回调函数。
 @param backBlock 调用忘记密码页面返回按钮的时候，执行回调函数。
 */
- (void)openForgotPasswordViewAndCompletion:(NSString *)mobile completeBlock:(SDKitCompleteBlock)successBlock back:(SDKitBackBlock)backBlock;

/**
 打开注册窗口
 
 @param successBlock 完成注册后，执行的回调。
 @param backBlock 调用打开注册窗口返回按钮的时候，执行回调函数。
 */
- (void)openRegisterViewAndCompletion:(SDKitCompleteBlock)successBlock back:(SDKitBackBlock)backBlock;

/**
 验证码登录
 
 @param allowColse 是否允许关闭返回。 该参数用法与密码登录窗口一样。  -(void)openLoginViewAndAllowClose:(BOOL)allowColse loginComplete:(SDKitCompleteBlock)loginSuccess
 @param successBlock 登录成功后，执行的回调。
 @param backBlock 调用验证码登录返回按钮的时候，执行回调函数。
 */
- (void)openVerifyCodeLoginViewAndAllowClose:(BOOL)allowColse loginCompletion:(SDKitCompleteBlock)successBlock back:(SDKitBackBlock)backBlock;

/**
 退出登陆

 @param showTips 是否展示退出提示。YES，表示显示。NO，不展示。
 */
- (void)logoutAccountAndShowTips:(BOOL) showTips;


#pragma mark - 属性
/**
 当前是否有View在展示。
 初始化SDK后，当调用任意一个页面并显示时，则showView为YES。否则为NO。
 没有打开任何页面该值页为NO。
 */
@property (nonatomic, readonly) BOOL showView;


@end
