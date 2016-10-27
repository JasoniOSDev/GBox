//
//  GoodSearchHistoryModel.h
//  GBox
//
//  Created by jason on 2016/10/25.
//  Copyright © 2016年 jason. All rights reserved.
//

#import <Realm/Realm.h>

@interface GoodSearchHistoryModel : RLMObject

@property NSString* name;
@property NSDate* date;

+ (void)createHistoryWithName:(NSString*)name;
+ (void)DeleteAll;
@end
