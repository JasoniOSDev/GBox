//
//  CustomerModel.m
//  GBox
//
//  Created by jason on 2016/10/24.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "CustomerModel.h"
#import "UserGod.h"
@implementation CustomerModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ID = [[NSUUID UUID]UUIDString];
        self.headPhoto_Origin = [self fetchImage];
    }
    return self;
}

+ (NSArray<NSString *> *)ignoredProperties{
    return @[@"headPhoto_Low",@"headPhoto_Middle",@"headPhoto_Hight",@"headPhoto_Origin",@"totalCost"];
}

- (NSString *)orderCount{
    return [NSString stringWithFormat:@"%lu",(unsigned long)_orders.count];
}

- (NSString *)totalCost{
    float total = 0;
    for (OrderModel* object in _orders){
        total += object.totalPrice;
    }
    NSString* sumStr;
    if (total == floorf(total)){
        sumStr = [NSString stringWithFormat:@"%.f",total];
    }else{
        sumStr = [NSString stringWithFormat:@"%.1f",total];
    }
    return sumStr;
}

- (OrderGoodModel *)mostGood{
    //买的最多的物品
    RLMResults<OrderGoodModel*>* list = [_orderGoods sortedResultsUsingProperty:@"num" ascending:NO];
    return [list firstObject];
}

- (UIImage *)headPhoto_Origin{
    return [UIImage imageWithData:_headPhotoData_Origin];
}

- (UIImage *)headPhoto_Hight{
    return [UIImage imageWithData:_headPhotoData_Hight];
}

- (UIImage *)headPhoto_Middle{
    return [UIImage imageWithData:_headPhotoData_Middle];
}

- (UIImage *)headPhoto_Low{
    return [UIImage imageWithData:_headPhotoData_Low];
}

- (void)setHeadPhoto_Origin:(UIImage *)headPhoto_Origin{
    RLMRealm* realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    self.headPhotoData_Origin = UIImageJPEGRepresentation(headPhoto_Origin, 0.95);
    self.headPhotoData_Hight = UIImageJPEGRepresentation([headPhoto_Origin GB_imageByResizeToSize:CGSizeMake(100, 100)], 0.95);
    self.headPhotoData_Middle = UIImageJPEGRepresentation([headPhoto_Origin GB_imageByResizeToSize:CGSizeMake(70, 70)], 0.95);
    self.headPhotoData_Low  = UIImageJPEGRepresentation([headPhoto_Origin GB_imageByResizeToSize:CGSizeMake(50, 50)], 0.95);
    [realm commitWriteTransaction];
}

- (UIImage*)fetchImage{
    NSUInteger index = (NSUInteger)[[NSDate new]timeIntervalSince1970]%6;
    UIImage* image = [UIImage imageNamed:[@"ProfilePhoto-" stringByAppendingString:[[NSString alloc]initWithFormat:@"%lu",(unsigned long)index ]]];
    return image;
}
@end
