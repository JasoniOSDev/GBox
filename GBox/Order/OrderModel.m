//
//  OrderModel.m
//  GBox
//
//  Created by jason on 2016/10/24.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "OrderModel.h"
#import "UserGod.h"
#import "CustomerModel.h"
@implementation OrderModel

+ (RLMResults<OrderModel *> *)ordersWithCustomer:(CustomerModel *)customer{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"customer.ID == %@",customer.ID];
    RLMResults<OrderModel *>* results = [OrderModel objectsWithPredicate:predicate];
    return results;
}

+ (RLMResults<OrderModel *> *)getOrdersWithUserID:(NSString*)userID{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"user.userID == %@",userID];
    RLMResults<OrderModel *>* results = [OrderModel objectsWithPredicate:predicate];
    return results;
}

+ (RLMResults<OrderModel *> *)currentOrders{
    return [OrderModel getOrdersWithUserID:[GBUserDefault shareUserDefault].userID];
}

+ (NSArray<NSString *> *)ignoredProperties{
    return @[@"goodNum",@"totalPrice",@"createDateStr"];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ID = [[NSUUID UUID] UUIDString];
        self.user = [UserGod currentUser];
        self.createDate = [NSDate new];
        self.status = false;
    }
    return self;
}

static NSDateFormatter* formatter;
- (NSString *)createDateStr{
    NSTimeInterval interval = -[self.createDate timeIntervalSinceNow];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
    });
    formatter.dateFormat = @"dd";
    int createDay = [[formatter stringFromDate:self.createDate] intValue];
    int currentDay = [[formatter stringFromDate:[NSDate new]] intValue];
    formatter.dateFormat = @"HH:mm";
    if (createDay != currentDay){
        int dis = createDay - createDay;
        switch (dis) {
            case 1:
                return [@"昨天" stringByAppendingString:[formatter stringFromDate:self.createDate]];break;
            case 2:
                return [@"前天" stringByAppendingString:[formatter stringFromDate:self.createDate]];break;
            case 3:
                return [@"大前天" stringByAppendingString:[formatter stringFromDate:self.createDate]];break;
            case 4:
                return [@"大前天" stringByAppendingString:[formatter stringFromDate:self.createDate]];break;
            default:
                formatter.dateFormat = @"yyyy";
                int createYear = [[formatter stringFromDate:self.createDate] intValue];
                int currentYear = [[formatter stringFromDate:[NSDate new]] intValue];
                if(createYear != currentYear){
                    formatter.dateFormat = @"yyyy/MM/dd HH:mm";
                    return [formatter stringFromDate:self.createDate];
                }
                formatter.dateFormat = @"MM/dd HH:mm";
                return [formatter stringFromDate:self.createDate];break;
        }
    }
    
    if(interval / 60  < 1){
        return @"刚刚";
    }
    if(interval / 60 < 60){
        return [NSString stringWithFormat:@"%.f分钟前",interval/60];
    }
    
    return [formatter stringFromDate:self.createDate];
}

- (int)goodNum{
    int total = 0;
    for (OrderGoodModel* object in _goods){
        total += object.num;
    }
    return total;
}

- (float)totalPrice{
    float total = 0.0;
    for (OrderGoodModel* object in _goods){
        total += object.totalPrice;
    }
    return total;
}

@end
