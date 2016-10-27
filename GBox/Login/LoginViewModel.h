//
//  LoginViewModel.h
//  GBox
//
//  Created by jason on 2016/10/20.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GBViewModel.h"
#import "UserGod.h"

@interface LoginViewModel : GBViewModel

@property (nonatomic, copy) NSString* phoneNumber;
@property (nonatomic, strong) UIImage* headPhoto;
@property (nonatomic, strong) UserGod* user;
@property (nonatomic, strong, readonly) RACSignal* validInfoSignal;

@end
