//
//  GBViewModel.h
//  GBox
//
//  Created by jason on 2016/10/20.
//  Copyright © 2016年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VoidBlock_id)(id);

@interface GBViewModel : NSObject

@property (nonatomic, strong) UIStoryboard* storyboard;
@property (nonatomic, copy) NSString* viewControllerName;
@property (nonatomic, copy) NSString* storyboardName;
@property (nonatomic, copy) NSString* preName;
@property (nonatomic, copy, readonly) NSDictionary* params;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) VoidBlock_id callback;

@end
