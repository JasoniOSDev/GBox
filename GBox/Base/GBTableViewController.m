//
//  GBTableViewController.m
//  GBox
//
//  Created by jason on 2016/10/20.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GBTableViewController.h"
#import "GBTableViewModel.h"
@interface GBTableViewController ()

@property (nonatomic, weak, readwrite) IBOutlet UITableView* tableView;
@property (nonatomic, strong, readonly) GBTableViewModel* viewModel;

@end

@implementation GBTableViewController

@dynamic viewModel;


- (void)setView:(UIView *)view{
    [super setView:view];
    if ([view isKindOfClass:UITableView.class]) self.tableView = (UITableView* )view;
}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(64, 0, 0, 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = self.contentInset;
    self.tableView.scrollIndicatorInsets = self.contentInset;
    self.tableView.sectionIndexColor = [UIColor darkGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexMinimumDisplayRowCount = 20;
}

- (void)bindViewModel{
    [super bindViewModel];
    @weakify(self);
    [[[RACObserve(self.viewModel, dataSource)
    distinctUntilChanged]
    deliverOnMainThread]
    subscribeNext:^(id x) {
        @strongify(self);
        [self reloadData];
    }];
    
}

- (void)reloadData{
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView*)tableView CellforIndexPath:(NSIndexPath *)indexPath{
   //后期可以利用来做一个默认的cell
    //处理无数据的情况
    return [UITableViewCell new];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataSource ? self.viewModel.dataSource.count : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)[self.viewModel.dataSource[section] count]);
    return [self.viewModel.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self tableView:tableView CellforIndexPath:indexPath];
    
    id object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    
    [self configureCell:cell atIndexPath:indexPath withObject:object];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.viewModel tableView:tableView heightForRowAtIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewModel.didSelectCommand execute:indexPath];
}


@end
