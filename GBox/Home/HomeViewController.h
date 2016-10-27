//
//  HomeViewController.h
//  GBox
//
//  Created by jason on 2016/10/20.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GBTableViewController.h"
#import "HomeViewModel.h"

@interface HomeViewController : GBTableViewController <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *LabelLogo;
@property (weak, nonatomic) IBOutlet UIImageView *ImageViewHeadPhoto;
@property (nonatomic, strong, readonly) HomeViewModel* viewModel;
@property (weak, nonatomic) IBOutlet UILabel *LabelUserName;
@end
