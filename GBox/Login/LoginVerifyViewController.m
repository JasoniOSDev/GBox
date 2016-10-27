//
//  LoginVerifyViewController.m
//  GBox
//
//  Created by jason on 2016/10/21.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "LoginVerifyViewController.h"
#import "GBButton.h"
#import "LoginVerifyViewModel.h"
#import "HomeViewController.h"
@interface LoginVerifyViewController () <UITextFieldDelegate,UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintHeadPhotoBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintTipViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintLogoBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintContaintViewBottom;
@property (weak, nonatomic) IBOutlet GBButton *ButtonBack;
@property (weak, nonatomic) IBOutlet UITextField *TextfieldVerifyCode;
@property (weak, nonatomic) IBOutlet UIButton *ButtonEnter;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *IndicatorViewLogining;
@property (weak, nonatomic) IBOutlet UILabel *LabelTip;

@end

@implementation LoginVerifyViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewModel.nextCommand execute:nil];
    _ConstraintLogoBottom.constant = _constraintLogoBottomConstant;
    [[[NSNotificationCenter defaultCenter]
                           rac_addObserverForName:UIKeyboardWillShowNotification object:nil]
                           subscribeNext:^(id x) {
                               _ConstraintContaintViewBottom.constant = 100;
                               [self.view layoutIfNeeded];
                           }];
    [[[NSNotificationCenter defaultCenter]
                          rac_addObserverForName:UIKeyboardWillHideNotification object:nil]
                          subscribeNext:^(id x) {
                              _ConstraintContaintViewBottom.constant = 0;
                              [self.view layoutIfNeeded];
                          }];
    _ImageViewHeadPhoto.layer.borderColor = [[UIColor whiteColor] CGColor];
    _ImageViewHeadPhoto.image = self.viewModel.headPhoto;
    [_TextfieldVerifyCode becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _TextfieldVerifyCode.transform = CGAffineTransformMakeScale(0, 1);
    [UIView animateWithDuration:0.3 animations:^{
        _TextfieldVerifyCode.transform = CGAffineTransformMakeScale(1, 1);
    }];
    _ButtonEnter.transform = CGAffineTransformMakeScale(0, 1);
    [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
        _ButtonEnter.alpha = 1;
        _ButtonEnter.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.3 animations:^{
                _ButtonBack.alpha = 1;
                UIImageView* imageView = _ButtonBack.imageView;
                imageView.frame = CGRectMake(imageView.frame.origin.x - 5, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
            }];
        }
    }];
}

- (void)bindViewModel{
    [super bindViewModel];
    @weakify(self)
    RAC(self.ImageViewHeadPhoto,image) = [[RACObserve(self.viewModel, user)
                                            skip:1]
                                            map:^(UserGod* user) {
                                                return user.imageHeadPhoto_Login;
                                            }];
    RAC(self.viewModel,verifyCode) = [_TextfieldVerifyCode rac_textSignal];
    RAC(_ButtonEnter,enabled) = [[RACObserve(self.viewModel, verifyCode)
                                           map:^(NSString* code) {return @([code length] == 6);}]
                                           distinctUntilChanged];
    [[_TextfieldVerifyCode rac_textSignal]
                          subscribeNext:^(id x) {
                              @strongify(self)
                              self.LabelTip.hidden = YES;
                          }];
    
    [[RACObserve(self.viewModel,loginResult)
              skip:1]
              subscribeNext:^(NSNumber* value) {
                  @strongify(self)
                  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(500 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
                      _LabelTip.hidden = YES;
                      _LabelTip.text = @"正在登录";
                      _IndicatorViewLogining.hidden = YES;
                      if (value.boolValue) {
                          self.viewModel.user = [UserGod LoginWithPhoneNumber:self.viewModel.phoneNumber];
                          [self showHomeViewController];
                      }else{
                          [UIView animateWithDuration:0.5 animations:^{
                              _ConstraintHeadPhotoBottom.constant = 35;
                              _ImageViewHeadPhoto.transform = CGAffineTransformIdentity;
                              [self.view layoutIfNeeded];
                          } completion:^(BOOL finished) {
                              [UIView animateWithDuration:0.3 animations:^{
                                  _TextfieldVerifyCode.hidden = NO;
                                  _ButtonEnter.hidden = NO;
                                  _ButtonBack.hidden = NO;
                                  [self.view layoutIfNeeded];
                              } completion:^(BOOL finished) {
                                  _IndicatorViewLogining.hidden = YES;
                                  _LabelTip.hidden = NO;
                                  _LabelTip.text = @"验证码错误";
                                  [self.view layoutIfNeeded];
                              }];
                          }];
                      }
                  });
              }];
    [[_ButtonBack rac_signalForControlEvents:UIControlEventTouchUpInside]
                  subscribeNext:^(id x) {
                     @strongify(self)
                     [self.TextfieldVerifyCode resignFirstResponder];
                     [self.navigationController popViewControllerAnimated:NO];
                     [self.viewModel.backCommand execute:nil];
                 }];
    [[_ButtonEnter rac_signalForControlEvents:UIControlEventTouchUpInside]
                  subscribeNext:^(id x) {
                      @strongify(self)
                      [self.TextfieldVerifyCode resignFirstResponder];
                      [self.viewModel.loginCommand execute:nil];
                      _LabelTip.hidden = NO;
                      _LabelTip.text = @"正在登录";
                      _IndicatorViewLogining.hidden = NO;
                      [_IndicatorViewLogining startAnimating];
                      [self.view layoutIfNeeded];
                      [UIView animateWithDuration:0.5 animations:^{
                          _TextfieldVerifyCode.hidden = YES;
                          _ButtonEnter.hidden = YES;
                          _ButtonBack.hidden = YES;
                          _ConstraintHeadPhotoBottom.constant = -10;
                          _ImageViewHeadPhoto.transform = CGAffineTransformMakeScale(1.3, 1.3);
                          [self.view layoutIfNeeded];
                      }];
                  }];
}

