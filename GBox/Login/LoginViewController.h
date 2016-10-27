//
//  LoginViewController.h
//  GBox
//
//  Created by jason on 2016/10/20.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GBViewController.h"
#import "LoginViewModel.h"

@interface LoginViewController : GBViewController

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, strong, readonly) LoginViewModel* viewModel;

@end
