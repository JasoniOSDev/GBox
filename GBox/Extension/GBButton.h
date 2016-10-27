//
//  GBButton.h
//  GBButton
//
//  Created by jason on 2016/10/20.
//  Copyright © 2016年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, GBButtonImageViewPosition) {
    GBButtonImageViewPositionLeft,
    GBButtonImageViewPositionRight,
    GBButtonImageViewPositionTop,
    GBButtonImageViewPositionBottom
};
@interface GBButton : UIButton

- (instancetype)initWithImageViewPosition:(GBButtonImageViewPosition)position;
@property (nonatomic, assign)CGFloat space;
@property (nonatomic, assign)GBButtonImageViewPosition imageViewPosition;

@end
