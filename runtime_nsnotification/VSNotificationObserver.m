//
//  VSNotificationObserver.m
//  runtime_nsnotification
//
//  Created by caitou on 2022/2/28.
//

#import "VSNotificationObserver.h"
#import "VSNotification.h"
@interface VSNotificationObserver()
@property (nonatomic, strong) id observer;
@property (nonatomic, assign) SEL selector;
@end

@implementation VSNotificationObserver
- (instancetype)initWithObserver:(id)observer selector:(SEL)sel {
    if (self = [super init]) {
        self.observer = observer;
        self.selector = sel;
    }
    return self;
}

- (void)postNotification:(VSNotification *)note {
    [_observer performSelector:_selector withObject:note];
}

@end
