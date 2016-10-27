//
//  GBTableViewModel.h
//  GBox
//
//  Created by jason on 2016/10/20.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GBViewModel.h"

@interface GBTableViewModel : GBViewModel

@property (nonatomic, copy) NSArray* dataSource;
@property (nonatomic, copy) NSArray* sectionIndexTitle;
@property (nonatomic, strong) RACCommand* didSelectCommand;

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
    

@end