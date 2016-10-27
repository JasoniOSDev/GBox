//
//  GBUserDefault.m
//  GBox
//
//  Created by jason on 2016/10/23.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GBUserDefault.h"

@interface GBUserDefault ()

@property(nonatomic, strong)NSUserDefaults* userDefault;

@end

@implementation GBUserDefault

static GBUserDefault* shareUserDefault;
+ (instancetype)shareUserDefault{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareUserDefault = [[GBUserDefault alloc]init];
    });
    return shareUserDefault;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _userDefault = [[NSUserDefaults alloc]initWithSuiteName:@"GBox"];
    }
    return self;
}

- (NSString *)userID{
    return [_userDefault stringForKey:@"userID"];
}

- (void)setUserID:(NSString *)userID{
    [_userDefault setObject:userID forKey:@"userID"];
}
@end
