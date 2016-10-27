//
//  LoginVerifyViewModel.h
//  GBox
//
//  Created by jason on 2016/10/22.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GBViewModel.h"
#import "LoginViewModel.h"
@interface LoginVerifyViewModel : LoginViewModel

@property (nonatomic, strong, readonly) RACCommand* loginCommand;
@property (nonatomic, strong, readonly) RACCommand* nextCommand;
@property (nonatomic, strong, readonly) RACCommand* backCommand;
@property (nonatomic, copy) NSString* verifyCode;
@property (nonatomic, strong) NSNumber* loginResult;
@end
