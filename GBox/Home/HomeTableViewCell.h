//
//  HomeTableViewCell.h
//  GBox
//
//  Created by jason on 2016/10/24.
//  Copyright © 2016年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomerModel;

@interface HomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) BOOL orderStatus;
@property (nonatomic, strong) CustomerModel* customer;
@property (nonatomic, copy) NSString* createDate;
- (void)setOrderSum:(CGFloat)sum GoodNum:(NSUInteger)num;
@end
