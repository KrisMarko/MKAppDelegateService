//
//  MKAppDelegateForwardProxy.h
//  MKAppDelegateService
//
//  Created by 张禹 on 2019/3/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define MK_EXPORT_SERVICE(name) \
+ (void)load {[[MKAppDelegateForwardProxy sharedManager] registerService:[self new]];} \
- (NSString *)serviceName { return @#name; }

NS_ASSUME_NONNULL_BEGIN

@protocol MKAppDelegateForwardDelegate <UIApplicationDelegate>

@required
/**
 服务名称

 @return 服务名称
 */
- (NSString *)serviceName;

@end



@interface MKAppDelegateForwardProxy : NSObject

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

@end

NS_ASSUME_NONNULL_END
