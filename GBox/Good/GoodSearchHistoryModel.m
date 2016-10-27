//
//  GoodSearchHistoryModel.m
//  GBox
//
//  Created by jason on 2016/10/25.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GoodSearchHistoryModel.h"

@implementation GoodSearchHistoryModel

+ (void)createHistoryWithName:(NSString *)name{
    GoodSearchHistoryModel* object = [[GoodSearchHistoryModel alloc]initWithName:name];
    RLMRealm* realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:object];
    [realm commitWriteTransaction];
}

+ (void)DeleteAll{
    RLMRealm* realm = [RLMRealm defaultRealm];
    RLMResults<GoodSearchHistoryModel*>* results = [GoodSearchHistoryModel allObjects];
    [realm beginWriteTransaction];
    [realm deleteObjects:results];
    [realm commitWriteTransaction];
}

- (instancetype)initWithName:(NSString*)name{
    self = [super init];
    if(self){
        self.name = name;
        self.date = [NSDate new];
    }
    return self;
}
@end
