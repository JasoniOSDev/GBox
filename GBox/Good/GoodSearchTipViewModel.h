//
//  GoodSearchTipViewModel.h
//  GBox
//
//  Created by jason on 2016/10/25.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GBTableViewModel.h"

@interface GoodSearchTipViewModel : GBTableViewModel

//以classify的id来做键值，标识该分类是否被选择
@property (nonatomic, strong) RACCommand* classifySelectCommand;
@property (nonatomic, strong) RACCommand* classifyCancelCommand;

- (CGSize)cellSizeOfItemAtIndexPath:(NSIndexPath*)indexPath;
@end
