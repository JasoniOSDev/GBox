//
//  GBButton.m
//  GBButton
//
//  Created by jason on 2016/10/20.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "GBButton.h"

@implementation GBButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _space = 0;
        self.imageViewPosition = GBButtonImageViewPositionLeft;
    }
    return self;
}

- (instancetype)initWithImageViewPosition:(GBButtonImageViewPosition)position{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.imageViewPosition = position;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self layoutInsets];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self layoutInsets];
}

- (void)setImageViewPosition:(GBButtonImageViewPosition)imageViewPosition{
    _imageViewPosition = imageViewPosition;
    [self layoutInsets];
}

- (void)setSpace:(CGFloat)space{
    _space = space;
    [self layoutInsets];
}


- (void)layoutInsets{
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    if (self.titleLabel.text == NULL || self.imageView.image == NULL)return;
    NSString* title = self.titleLabel.text;
    UIImage* image = self.imageView.image;
    
    CGFloat titleWidth = [title sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].width;
    CGFloat titleHeight = [title sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].height;
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    
    CGFloat imageInsetTop = 0;
    CGFloat imageInsetBottom = 0;
    CGFloat imageInsetLeft = 0;
    CGFloat imageInsetRight = 0;
    
    CGFloat titleInsetTop = 0;
    CGFloat titleInsetBottom = 0;
    CGFloat titleInsetLeft = 0;
    CGFloat titleInsetRight = 0;
    CGFloat tmpSpace = _space/2;
    CGSize size;
    CGFloat totalHeight;
    CGFloat totalWidth;
    switch (_imageViewPosition) {
        case GBButtonImageViewPositionRight:
            imageInsetLeft = titleWidth + tmpSpace;
            imageInsetRight = -titleWidth - tmpSpace;
            titleInsetLeft = -imageWidth - tmpSpace;
            titleInsetRight = imageWidth + tmpSpace;
            size = CGSizeMake(titleWidth + imageWidth + _space,fmax(titleHeight,imageHeight));
            break;
        case GBButtonImageViewPositionTop:
            totalHeight = (imageHeight + titleHeight + _space)/2;
            totalWidth = (imageWidth + titleWidth) / 2;
            imageInsetTop =  imageHeight/2 - totalHeight;
            imageInsetBottom = -imageInsetTop;
            titleInsetTop = totalHeight - titleHeight/2;
            titleInsetBottom = -titleInsetTop;
            imageInsetLeft = totalWidth - imageWidth / 2;
            imageInsetRight = -imageInsetLeft;
            titleInsetLeft = titleWidth/2 - totalWidth;
            titleInsetRight = -titleInsetLeft;
            size = CGSizeMake( totalWidth * 2, totalHeight * 2);
            break;
        case GBButtonImageViewPositionBottom:
            totalHeight = (imageHeight + titleHeight + _space)/2;
            totalWidth = (imageWidth + titleWidth) / 2;
            imageInsetTop =  totalHeight - imageHeight/2;
            imageInsetBottom = -imageInsetTop;
            titleInsetTop = titleHeight/2 - totalHeight;
            titleInsetBottom = -titleInsetTop;
            imageInsetLeft = totalWidth - imageWidth / 2;
            imageInsetRight = -imageInsetLeft;
            titleInsetLeft = titleWidth/2 - totalWidth;
            titleInsetRight = -titleInsetLeft;
            size = CGSizeMake(totalWidth * 2, totalHeight * 2);
            break;
        case GBButtonImageViewPositionLeft:
            size = CGSizeMake( titleWidth + imageWidth + _space, fmax(titleHeight,imageHeight));
            break;
    }
    size.height += self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
    size.width += self.contentEdgeInsets.left + self.contentEdgeInsets.right;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    self.imageEdgeInsets = UIEdgeInsetsMake(imageInsetTop, imageInsetLeft, imageInsetBottom,imageInsetRight);
    self.titleEdgeInsets = UIEdgeInsetsMake(titleInsetTop, titleInsetLeft, titleInsetBottom, titleInsetRight);
    [self layoutIfNeeded];
}

@end
