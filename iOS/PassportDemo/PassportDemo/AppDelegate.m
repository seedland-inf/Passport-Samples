//
//  AppDelegate.m
//  TestPassport
//
//  Created by SeedLandMac on 2017/11/10.
//  Copyright © 2017年 SeedLandMac. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SDKitManager.h"


@interface AppDelegate ()

@property (nonatomic, strong) UIWindow *w2;

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[SDKitManager shareKitManager] initSdkWithChannel:@"test" andKey:@"hay8qwz"];
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *rootView = [[ViewController alloc] init];
    self.window.rootViewController = rootView;
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootView];
//    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    
//    // 2. 再创建一个窗口
//    UIWindow *w2 = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    UIViewController *vc = [UIViewController new];
//    [vc.view setBackgroundColor:[UIColor clearColor]];
//    w2.backgroundColor = [UIColor yellowColor];
//    w2.rootViewController = vc;
//    [w2 makeKeyAndVisible];
//    self.w2 = w2;
//
//
//    // 3.2将文本输入框添加到w2中
//    UITextField *tx2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 100, 40)];
//    tx2.borderStyle = UITextBorderStyleRoundedRect;
//    [self.w2 addSubview:tx2];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[SDKitManager shareKitManager] updateToken];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
