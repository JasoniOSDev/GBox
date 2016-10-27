//
//  GBViewController.m
//  GBox
//
//  Created by jason on 2016/10/20.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GBViewController.h"

@interface GBViewController ()
@property (nonatomic, strong, readwrite) GBViewModel* viewModel;
@end

@implementation GBViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    GBViewController* viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)]subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController bindViewModel];
    }];
    
    return viewController;
}

+ (instancetype)initWithViewModel:(GBViewModel *)viewModel{
    GBViewController* viewController = [viewModel.storyboard instantiateViewControllerWithIdentifier:viewModel.viewControllerName];
        viewController.viewModel = viewModel;
    return viewController;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)bindViewModel{
    RAC(self,title) = RACObserve(self.viewModel, title);
}

@end
