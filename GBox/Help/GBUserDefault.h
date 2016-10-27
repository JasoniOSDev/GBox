//
//  GBUserDefault.h
//  GBox
//
//  Created by jason on 2016/10/23.
//  Copyright © 2016年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBUserDefault : NSObject

@property(nonatomic, copy)NSString* userID;
+ (instancetype)shareUserDefault;
@end
