//
//  VSNotificationCenter.m
//  runtime_nsnotification
//
//  Created by caitou on 2022/2/28.
//

#import "VSNotificationCenter.h"
#import "VSNotification.h"
#import "VSNotificationObserver.h"
#import "VSObjectToObservers.h"

@interface VSNotificationCenter()

@end

@implementation VSNotificationCenter {
    VSObjectToObservers *_noNameRegistry;
    NSMutableDictionary *nameToRegistry;
}

+ (VSNotificationCenter *)defaultCenter {
    static VSNotificationCenter *center;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[VSNotificationCenter alloc] init];
    });
    return center;
}

- (instancetype)init {
    if (self == [super init]) {
        nameToRegistry = [NSMutableDictionary dictionary];
        _noNameRegistry = [[VSObjectToObservers alloc] init];
    }
    return self;
}

- (void)addObserver:(id)observer
           selector:(SEL)aSelector
               name:(nullable NSString *)aName
             object:(nullable id)anObject {
    VSNotificationObserver *_observer = [[VSNotificationObserver alloc] initWithObserver:observer
                                         selector:aSelector];
    VSObjectToObservers *registry;
    if (aName == nil) {
        registry = _noNameRegistry;
    } else {
        registry = nameToRegistry[aName];
    }
    if (registry == nil) {
        registry = [[VSObjectToObservers alloc] init];
        nameToRegistry[aName] = registry;
    }
    [registry addObserver:_observer object:anObject];
}

static inline void postNotification(VSNotificationCenter *self, VSNotification *note) {
    VSObjectToObservers *registry = self->_noNameRegistry;
    [registry postNotification:note];
    registry = [self->nameToRegistry objectForKey:[note name]];
    [registry postNotification:note];
}

- (void)postNotification:(VSNotification *)note {
    postNotification(self, note);
}

- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject {
    VSNotification *note = [[VSNotification alloc] initWithName:aName object:anObject userInfo:nil];
    postNotification(self, note);
}

- (void)postNotificationName:(NSString *)aName
                      object:(nullable id)anObject
                    userInfo:(nullable NSDictionary *)aUserInfo {
    VSNotification *note = [[VSNotification alloc] initWithName:aName object:anObject userInfo:aUserInfo];
    postNotification(self, note);
}

- (void)removeObserver:(id)anObserver {
    for (VSObjectToObservers *registry in [nameToRegistry copy]) {
        [registry removeObserver:anObserver object:nil];
    }
    [_noNameRegistry removeObserver:anObserver object:nil];
}

- (void)removeObserver:(id)anObserver
                  name:(nullable NSString *)name
                object:(nullable id)object {
    if(name != nil) {
        VSObjectToObservers *registry = [nameToRegistry objectForKey:name];
        [registry removeObserver:anObserver object:object];
    } else {
        for (VSObjectToObservers *registry in [nameToRegistry copy]) {
            [registry removeObserver:anObserver object:nil];
        }
        [_noNameRegistry removeObserver:anObserver object:object];
    }
}

@end
