//
//  OrderGoodModel.m
//  GBox
//
//  Created by jason on 2016/10/24.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "OrderGoodModel.h"
#import "OrderModel.h"
@implementation OrderGoodModel


+ (NSDictionary<NSString *,RLMPropertyDescriptor *> *)linkingObjectsProperties{
    return @{
             @"order":[RLMPropertyDescriptor descriptorWithClass:OrderModel.class propertyName:@"goods"]
             };
}
@end
