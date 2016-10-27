//
//  LoginVerifyViewController.h
//  GBox
//
//  Created by jason on 2016/10/21.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GBViewController.h"

@class LoginVerifyViewModel;

@interface LoginVerifyViewController : GBViewController

@property (weak, nonatomic) IBOutlet UIImageView *backView;
@property (weak, nonatomic) IBOutlet UILabel *LabelLogo;
@property (weak, nonatomic) IBOutlet UIImageView *ImageViewHeadPhoto;
@property (nonatomic, assign) CGFloat constraintLogoBottomConstant;
@property (nonatomic, strong) LoginVerifyViewModel* viewModel;

@end
