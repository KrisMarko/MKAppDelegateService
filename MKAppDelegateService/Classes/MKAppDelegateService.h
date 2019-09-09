//
//  MKAppDelegateService.h
//  Pods
//
//  Created by 张禹 on 2019/3/19.
//

#if __has_include(<MKAppDelegateService/MKAppDelegateService.h>)
FOUNDATION_EXPORT double MKAppDelegateServiceVersionNumber;
FOUNDATION_EXPORT const unsigned char MKAppDelegateServiceVersionString[];

#import <MKAppDelegateService/MKAppDelegate.h>
#import <MKAppDelegateService/MKAppDelegateForwardProxy.h>

#else

#import "MKAppDelegate.h"
#import "MKAppDelegateForwardProxy.h"

#endif
