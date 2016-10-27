//
//  HomeFunctionsViewModel.m
//  GBox
//
//  Created by jason on 2016/10/23.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "HomeFunctionsViewModel.h"
#import "HomeFunctionModel.h"
#import "HomeFunctionsCollectionViewCell.h"
@implementation HomeFunctionsViewModel

@dynamic dataSource;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = @[[HomeFunctionModel initWithICon:@"Get" title:@"入库"],
                            [HomeFunctionModel initWithICon:@"Put" title:@"出库"],
                            [HomeFunctionModel initWithICon:@"Good" title:@"物品"],
                            [HomeFunctionModel initWithICon:@"Customer" title:@"客户"],
                            [HomeFunctionModel initWithICon:@"Order" title:@"订单"]];
    }
    return self;
}

- (CGSize)cellSizeForIndexPath:(NSIndexPath *)indexPath{
    if (self.scale.boolValue){
        return CGSizeMake(40, 50);
    }
    return CGSizeMake(40, 70);
}

- (CGSize)collectionViewSize{
    CGSize itemSize = [self cellSizeForIndexPath:[NSIndexPath new]];
    CGFloat width = itemSize.width * self.dataSource.count +  20 * (self.dataSource.count - 1);
    return CGSizeMake(width, itemSize.height);
}

- (void)configureCell:(UICollectionViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    HomeFunctionsCollectionViewCell* myCell = (HomeFunctionsCollectionViewCell*)cell;
    HomeFunctionModel* object = [self.dataSource objectAtIndex:indexPath.row];
    [myCell setICon:object.icon title:object.title];
}
@end
