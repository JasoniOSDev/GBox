//
//  LoginViewController.m
//  GBox
//
//  Created by jason on 2016/10/20.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginVerifyViewController.h"
#import "LoginVerifyViewModel.h"
@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintContaintViewBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintLogoBottom;
@property (weak, nonatomic) IBOutlet UILabel *LabelLogo;
@property (weak, nonatomic) IBOutlet UITextField *TextFieldPhoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *ButtonNext;
@property (nonatomic, strong, readwrite) LoginViewModel* viewModel;
@property (nonatomic, assign) BOOL nofirstLoad;
@property (weak, nonatomic) IBOutlet UIImageView *ImageViewHeadPhoto;

@end

@implementation LoginViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    @weakify(self)
    [[self
         rac_signalForSelector:@selector(textFieldShouldReturn:)
         fromProtocol:@protocol(UITextFieldDelegate)]
         subscribeNext:^(id x) {
             @strongify(self)
             if (self.ButtonNext.enabled) {
                 [_TextFieldPhoneNumber resignFirstResponder];
                 [self performSegueWithIdentifier:@"gotoVerify" sender:self];
             }
         }];
    [[[NSNotificationCenter defaultCenter]
                           rac_addObserverForName:UIKeyboardWillShowNotification object:nil]
                           subscribeNext:^(id x) {
                               _ConstraintContaintViewBottom.constant = 40;
                               [self.view layoutIfNeeded];
                           }];
    [[[NSNotificationCenter defaultCenter]
                          rac_addObserverForName:UIKeyboardWillHideNotification object:nil]
                          subscribeNext:^(id x) {
                              _ConstraintContaintViewBottom.constant = 0;
                              [self.view layoutIfNeeded];
                          }];
    _TextFieldPhoneNumber.delegate = self;
    [_TextFieldPhoneNumber becomeFirstResponder];
    _ImageViewHeadPhoto.layer.borderColor = [[UIColor whiteColor]CGColor];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!_nofirstLoad){
        _nofirstLoad = YES;
        [UIView animateWithDuration:1.0 animations:^{
            CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
            _ConstraintLogoBottom.constant = screenHeight - 168;
            CGAffineTransform transform = CGAffineTransformMakeScale(1.67, 1.67);
            _LabelLogo.transform = transform;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            _LabelLogo.transform = CGAffineTransformMakeScale(1,1);
            _LabelLogo.font = [UIFont fontWithName:@"FZCuYuan-M03" size:50];
        }];
        _TextFieldPhoneNumber.transform = CGAffineTransformMakeScale(0, 1);
        [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _TextFieldPhoneNumber.transform = CGAffineTransformMakeScale(1, 1);
            _TextFieldPhoneNumber.alpha = 1;
        } completion:^(BOOL finished) {
            _ButtonNext.alpha = 1;
        }];
    }
}


- (void)bindViewModel{
    [super bindViewModel];
    @weakify(self)
    RAC(_ImageViewHeadPhoto,hidden) = [RACObserve(_ButtonNext, enabled)
                                       map:^(NSNumber* value) {
                                            return @(!value.boolValue);
                                       }];
    RAC(_ImageViewHeadPhoto,image) = RACObserve(self.viewModel, headPhoto);
    RAC(self.viewModel, headPhoto) = [[RACObserve(self.viewModel, user)
                                       map:^(UserGod* user) {
                                            if (user != NULL){
                                                return user.imageHeadPhoto_Login;
                                            }
                                            return [UIImage imageNamed:@"Login_defaultHead"];}]
                                       distinctUntilChanged];
    RAC(self.viewModel,user) = [[self.viewModel.validInfoSignal
                                 map:^(NSNumber* value) {
                                       if (value.boolValue){
                                           return [UserGod userWithPhoneNumber:self.viewModel.phoneNumber];
                                       }
                                       return (UserGod*)NULL;}]
                                distinctUntilChanged];

    RAC(self.viewModel,phoneNumber) = self.TextFieldPhoneNumber.rac_textSignal;
    RAC(_ButtonNext,enabled) = self.viewModel.validInfoSignal;
    [[_ButtonNext rac_signalForControlEvents:UIControlEventTouchUpInside]
                  subscribeNext:^(UIButton* btn) {
                     @strongify(self)
                     [_TextFieldPhoneNumber resignFirstResponder];
                     [self performSegueWithIdentifier:@"gotoVerify" sender:self];
                 }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    LoginVerifyViewController* viewController = [segue destinationViewController];
    viewController.viewModel = [LoginVerifyViewModel new];
    viewController.viewModel.phoneNumber = self.viewModel.phoneNumber;
    viewController.viewModel.user = self.viewModel.user;
    viewController.viewModel.headPhoto = self.viewModel.headPhoto;
    viewController.constraintLogoBottomConstant = _ConstraintLogoBottom.constant - (95.43-81.5);
}

@end
