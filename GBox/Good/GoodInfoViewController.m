//
//  GoodInfoViewController.m
//  GBox
//
//  Created by jason on 2016/10/27.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GoodInfoViewController.h"
#import "GoodInfoViewModel.h"
@interface GoodInfoViewController ()

@property (weak, nonatomic) IBOutlet UIView *ViewInfo;
@property (nonatomic, strong, readwrite)GoodInfoViewModel* viewModel;
@end

@implementation GoodInfoViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIEdgeInsets)contentInset{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
