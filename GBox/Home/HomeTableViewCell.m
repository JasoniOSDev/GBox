//
//  HomeTableViewCell.m
//  GBox
//
//  Created by jason on 2016/10/24.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "CustomerModel.h"

@interface HomeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *ImageViewHeadPhoto;
@property (weak, nonatomic) IBOutlet UILabel *LabelTItile;
@property (weak, nonatomic) IBOutlet UIImageView *ImageViewTag;
@property (weak, nonatomic) IBOutlet UILabel *LabelInfo;
@property (weak, nonatomic) IBOutlet UILabel *LabelTime;

@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setCreateDate:(NSString *)createDate{
    _LabelTime.text = createDate;
    _createDate = createDate;
}

- (void)setOrderStatus:(BOOL)orderStatus{
    if (orderStatus) {
        _ImageViewTag.image = [UIImage imageNamed:@"Home_OrderCompletion"];
    }else{
        _ImageViewTag.image = [UIImage imageNamed:@"Home_OrderPending"];
    }
    _orderStatus = orderStatus;
}

- (void)setCustomer:(CustomerModel *)customer{
    _LabelTItile.text = [customer.name stringByAppendingString:@"的订单"];
    _ImageViewHeadPhoto.image = customer.headPhoto_Low;
}

- (void)setOrderSum:(CGFloat)sum GoodNum:(NSUInteger)num{
    NSString* sumStr;
    if (sum == floorf(sum)){
        sumStr = [NSString stringWithFormat:@"%.f",sum];
    }else{
        sumStr = [NSString stringWithFormat:@"%.1f",sum];
    }
    NSString* numStr = [NSString stringWithFormat:@"%lu",(unsigned long)num];
    _LabelInfo.text = [NSString stringWithFormat:@"共计%@件，%@元",numStr,sumStr];
}


@end
