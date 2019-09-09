//
//  MKAppDelegateForwardProxy.m
//  MKAppDelegateService
//
//  Created by 张禹 on 2019/3/19.
//

#import "MKAppDelegateForwardProxy.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface MKAppDelegateForwardProxy ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id<MKAppDelegateForwardDelegate>> *servicesMap;

@end

/**
 由子类实现服务代理方法，父类负责把这些实现添加到 Application Delegate 中
 这些都需要在 Application Delegate 实例创建之前执行
 */
@implementation MKAppDelegateForwardProxy

+ (instancetype)sharedManager {
    static MKAppDelegateForwardProxy *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [MKAppDelegateForwardProxy new];
    });
    return _sharedManager;
}

- (instancetype)init {
    if (self = [super init]) {
        self.servicesMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)registerService:(id<MKAppDelegateForwardDelegate>)service {
    if (!service) {
        return;
    }
    id<MKAppDelegateForwardDelegate> pre = self.servicesMap[[service serviceName]];
    if (pre) {
        if ([service isKindOfClass:[pre class]]) {
            self.servicesMap[[service serviceName]] = service;
        } else {
            NSAssert([pre isKindOfClass:[service class]],
                     @"Tried to register both %@ and %@ as the handler of %@ service. \
                     Cannot determine the right class to use because neither inherits from the other.",
                     [pre class], [service class], [service serviceName]);
        }
    } else {
        self.servicesMap[[service serviceName]] = service;
    }
}

#pragma mark Proxy

- (BOOL)proxyCanResponseToSelector:(SEL)aSelector {
    __block IMP imp = NULL;
    [self.servicesMap enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<MKAppDelegateForwardDelegate> _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:aSelector]) {
            imp = [(id)obj methodForSelector:aSelector];
            NSMethodSignature *signature = [(id)obj methodSignatureForSelector:aSelector];
            if (signature.methodReturnLength > 0 && strcmp(signature.methodReturnType, @encode(BOOL)) != 0) {
                imp = NULL;
            }
            *stop = YES;
        }
    }];
    return imp != NULL && imp != _objc_msgForward;
}

- (NSString *)objcTypesFromSignature:(NSMethodSignature *)signature {
    NSMutableString *types = [NSMutableString stringWithFormat:@"%s", signature.methodReturnType?:"v"];
    for (NSUInteger i = 0; i < signature.numberOfArguments; i ++) {
        [types appendFormat:@"%s", [signature getArgumentTypeAtIndex:i]];
    }
    return [types copy];
}

- (void)proxyForwardInvocation:(NSInvocation *)anInvocation {
    NSMethodSignature *signature = anInvocation.methodSignature;
    NSUInteger argCount = signature.numberOfArguments;
    __block BOOL returnValue = NO;
    NSUInteger returnLength = signature.methodReturnLength;
    void * returnValueBytes = NULL;
    if (returnLength > 0) {
        returnValueBytes = alloca(returnLength);
    }
    
    [self.servicesMap enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<MKAppDelegateForwardDelegate> _Nonnull obj, BOOL * _Nonnull stop) {
        if ( ! [obj respondsToSelector:anInvocation.selector]) {
            return;
        }
        
        NSAssert([[self objcTypesFromSignature:signature] isEqualToString:[self objcTypesFromSignature:[(id)obj methodSignatureForSelector:anInvocation.selector]]],
                 @"Method signature for selector (%@) on (%@ - `%@`) is invalid. \
                 Please check the return value type and arguments type.",
                 NSStringFromSelector(anInvocation.selector), obj.serviceName, obj);
        
        NSInvocation *invok = [NSInvocation invocationWithMethodSignature:signature];
        invok.selector = anInvocation.selector;
        // 复制 参数
        for (NSUInteger i = 0; i < argCount; i ++) {
            const char * argType = [signature getArgumentTypeAtIndex:i];
            NSUInteger argSize = 0;
            NSGetSizeAndAlignment(argType, &argSize, NULL);
            
            void * argValue = alloca(argSize);
            [anInvocation getArgument:&argValue atIndex:i];
            [invok setArgument:&argValue atIndex:i];
        }
        invok.target = obj;
        [invok invoke];
        
        // get 返回值
        if (returnValueBytes) {
            [invok getReturnValue:returnValueBytes];
            returnValue = returnValue || *((BOOL *)returnValueBytes);
        }
    }];
    
    // set 返回值
    if (returnValueBytes) {
        [anInvocation setReturnValue:returnValueBytes];
    }
}

@end
