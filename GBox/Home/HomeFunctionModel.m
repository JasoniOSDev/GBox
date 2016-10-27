//
//  HomeFunctionModel.m
//  GBox
//
//  Created by jason on 2016/10/23.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "HomeFunctionModel.h"

@implementation HomeFunctionModel


+ (instancetype)initWithICon:(NSString *)icon title:(NSString *)title{
    HomeFunctionModel* object = [[HomeFunctionModel alloc]initWithICon:icon title:title];
    return object;
}

- (instancetype)initWithICon:(NSString *)icon title:(NSString *)title{
    self = [super init];
    if (self){
        self.icon = icon;
        self.title = title;
    }
    return self;
}

@end
