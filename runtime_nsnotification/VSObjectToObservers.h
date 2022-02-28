//
//  VSObjectToObservers.h
//  runtime_nsnotification
//
//  Created by caitou on 2022/2/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VSNotificationObserver, VSNotification;
@interface VSObjectToObservers : NSObject
- (NSInteger)count;
- (void)addObserver:(VSNotificationObserver *)observer object:(nullable id)object;
- (void)postNotification:(VSNotification *)notification;
- (void)removeObserver:(id)anObserver object:(nullable id)object;
- (void)invalidate;
@end

NS_ASSUME_NONNULL_END
