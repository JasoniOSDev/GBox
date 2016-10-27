//
//  GoodSearchTipViewController.m
//  GBox
//
//  Created by jason on 2016/10/25.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GoodSearchTipViewController.h"
#import "GoodSearchTipViewModel.h"
#import "GBButton.h"
#import "GoodClassifyModel.h"
#import "GoodSearchHistoryModel.h"
@interface GoodSearchTipViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong, readwrite) GoodSearchTipViewModel* viewModel;
@property (nonatomic, weak)UICollectionView* collectionView;
@end

@implementation GoodSearchTipViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)bindViewModel{
    [super bindViewModel];
    [[self.viewModel.classifySelectCommand.executionSignals flatten] subscribeNext:^(NSArray* object) {
        [self.collectionView moveItemAtIndexPath:object[0] toIndexPath:object[1]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView reloadItemsAtIndexPaths:@[object[1]]];
        });
    }];
    [[self.viewModel.classifyCancelCommand.executionSignals flatten] subscribeNext:^(NSArray* object) {
        [self.collectionView moveItemAtIndexPath:object[0] toIndexPath:object[1]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView reloadItemsAtIndexPaths:@[object[1]]];
        });
    }];
}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1){
        return [self.viewModel.dataSource[1] count];
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView CellforIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return [tableView dequeueReusableCellWithIdentifier:@"Item"];
            break;
        default:
            return [tableView dequeueReusableCellWithIdentifier:@"History"];
            break;
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    switch (indexPath.section) {
        case 0:
            self.collectionView = [cell viewWithTag:101];
            break;
        default:
            cell.textLabel.text = [(GoodSearchHistoryModel*)object name];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return [self.viewModel tableView:tableView heightForRowAtIndexPath:indexPath];
            break;
        default:
            return 30;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"分类";
        case 1:
            return @"历史记录";
        default:
            return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel* label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1];
    label.font = [UIFont fontWithName:@"FZLanTingHei-L-GBK" size:14];
    label.text = [self tableView:tableView titleForHeaderInSection:section];
    return label;
}

#pragma mark- collectionDataSouce

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.viewModel.dataSource[0][section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"%ld",(long)indexPath.section] forIndexPath:indexPath];
    GoodClassifyModel* object = self.viewModel.dataSource[0][indexPath.section][indexPath.row];
    GBButton* button = [cell viewWithTag:101];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    button.imageViewPosition = GBButtonImageViewPositionLeft;
    [button setTitle:object.name forState:UIControlStateNormal];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.viewModel cellSizeOfItemAtIndexPath:indexPath];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < 2){
        [self.viewModel.classifyCancelCommand execute:indexPath];
    }else{
        [self.viewModel.classifySelectCommand execute:indexPath];
    }
}


@end
