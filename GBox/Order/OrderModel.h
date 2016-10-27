//
//  OrderModel.h
//  GBox
//
//  Created by jason on 2016/10/24.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "OrderGoodModel.h"

@class CustomerModel;
@class UserGod;

@interface OrderModel : RLMObject

@property NSString* ID;
@property UserGod* user;
@property CustomerModel* customer;
@property NSDate* createDate;
@property RLMArray<OrderGoodModel*><OrderGoodModel>* goods;
@property BOOL status;//false未完成订单
@property (nonatomic, assign) int goodNum;
@property (nonatomic, assign) float totalPrice;
@property (nonatomic, strong, readonly) NSString* createDateStr;
+ (RLMResults<OrderModel*>*)currentOrders;
+ (RLMResults<OrderModel*>*)ordersWithCustomer:(CustomerModel*)customer;
@end

RLM_ARRAY_TYPE(OrderModel)
