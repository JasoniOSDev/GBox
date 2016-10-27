//
//  CustomerModel.h
//  GBox
//
//  Created by jason on 2016/10/24.
//  Copyright © 2016年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"
#import "OrderGoodModel.h"
@interface CustomerModel : RLMObject

@property NSString* ID;
@property NSString* name;
@property NSString* phoneNumber;
@property NSString* address;
@property NSString* detailAddress;
@property NSString* remark;
@property NSDate* bornDate;
@property RLMArray<OrderModel*><OrderModel>* orders;
@property RLMArray<OrderGoodModel*><OrderGoodModel>* orderGoods;
//orderGoods用于统计单个物品的消费情况

@property NSData* headPhotoData_Origin;
@property NSData* headPhotoData_Hight;
@property NSData* headPhotoData_Middle;
@property NSData* headPhotoData_Low;
@property (nonatomic, strong,readonly) NSString* totalCost;
@property (nonatomic, strong,readonly) NSString* orderCount;
@property (nonatomic, strong,readonly) OrderGoodModel* mostGood;
@property (nonatomic, strong) UIImage* headPhoto_Low;
@property (nonatomic, strong) UIImage* headPhoto_Middle;
@property (nonatomic, strong) UIImage* headPhoto_Hight;
@property (nonatomic, strong) UIImage* headPhoto_Origin;

@end