- (void)showHomeViewController{
    HomeViewModel* homeViewModel = [HomeViewModel new];
    homeViewModel.user = self.viewModel.user;
    HomeViewController* viewController = [HomeViewController initWithViewModel:homeViewModel];
    UINavigationController* destinationViewController = [[UINavigationController alloc]initWithRootViewController:viewController];
    destinationViewController.transitioningDelegate = self;
    [self presentViewController:destinationViewController animated:YES completion:NULL];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark- 转场动画

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView* containtView = [transitionContext containerView];
    LoginVerifyViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromVC = [[(UINavigationController*)fromVC childViewControllers]lastObject];
    HomeViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC = [[(UINavigationController*)toVC childViewControllers]lastObject];
    UIView* toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView* logoSnapShot = [fromVC.LabelLogo snapshotViewAfterScreenUpdates:NO];
    UIView* photoSnapShot = [fromVC.ImageViewHeadPhoto snapshotViewAfterScreenUpdates:NO];
    logoSnapShot.frame = [containtView convertRect:fromVC.LabelLogo.frame fromView:fromVC.LabelLogo.superview];
    photoSnapShot.frame =  [containtView convertRect:fromVC.ImageViewHeadPhoto.frame fromView:fromVC.ImageViewHeadPhoto.superview];
    fromVC.LabelLogo.hidden = YES;
    fromVC.ImageViewHeadPhoto.hidden = YES;
    toVC.LabelLogo.hidden = YES;
    toVC.ImageViewHeadPhoto.hidden = YES;
    toVC.LabelUserName.hidden = YES;
    toVC.collectionView.hidden = YES;
    UIView* backView = [fromVC.backView snapshotViewAfterScreenUpdates:NO];
    backView.frame = [containtView convertRect:fromVC.view.frame fromView:fromVC.view.superview];
    [containtView addSubview:toView];
    [containtView addSubview:backView];
    [containtView addSubview:logoSnapShot];
    [containtView addSubview:photoSnapShot];
    [toVC.view layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        backView.alpha = 0;
        logoSnapShot.frame = [containtView convertRect:toVC.LabelLogo.frame fromView:toVC.LabelLogo.superview];
        photoSnapShot.frame = [containtView convertRect:toVC.ImageViewHeadPhoto.frame fromView:toVC.ImageViewHeadPhoto.superview];
    } completion:^(BOOL finished) {
        [fromVC.view removeFromSuperview];
        [backView removeFromSuperview];
        [logoSnapShot removeFromSuperview];
        [photoSnapShot removeFromSuperview];
        toVC.LabelLogo.hidden = NO;
        toVC.ImageViewHeadPhoto.hidden = NO;
        toVC.LabelUserName.hidden = NO;
        toVC.collectionView.hidden = NO;
        [toVC.collectionView reloadData];
        _Bool cancel = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!cancel];
    }];
}

@end
