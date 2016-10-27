//
//  HomeFunctionsCollectionViewCell.m
//  GBox
//
//  Created by jason on 2016/10/23.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "HomeFunctionsCollectionViewCell.h"

@interface HomeFunctionsCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *ImageViewPhoto;
@property (weak, nonatomic) IBOutlet UILabel *LabelTitle;

@end

@implementation HomeFunctionsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setICon:(NSString *)ICon title:(NSString *)title{
    
    _ImageViewPhoto.image = [UIImage imageNamed:[@"Home_Func" stringByAppendingString:ICon]];
    _LabelTitle.text = title;
}


- (void)makeScale{
    _LabelTitle.hidden = YES;
}

@end
