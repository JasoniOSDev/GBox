//
//  GoodModel.h
//  GBox
//
//  Created by jason on 2016/10/24.
//  Copyright © 2016年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodClassifyModel.h"

@interface GoodModel : RLMObject

@property NSString* ID;
@property NSString* name;
@property NSString* remark;
@property NSString* code;//条形码
@property NSData* photo;
@property float price;
@property int stock;
@property int sellNum;//售出的数量
@property GoodClassifyModel* classify;
@property (nonatomic, strong) UIImage* imagePhoto;

- (void)modifyWithObject:(GoodModel*)object;
- (void)updatePrice:(float)price;
- (void)updateStock:(int)modify;
- (void)updateSellNum:(int)add;
@end
