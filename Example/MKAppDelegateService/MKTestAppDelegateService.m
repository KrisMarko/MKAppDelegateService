//
//  MKTestAppDelegateService.m
//  MKAppDelegateService_Example
//
//  Created by 张禹 on 2019/3/19.
//  Copyright © 2019 Kris.Marko---ZhangYu. All rights reserved.
//

#import "MKTestAppDelegateService.h"
#import <MKAppDelegateService/MKAppDelegateService.h>

@interface MKTestAppDelegateService () <MKAppDelegateForwardDelegate>

@end

@implementation MKTestAppDelegateService

MK_EXPORT_SERVICE(MKTestAppDelegateService)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        application.delegate.window = window;
    
        UIViewController * dvc = [[UIViewController alloc] init];
        dvc.view.backgroundColor = [UIColor redColor];
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:dvc];
        window.rootViewController = nav;
        [window makeKeyAndVisible];

    NSLog(@"%s",__FUNCTION__);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%s",__FUNCTION__);
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"%s",__FUNCTION__);
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%s",__FUNCTION__);
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%s",__FUNCTION__);
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"%s",__FUNCTION__);
}

@end
