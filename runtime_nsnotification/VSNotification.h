//
//  VSNotification.h
//  runtime_nsnotification
//
//  Created by caitou on 2022/2/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSNotification : NSObject
@property (readonly, copy) NSString* name;
@property (nullable, readonly, retain) id object;
@property (nullable, readonly, copy) NSDictionary *userInfo;

- (instancetype)initWithName:(NSNotificationName)name
                      object:(nullable id)object
                    userInfo:(nullable NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END
