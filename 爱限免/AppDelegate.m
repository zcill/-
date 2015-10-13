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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self createTabBar];
    
    return YES;
}

// 创建标签栏
- (void)createTabBar {
    
    UITabBarController *tbc = [[UITabBarController alloc] init];
    [tbc addViewControlerWithClass:[ZCLimitViewController class] title:@"限免" image:@"tabbar_limitfree.png" selectImage:@"tabbar_limitfree_press.png"];
    [tbc addViewControlerWithClass:[ZCLimitViewController class] title:@"降价" image:@"tabbar_reduceprice.png" selectImage:@"tabbar_reduceprice_press.png"];
    [tbc addViewControlerWithClass:[ZCLimitViewController class] title:@"免费" image:@"tabbar_appfree.png" selectImage:@"tabbar_appfree_press.png"];
    [tbc addViewControlerWithClass:[ZCLimitViewController class] title:@"专题" image:@"tabbar_subject.png" selectImage:@"tabbar_subject_press.png"];
    [tbc addViewControlerWithClass:[ZCLimitViewController class] title:@"热榜" image:@"tabbar_rank.png" selectImage:@"tabbar_rank_press.png"];
    
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
