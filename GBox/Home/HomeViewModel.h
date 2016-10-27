//
//  HomeViewModel.h
//  GBox
//
//  Created by jason on 2016/10/20.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GBTableViewModel.h"
#import "UserGod.h"
#import "OrderModel.h"
@interface HomeViewModel : GBTableViewModel

@property (nonatomic, strong) UserGod* user;

@end
