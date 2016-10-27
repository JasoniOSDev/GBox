//
//  OrderGoodModel.h
//  GBox
//
//  Created by jason on 2016/10/24.
//  Copyright © 2016年 jason. All rights reserved.
//

@class GoodModel;
@interface OrderGoodModel : RLMObject
//用来记录一个订单当中买了哪个物品，数量多少以及其他的信息
@property BOOL type;
@property int num;
@property float realPrice;
@property float totalPrice;
@property NSString* ID;
@property NSString* orderRemark;
@property GoodModel* good;
@property (readonly)RLMLinkingObjects* order;
@end

RLM_ARRAY_TYPE(OrderGoodModel)
