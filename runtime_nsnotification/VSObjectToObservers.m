//
//  VSObjectToObservers.m
//  runtime_nsnotification
//
//  Created by caitou on 2022/2/28.
//

#import "VSObjectToObservers.h"
#import "VSNotificationObserver.h"
#import "VSNotification.h"

@interface VSObjectToObservers()

@end

@implementation VSObjectToObservers {
    NSMapTable<id, NSMutableArray *> *_objectToObservers;
}
- (instancetype)init {
    if (self = [super init]) {
        _objectToObservers = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsWeakMemory
                                                   valueOptions:NSPointerFunctionsStrongMemory];
    }
    return self;
}

- (NSInteger)count {
    return _objectToObservers.count;
}

- (void)invalidate {
    [_objectToObservers removeAllObjects];
}

- (void)addObserver:(VSNotificationObserver *)observer object:(id)object {
    /// 如果 object 为 nil
    /// NSNull null 作为 key 来存储映射
    if (object != nil) {
        object = [NSNull null];
    }
    
    /// 创建 object <--> Observers 的映射表（hash）
    NSMutableArray *observers = [_objectToObservers objectForKey:object];
    if (observers == nil) {
        observers = [NSMutableArray array];
        [_objectToObservers setObject:observers forKey:object];
    }
    [observers addObject:observer];
}

- (void)postNotification:(VSNotification *)note {
    id object = [note object] ?: [NSNull null];
    NSMutableArray *observers;
    NSInteger count;
    
    observers = [_objectToObservers objectForKey:object];
    count = [observers count];
    for (id observer in observers) {
        [observer performSelector:_cmd withObject:note];
    }
}

- (void)removeObserver:(id)anObserver object:(id)object {
    if(object != nil) {
        NSMutableArray *observers = [_objectToObservers objectForKey:object];
        for (id observer in [observers copy]) {
            if (observer == anObserver) {
                [observers removeObject:observer];
            }
        }
        if (observers.count == 0) {
            [_objectToObservers removeObjectForKey:object];
        }
    } else {
        for (NSMutableArray *observers in _objectToObservers.objectEnumerator) {
            for (id observer in [observers copy]) {
                if (observer == anObserver) {
                    [observers removeObject:observer];
                }
            }
            if (observers.count == 0) {
                [_objectToObservers removeObjectForKey:object];
            }
        }
    }
}

@end
