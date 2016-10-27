//
//  HomeFunctionsViewModel.h
//  GBox
//
//  Created by jason on 2016/10/23.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GBCollectionViewModel.h"

@class HomeFunctionModel;

@interface HomeFunctionsViewModel : GBCollectionViewModel

@property (nonatomic, copy) NSArray<HomeFunctionModel*>* dataSource;
@property (nonatomic,strong) NSNumber* scale;

- (CGSize)collectionViewSize;
- (CGSize)cellSizeForIndexPath:(NSIndexPath*)indexPath;
- (void)configureCell:(UICollectionViewCell*)cell AtIndexPath:(NSIndexPath*)indexPath;
@end
