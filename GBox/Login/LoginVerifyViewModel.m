//
//  LoginVerifyViewModel.m
//  GBox
//
//  Created by jason on 2016/10/22.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "LoginVerifyViewModel.h"

@interface LoginVerifyViewModel ()
@property (nonatomic, strong, readwrite) RACCommand* loginCommand;
@property (nonatomic, strong, readwrite) RACCommand* nextCommand;
@property (nonatomic, strong, readwrite) RACCommand* backCommand;
@property (nonatomic, copy, readwrite) NSString* realVerifyCode;

@end

@implementation LoginVerifyViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _loginResult = false;
        @weakify(self)
        self.nextCommand = [[RACCommand alloc]initWithSignalBlock:^(id input){
            @strongify(self)
            self.realVerifyCode = @"123456";
            return [RACSignal empty];
        }];
        
        self.backCommand = [[RACCommand alloc]initWithSignalBlock:^(id input) {
            @strongify(self)
            self.realVerifyCode = NULL;
            return [RACSignal empty];
        }];
        self.loginCommand = [[RACCommand alloc]initWithSignalBlock:^(id input) {
            @strongify(self)
            self.loginResult = @([self.verifyCode isEqualToString:self.realVerifyCode]);
            return [RACSignal empty];
        }];
        [RACObserve(self, loginResult) subscribeNext:^(NSNumber* result){
            if ([result boolValue] == YES){
                //登录成功
                //做些数据上的处理
            }
        }];
    }
    return self;
}

@end
