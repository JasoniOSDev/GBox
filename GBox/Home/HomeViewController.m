//
//  HomeViewController.m
//  GBox
//
//  Created by jason on 2016/10/20.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "HomeViewController.h"
#import "GBTableViewModel.h"
#import "LoginViewController.h"
#import "HomeFunctionsViewModel.h"
#import "HomeFunctionsCollectionViewCell.h"
#import "HomeTableViewCell.h"
#import "GoodViewController.h"
#import "GoodViewModel.h"
#import "GoodClassifyModel.h"
#import "GoodSearchHistoryModel.h"
@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintCollectionViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintCollectionViewWidth;
@property (nonatomic, strong, readwrite) HomeViewModel* viewModel;
@property (nonatomic, strong, readwrite) HomeFunctionsViewModel* funcsViewModel;
@property (nonatomic, copy) NSDictionary* destViewControllerDict;
@end

@implementation HomeViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    _funcsViewModel = [HomeFunctionsViewModel new];
    [self.navigationController setNavigationBarHidden:YES];
    [self configureCollectionView];
    [self configureTableView];
    _destViewControllerDict = @{
                                @2:[GoodViewController initWithViewModel:[GoodViewModel new]]
                                };
//    [GoodClassifyModel createClassifyWithName:@"香蕉"];
//    [GoodClassifyModel createClassifyWithName:@"苹果"];
//    [GoodClassifyModel createClassifyWithName:@"小辣椒"];
//    [GoodClassifyModel createClassifyWithName:@"猕猴桃"];
//    [GoodClassifyModel createClassifyWithName:@"芭乐"];
//    [GoodClassifyModel createClassifyWithName:@"西瓜"];
//    GoodClassifyModel* object4 = [GoodClassifyModel createClassifyWithName:@"巨无霸汉堡"];
//    [GoodClassifyModel createClassifyWithName:@"双层汉堡" ChilfOfClassify:object4];
//    [GoodSearchHistoryModel createHistoryWithName:@"香蕉"];
//    [GoodSearchHistoryModel createHistoryWithName:@"苹果"];
//    [GoodSearchHistoryModel createHistoryWithName:@"小辣椒"];
//    [GoodSearchHistoryModel createHistoryWithName:@"巨无霸汉堡"];
}

- (void)configureTableView{
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)configureCollectionView{
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeFunctionsCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HomeFunctionsCollectionViewCell"];
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumInteritemSpacing = 20;
    flowlayout.minimumLineSpacing = 0;
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [_collectionView setCollectionViewLayout:flowlayout];
    _ConstraintCollectionViewWidth.constant = self.funcsViewModel.collectionViewSize.width;
}

- (void)bindViewModel{
    [super bindViewModel];
    @weakify(self)
    [RACObserve(self.funcsViewModel, scale)
                     subscribeNext:^(NSNumber* scale) {
                         @strongify(self)
                         dispatch_async(dispatch_get_main_queue(), ^{
                             [UIView animateWithDuration:0.3 animations:^{
                                 self.ConstraintCollectionViewHeight.constant = scale.boolValue ? 50 : 70;
                                 [self.view layoutIfNeeded];
                             }];
                         });
                     }];
    
    RAC(_LabelUserName,text) = [RACObserve(self.viewModel.user, nickName)
                                map:^(NSString* nickName) {
                                    return [@"欢迎您," stringByAppendingString:nickName];
                                }];
    RAC(_ImageViewHeadPhoto,image) = [RACObserve(self.viewModel.user, headPhoto_Home)
                                      map:^(NSData* data) {
                                          return [UIImage imageWithData:data];
                                      }];
    RAC(self.funcsViewModel,scale) = [[self.tableView rac_signalForSelector:@selector(scrollViewDidScroll:)
                                                               fromProtocol:@protocol(UIScrollViewDelegate)]
                                                      map:^(UIScrollView* scrollView) {
                                                             return @(scrollView.contentOffset.y < 10);
                                                      }];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UITouch* touch = [touches anyObject];
    if ([_ImageViewHeadPhoto pointInside:[touch locationInView:_ImageViewHeadPhoto] withEvent:event]){
        [GBUserDefault shareUserDefault].userID = nil;
        LoginViewController* viewController = [LoginViewController initWithViewModel:[LoginViewModel new]];
        [self presentViewController:[[UINavigationController alloc]initWithRootViewController:viewController] animated:NO completion:nil];
    }
}

#pragma mark- collectionDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.funcsViewModel.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeFunctionsCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeFunctionsCollectionViewCell" forIndexPath:indexPath];
    [self.funcsViewModel configureCell:cell AtIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.funcsViewModel cellSizeForIndexPath:indexPath];
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    cell.transform = CGAffineTransformMakeTranslation(20,0);
    cell.alpha = 0;
    [UIView animateWithDuration:0.5 delay:indexPath.row * 0.1 usingSpringWithDamping:0.7 initialSpringVelocity:5 options:UIViewAnimationOptionTransitionNone animations:^{
        cell.transform = CGAffineTransformIdentity;
        cell.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.navigationController pushViewController:(UIViewController*)[_destViewControllerDict objectForKey:[NSNumber numberWithLong:indexPath.row]] animated:YES];
}

#pragma mark- tableViewDataSource

- (UITableViewCell *)tableView:(UITableView*)tableView CellforIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell"];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    HomeTableViewCell* myCell = (HomeTableViewCell*)cell;
    OrderModel* myObject = (OrderModel*)object;
    myCell.customer = myObject.customer;
    myCell.orderStatus = myObject.status;
    myCell.createDate = myObject.createDateStr;
    [myCell setOrderSum:myObject.totalPrice GoodNum:myObject.goodNum];
}

@end
