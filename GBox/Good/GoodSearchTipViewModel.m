//
//  GoodSearchTipViewModel.m
//  GBox
//
//  Created by jason on 2016/10/25.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GoodSearchTipViewModel.h"
#import "GoodClassifyModel.h"
#import "GoodSearchHistoryModel.h"
#import "GBButton.h"
@implementation GoodSearchTipViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSMutableArray<GoodClassifyModel*>* firstClassifies = [GoodClassifyModel AllFirstClassify];
        NSMutableArray<GoodClassifyModel*>* secondClassifies = [GoodClassifyModel AllSecondClassify];
        self.dataSource = @[@[[NSMutableArray new],[NSMutableArray new],firstClassifies,secondClassifies],[GoodSearchHistoryModel allObjects]];
        self.classifySelectCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSIndexPath* indexPath) {
            GoodClassifyModel* object = self.dataSource[0][indexPath.section][indexPath.row];
            [self.dataSource[0][indexPath.section] removeObject:object];
            [self.dataSource[0][indexPath.section&1] addObject:object];
            return [RACSignal return:@[indexPath,[NSIndexPath indexPathForRow:[self.dataSource[0][indexPath.section&1] count] - 1 inSection:indexPath.section&1],object]];
        }];
        self.classifyCancelCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSIndexPath* indexPath) {
            GoodClassifyModel* object = self.dataSource[0][indexPath.section][indexPath.row];
            [self.dataSource[0][indexPath.section] removeObject:object];
            [self.dataSource[0][indexPath.section+2] addObject:object];
            return [RACSignal return:@[indexPath,[NSIndexPath indexPathForRow:[self.dataSource[0][indexPath.section+2] count] - 1 inSection:indexPath.section+2],object]];
        }];
    }
    return self;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat ans = 0;
    CGSize singleSize = indexPath.section < 2? CGSizeMake(80, 30) : CGSizeMake(60, 30);
    ans += ceil([self.dataSource[0][0] count]/4.0);
    ans += ceil([self.dataSource[0][1] count]/4.0);
    ans += ceil([self.dataSource[0][2] count]/5.0);
    ans += ceil([self.dataSource[0][3] count]/5.0);
    return (ans + 1) * (singleSize.height+7);
}

- (CGSize)cellSizeOfItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < 2){
        return CGSizeMake(80, 30);
    }
    return CGSizeMake(60, 30);
}
@end
