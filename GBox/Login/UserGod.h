//
//  UserGod.h
//  GBox
//
//  Created by jason on 2016/10/23.
//  Copyright © 2016年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserGod : RLMObject

@property NSString* nickName;
@property NSString* phoneNumber;
@property NSString* userID;
@property NSData* headPhoto_origin;
@property NSData* headPhoto_Login;
@property NSData* headPhoto_Home;
@property NSDate* createDate;
@property (nonatomic, strong) UIImage* imageHeadPhoto_origin;
@property (nonatomic, strong) UIImage* imageHeadPhoto_Login;
@property (nonatomic, strong) UIImage* imageHeadPhoto_Home;
//@property NSDate* lastLogin;
//@property NSDate* lastOperation;//最后一次操作

+ (instancetype)currentUser;
+ (instancetype)userWithPhoneNumber:(NSString*)phoneNumber;
+ (instancetype)LoginWithPhoneNumber:(NSString*)phoneNumber;

@end

@interface UIImage (GBox)

- (UIImage *)GB_imageByResizeToSize:(CGSize)size;

@end
