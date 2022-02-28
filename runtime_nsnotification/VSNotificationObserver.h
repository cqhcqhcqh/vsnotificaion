//
//  VSNotificationObserver.h
//  runtime_nsnotification
//
//  Created by caitou on 2022/2/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class VSNotification;
@interface VSNotificationObserver : NSObject
@property (nonatomic, strong, readonly) id observer;
@property (nonatomic, assign, readonly) SEL selector;
- (instancetype)initWithObserver:(id)observer selector:(SEL)sel;
- (void)postNotification:(VSNotification *)note;
@end

NS_ASSUME_NONNULL_END
