//
//  GoodModel.m
//  GBox
//
//  Created by jason on 2016/10/24.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GoodModel.h"

@implementation GoodModel
+ (NSArray<NSString *> *)ignoredProperties{
    return @[@"imagePhoto"];
}

- (UIImage *)imagePhoto{
    return [UIImage imageWithData:_photo];
}

- (void)setImagePhoto:(UIImage *)imagePhoto{
    RLMRealm* realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    self.photo =  UIImageJPEGRepresentation(imagePhoto, 0.95);
    [realm commitWriteTransaction];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ID = [[NSUUID UUID]UUIDString];
        self.price = 0;
        self.stock = 0;
        self.sellNum = 0;
        self.imagePhoto = [UIImage imageNamed:@"Good_DefaultPhoto"];
    }
    return self;
}

- (void)modifyWithObject:(GoodModel *)object{
    //默认是第二次修改，所以一定是在数据库当中
    RLMRealm* realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    self.remark = object.remark;
    self.code = object.code;
    self.name = object.name;
    self.photo = object.photo;
    self.classify = object.classify;
    [realm commitWriteTransaction];
}

- (void)updatePrice:(float)price{
    RLMRealm* realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    self.price = price;
    [realm commitWriteTransaction];
}

- (void)updateStock:(int)modify{
    //可能增加可能减少
    RLMRealm* realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    self.stock += modify;
    [realm commitWriteTransaction];
}

- (void)updateSellNum:(int)add{
    RLMRealm* realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    self.sellNum += add;
    [realm commitWriteTransaction];
}


@end
