//
//  GoodViewController.m
//  GBox
//
//  Created by jason on 2016/10/25.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GoodViewController.h"
#import "GoodViewModel.h"
#import "GoodSearchTipViewModel.h"
#import "GoodSearchTipViewController.h"
#import "GoodInfoViewController.h"
@interface GoodViewController ()
@property (weak, nonatomic) IBOutlet UIView *ViewTool;
@property (weak, nonatomic) IBOutlet UITextField *TextFieldSearch;
@property (weak, nonatomic) IBOutlet UIButton *ButtonAdd;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintSearchFieldWidth;
@property (nonatomic, strong)GoodSearchTipViewModel* tipViewModel;
@property (nonatomic, strong)GoodSearchTipViewController* tipViewController;
@property (nonatomic, strong, readwrite)GoodViewModel* viewModel;
@end

@implementation GoodViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [self configureTipViewController];
    @weakify(self)
    [[_ButtonAdd rac_signalForControlEvents:UIControlEventTouchUpInside]
                              subscribeNext:^(UIButton* button) {
                                 @strongify(self)
                                 if ([[button currentTitle] isEqualToString:@"新增"]){
                                     [self performSegueWithIdentifier:@"showInfo" sender:nil];
                                 }else{
                                     [self.TextFieldSearch resignFirstResponder];
                                     self.tableView.hidden = NO;
                                     self.ViewTool.hidden = NO;
                                     [self.ButtonAdd setTitle:@"新增" forState:UIControlStateNormal];
                                 }
    }];
}

- (void)bindViewModel{
    [super bindViewModel];
    @weakify(self)
    [[[[_TextFieldSearch
                     rac_textSignal]
                     skip:1]
                      map:^(NSString* text) {return @((text == NULL || [text isEqualToString:@""]));}]
            subscribeNext:^(NSNumber* value) {
                         @strongify(self)
                         self.tableView.hidden = value.boolValue;
                         self.ViewTool.hidden = value.boolValue;
                     }];
    
    [[_TextFieldSearch rac_signalForControlEvents:UIControlEventEditingDidBegin]
                                    subscribeNext:^(id x) {
                           @strongify(self)
                           [self.ButtonAdd setTitle:@"完成" forState:UIControlStateNormal];
    }];
    
    RAC(self.viewModel,searchText) = [_TextFieldSearch rac_textSignal];
}

- (void)configureTipViewController{
    self.tipViewModel = [GoodSearchTipViewModel new];
    self.tipViewController = [GoodSearchTipViewController initWithViewModel:self.tipViewModel];
    [self addChildViewController:self.tipViewController];
    [self.view insertSubview:self.tipViewController.view belowSubview:self.tableView];
    [self.tipViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.tableView);
        make.top.equalTo(self.tableView).with.offset(-55);
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.ButtonAdd sendActionsForControlEvents:UIControlEventTouchUpInside];
    return YES;
}

@end
