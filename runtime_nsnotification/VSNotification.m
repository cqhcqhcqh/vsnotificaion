//
//  VSNotification.m
//  runtime_nsnotification
//
//  Created by caitou on 2022/2/28.
//

#import "VSNotification.h"

@interface VSNotification()
@property (nonatomic, copy) NSString *name;
@property (nonatomic, weak) id object;
@property (nonatomic, strong) NSDictionary *userInfo;
@end

@implementation VSNotification

- (instancetype)initWithName:(NSNotificationName)name
                      object:(nullable id)object
                    userInfo:(nullable NSDictionary *)userInfo {
    if (self = [super init]) {
        self.name = name;
        self.object = object;
        self.userInfo = userInfo;
    }
    return self;
}
@end
