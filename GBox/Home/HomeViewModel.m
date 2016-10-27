//
//  HomeViewModel.m
//  GBox
//
//  Created by jason on 2016/10/20.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "HomeViewModel.h"
#import "OrderModel.h"
@implementation HomeViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        RLMResults<OrderModel*>* result = [OrderModel currentOrders];
        NSPredicate* predicatePending = [NSPredicate predicateWithFormat:@"status == NO"];
        NSPredicate* predicateCompletion = [NSPredicate predicateWithFormat:@"status == YES"];
        RLMResults<OrderModel*>* resultPending = [result objectsWithPredicate:predicatePending];
        
        RLMResults<OrderModel*>* resultCompletion = [result objectsWithPredicate:predicateCompletion];
        self.dataSource = @[resultPending,resultCompletion];
    }
    return self;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
@end
