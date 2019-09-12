//
//  MKTest2AppDelegateService.m
//  MKAppDelegateService_Example
//
//  Created by 张禹 on 2019/3/19.
//  Copyright © 2019 Kris.Marko---ZhangYu. All rights reserved.
//

#import "MKTest2AppDelegateService.h"
#import <MKAppDelegateService/MKAppDelegateService.h>

//@interface MKTest2AppDelegateService () <MKAppDelegateForwardDelegate>
//
//@end

@implementation MKTest2AppDelegateService

//MK_EXPORT_SERVICE(MKTest2AppDelegateService)

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
