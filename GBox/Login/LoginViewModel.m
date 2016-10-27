//
//  LoginViewModel.m
//  GBox
//
//  Created by jason on 2016/10/20.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "LoginViewModel.h"

@interface LoginViewModel ()

@property (nonatomic, strong, readwrite) RACSignal* validInfoSignal;

@end


@implementation LoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.validInfoSignal = [[RACObserve(self, phoneNumber)
                                 map:^(NSString* phoneNumber){
                                NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
                                NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
                                return @([phoneTest evaluateWithObject:phoneNumber]);
                            }]
                                distinctUntilChanged];
        
    }
    return self;
}
@end
