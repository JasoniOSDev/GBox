//
//  GBCollectionViewModel.h
//  GBox
//
//  Created by jason on 2016/10/23.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GBViewModel.h"

@interface GBCollectionViewModel : GBViewModel

@property (nonatomic, copy) NSArray* dataSource;
@property (nonatomic, strong) RACCommand* didSelectCommand;

@end
