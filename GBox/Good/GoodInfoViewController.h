//
//  GoodInfoViewController.h
//  GBox
//
//  Created by jason on 2016/10/27.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GBTableViewController.h"
@class GoodInfoViewModel;
@interface GoodInfoViewController : GBTableViewController

@property (nonatomic, strong, readonly) GoodInfoViewModel* viewModel;
@end
