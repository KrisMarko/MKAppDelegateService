# MKAppDelegateService
现在很多app上的业务都是通过组件的方式引入，本项目目的解决业务组件中获取到app生命周期。

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://cocoapods.org/pods/MKAppDelegateService)
[![Platform](https://img.shields.io/cocoapods/p/MKAppDelegateService.svg?style=flat)](https://cocoapods.org/pods/MKAppDelegateService)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

1.MKAppDelegateService is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MKAppDelegateService'
```
2.Run `pod install`or`pod update`
3.Import <MKAppDelegateService/MKAppDelegateService.h>

##Usage
1.首先AppDelegate.h中如下，引用`<MKAppDelegateService/MKAppDelegateService.h>`，修改继承关系`MKAppDelegate`
``` objectivec
@import UIKit;
#import <MKAppDelegateService/MKAppDelegateService.h>

@interface MKDemoAppDelegate : MKAppDelegate <UIApplicationDelegate>

@end
```
2.创建一个AppDelegate的代理类`MKTestAppDelegateService`继承自`NSObject`，引入`<MKAppDelegateService/MKAppDelegateService.h>`，类签订代理协议`MKAppDelegateForwardDelegate`，实现需要关注的AppDelegate方法，注册到`MKAppDelegateForwardProxy`中代码如下。
```objectivec
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
```
3.AppDelegate中已经实现的方法需要让父类调用一下，为实现的方法无需关注。如下：
```objectivec
@implementation MKDemoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    if ([super respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
        [super application:application didFinishLaunchingWithOptions:launchOptions];
    }
    return YES;
}

@end
```

下面为打印输出
![log](https://github.com/KrisMarko/MKAppDelegateService/MDResource/log.png)

MKAppDelegateForwardProxy.h
```objectivec
@protocol MKAppDelegateForwardDelegate <UIApplicationDelegate>

@required
/**
 服务名称

 @return 服务名称
 */
- (NSString *)serviceName;

@end



/**
 单利实例话方法

 @return 返回单利
 */
+ (instancetype)sharedManager;

/**
 注册服务
 
 @param service 实现“MKAppDelegateForwardDelegate”的代理对象
 */
- (void)registerService:(id<MKAppDelegateForwardDelegate>)service;

/**
 是否有代理可以响音这个方法

 @param aSelector 方法SEL
 @return YES or NO
 */
- (BOOL)proxyCanResponseToSelector:(SEL)aSelector;

/**
 向代理转发调用

 @param anInvocation NSInvocation *
 */
- (void)proxyForwardInvocation:(NSInvocation *)anInvocation;

```

注册代理服务也可使用一下宏
```objectivec
#define MK_EXPORT_SERVICE(name) \
+ (void)load {[[MKAppDelegateForwardProxy sharedManager] registerService:[self new]];} \
- (NSString *)serviceName { return @#name; }
```

###注：因内部实现是重写AppDelegate的forwardInvocation这个方法，如果AppDelegate已经实现的`UIApplicationDelegate`	方法没有使用super再次调用，则无法调到代理中的实现。
##Demo Project
See `Example/MKAppDelegateService.xcworkspace`

## Author

Kris.Marko---ZhangYu, winzhyu@yeah.net

## License

MKAppDelegateService is available under the MIT license. See the LICENSE file for more info.
