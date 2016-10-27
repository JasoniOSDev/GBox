//
//  GBViewController.h
//  GBox
//
//  Created by jason on 2016/10/20.
//  Copyright © 2016年 jason. All rights reserved.
//


@interface GBViewController : UIViewController

@property (nonatomic, strong, readonly) GBViewModel* viewModel;
@property (nonatomic, strong) UIView* snapshot;

+ (instancetype)initWithViewModel:(GBViewModel*)viewModel;
- (void)bindViewModel;

@end
