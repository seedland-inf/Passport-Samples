//
//  SDKitPassportDefine.h
//  TestPassport
//
//  Created by SeedLandMac on 2017/12/13.
//  Copyright © 2017年 SeedLandMac. All rights reserved.
//

#ifndef SDKitPassportDefine_h
#define SDKitPassportDefine_h


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


static NSString *SDREGISTER_SUCCESSED_NOTIFICATION = @"SDRegisterSuccessedNotification";

static NSString *SDFORGOT_PASSWORD_CHANGE_SUCCESSED_NOTIFICATION = @"SDForgotSuccessedNotification";


typedef void(^SDKitCompleteBlock)(NSDictionary *dict);

typedef void(^SDKitBackBlock)(void);

typedef void(^SDKitEventBlock)(NSDictionary *dict);


#endif /* SDKitPassportDefine_h */
