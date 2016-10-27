//
//  GBViewModel.m
//  GBox
//
//  Created by jason on 2016/10/20.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GBViewModel.h"

@interface GBViewModel ()

@end


@implementation GBViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _preName = NSStringFromClass([self class]);
        _preName = [_preName stringByReplacingOccurrencesOfString:@"ViewModel" withString:@""];
        _viewControllerName = [_preName stringByAppendingString:@"ViewController"];
        const char* name = [_preName UTF8String];
        int i = 1;
        for(;i<[_preName length];i++){
            if(name[i] >= 'A' && name[i] <= 'Z'){
                self.storyboardName = [_preName substringToIndex:i];
                break;
            }
        }
        if (i == [_preName length]) {
            self.storyboardName = _preName;
        }
    }
    return self;
}

- (void)setStoryboardName:(NSString *)storyboardName{
    _storyboardName = storyboardName;
    _storyboard = [UIStoryboard storyboardWithName:_storyboardName bundle:[NSBundle mainBundle]];
}

@end
