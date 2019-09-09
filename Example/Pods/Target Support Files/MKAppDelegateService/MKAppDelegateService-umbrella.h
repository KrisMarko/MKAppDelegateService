#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MKAppDelegate.h"
#import "MKAppDelegateForwardProxy.h"
#import "MKAppDelegateService.h"

FOUNDATION_EXPORT double MKAppDelegateServiceVersionNumber;
FOUNDATION_EXPORT const unsigned char MKAppDelegateServiceVersionString[];

