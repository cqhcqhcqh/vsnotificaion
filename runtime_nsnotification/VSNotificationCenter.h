//
//  VSNotificationCenter.h
//  runtime_nsnotification
//
//  Created by caitou on 2022/2/28.
//

#import <Foundation/Foundation.h>

@class VSNotification;

NS_ASSUME_NONNULL_BEGIN

@interface VSNotificationCenter : NSObject
@property (class, readonly, strong) VSNotificationCenter *defaultCenter;

- (void)addObserver:(id)observer
           selector:(SEL)aSelector
               name:(nullable NSString *)aName
             object:(nullable id)anObject;
- (void)postNotification:(VSNotification *)notification;
- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject;
- (void)postNotificationName:(NSString *)aName
                      object:(nullable id)anObject
                    userInfo:(nullable NSDictionary *)aUserInfo;

- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer
                  name:(nullable NSString *)aName
                object:(nullable id)anObject;
@end

NS_ASSUME_NONNULL_END
