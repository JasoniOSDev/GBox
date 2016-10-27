//
//  HomeFunctionModel.h
//  GBox
//
//  Created by jason on 2016/10/23.
//  Copyright © 2016年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeFunctionModel : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* icon;

+ (instancetype)initWithICon:(NSString*)icon title:(NSString*)title;

@end
