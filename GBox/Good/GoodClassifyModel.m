//
//  GoodClassifyModel.m
//  GBox
//
//  Created by jason on 2016/10/24.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GoodClassifyModel.h"

@implementation GoodClassifyModel

+ (instancetype)createClassifyWithName:(NSString *)name{
    GoodClassifyModel* object = [[GoodClassifyModel alloc]initWithName:name];
    RLMRealm* realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:object];
    [realm commitWriteTransaction];
    return object;
}

+ (instancetype)createClassifyWithName:(NSString *)name ChilfOfClassify:(GoodClassifyModel *)classify{
    GoodClassifyModel* object = [[GoodClassifyModel alloc]initWithName:name childOfClassify:classify];
    RLMRealm* realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:object];
    [classify.childClassify addObject:object];
    [realm commitWriteTransaction];
    return object;
}

+ (NSMutableArray<GoodClassifyModel *> *)AllFirstClassify{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"level == 0"];
    RLMResults<GoodClassifyModel*>* result = [GoodClassifyModel objectsWithPredicate:predicate];
    NSMutableArray* array = [NSMutableArray new];
    for (GoodClassifyModel* object in result){
        [array addObject:object];
    }
    return array;
}

+ (NSMutableArray<GoodClassifyModel *> *)AllSecondClassify{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"level != 0"];
    RLMResults<GoodClassifyModel*>* result = [GoodClassifyModel objectsWithPredicate:predicate];
    NSMutableArray* array = [NSMutableArray new];
    for (GoodClassifyModel* object in result){
        [array addObject:object];
    }
    return array;
}

- (instancetype)initWithName:(NSString*)name{
    self = [super init];
    if(self){
        self.name = name;
        self.ID = [[NSUUID UUID]UUIDString];
        self.superClassify = NULL;
        self.childClassify = NULL;
        self.level = 0;
    }
    return self;
}

- (instancetype)initWithName:(NSString*)name childOfClassify:(GoodClassifyModel*)classify{
    self = [self initWithName:name];
    if (self){
        self.superClassify = classify;
        self.ID = [classify.ID stringByAppendingString:[NSString stringWithFormat:@"-%@",[[NSUUID UUID]UUIDString]]];
        self.level = classify.level + 1;
    }
    return self;
}
@end
