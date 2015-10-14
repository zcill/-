//
//  AppDelegate.m
//  爱限免
//
//  Created by 朱立焜 on 15/10/12.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#import "AppDelegate.h"
#import "UITabBarController+ZJExtension.h"
#import "ZCLimitViewController.h"
#import "ZCSaleViewController.h"
#import "ZCFreeViewController.h"
#import "ZCTopicViewController.h"
#import "ZCHotViewController.h"
#import "NetInterface.h"
// 友盟
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self createTabBar];
    
    [self configUMSocial];
    
    return YES;
}

- (void)configUMSocial {
    
    [UMSocialData setAppKey:@"5556a53667e58e1bb500661d"];
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    //Bundle ID: qianfeng.LimitFreeProject
    
}

// 创建标签栏
- (void)createTabBar {
    
    // 除了专题页面之外的父类
    ZCAppListViewController *vc = nil;
    
    UITabBarController *tbc = [[UITabBarController alloc] init];
    
    /** 限免页面 */
    vc = [tbc addViewControlerWithClass:[ZCLimitViewController class] title:@"限免" image:@"tabbar_limitfree.png" selectImage:@"tabbar_limitfree_press.png"];
    vc.urlString = LIMIT_URL;
    
    /** 降价页面 */
    vc = [tbc addViewControlerWithClass:[ZCSaleViewController class] title:@"降价" image:@"tabbar_reduceprice.png" selectImage:@"tabbar_reduceprice_press.png"];
    vc.urlString = SALE_URL;
    
    /** 免费页面 */
    vc = [tbc addViewControlerWithClass:[ZCFreeViewController class] title:@"免费" image:@"tabbar_appfree.png" selectImage:@"tabbar_appfree_press.png"];
    vc.urlString = FREE_URL;
    
    /** 专题页面 */
    [tbc addViewControlerWithClass:[ZCTopicViewController class] title:@"专题" image:@"tabbar_subject.png" selectImage:@"tabbar_subject_press.png"];
    
    /** 热榜页面 */
    vc = [tbc addViewControlerWithClass:[ZCHotViewController class] title:@"热榜" image:@"tabbar_rank.png" selectImage:@"tabbar_rank_press.png"];
    vc.urlString = HOT_URL;
    
    self.window.rootViewController = tbc;
    self.window.backgroundColor = [UIColor whiteColor];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
