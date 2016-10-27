//
//  GBTableViewController.h
//  GBox
//
//  Created by jason on 2016/10/20.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GBViewController.h"

@interface GBTableViewController : GBViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak, readonly) UITableView* tableView;
@property (nonatomic, assign, readonly) UIEdgeInsets contentInset;

- (void)reloadData;
- (UITableViewCell* )tableView:(UITableView*)tableView CellforIndexPath:(NSIndexPath* )indexPath;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;
@end
