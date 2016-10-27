//
//  UserGod.m
//  GBox
//
//  Created by jason on 2016/10/23.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "UserGod.h"

@implementation UIImage (GBox)

- (UIImage *)GB_imageByResizeToSize:(CGSize)size {
    if (size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

@implementation UserGod

static UserGod* currentUser;

+ (instancetype)registerWithPhoneNumber:(NSString*)phoneNumber{
    UserGod* user = [[UserGod alloc]initWithPhoneNumber:phoneNumber];
    RLMRealm* realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:user];
    [realm commitWriteTransaction];
    return user;
}

+ (instancetype)LoginWithPhoneNumber:(NSString *)phoneNumber{
    UserGod* user = [UserGod userWithPhoneNumber:phoneNumber];
    if (user == nil){
        user = [UserGod registerWithPhoneNumber:phoneNumber];
    }
    [GBUserDefault shareUserDefault].userID = user.userID;
    return user;
}

+ (instancetype)userWithPhoneNumber:(NSString *)phoneNumber{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"phoneNumber == %@",phoneNumber];
    return [[UserGod objectsWithPredicate:predicate]firstObject];
}

+ (instancetype)currentUser{
    @synchronized (self) {
        NSString* userID = [[GBUserDefault shareUserDefault]userID];
        if (userID != nil && (currentUser == NULL || currentUser.userID != userID)){
            NSPredicate* predicate = [NSPredicate predicateWithFormat:@"userID == %@",userID];
            currentUser = [[UserGod objectsWithPredicate:predicate]firstObject];
        }else{
            if (userID == nil){
                currentUser = nil;
            }
        }
    }
    return currentUser;
}

+ (NSArray<NSString *> *)requiredProperties{
    return @[@"nickName",@"phoneNumber",@"userID",@"createDate",@"headPhoto_origin",@"headPhoto_Login",@"headPhoto_Home"];
}

+ (NSArray<NSString *> *)ignoredProperties{
    return @[@"imageHeadPhoto_origin",@"imageHeadPhoto_Login",@"imageHeadPhoto_Home"];
}

- (instancetype)initWithPhoneNumber:(NSString*)phoneNumber{
    self = [super init];
    if(self){
        _phoneNumber = phoneNumber;
        _userID = [[NSUUID UUID]UUIDString];
        _nickName = phoneNumber;
        _createDate = [NSDate new];
        NSArray<NSData*>* imageArray = [self fetchImage];
        _headPhoto_origin = imageArray[0];
        _headPhoto_Login = imageArray[1];
        _headPhoto_Home = imageArray[2];
    }
    return self;
}

- (NSArray<NSData*>*)fetchImage{
    NSUInteger index = (NSUInteger)[[NSDate new]timeIntervalSince1970]%6;
    UIImage* image = [UIImage imageNamed:[@"ProfilePhoto-" stringByAppendingString:[[NSString alloc]initWithFormat:@"%lu",(unsigned long)index ]]];
    NSMutableArray* array = [NSMutableArray new];
    [array addObject:UIImageJPEGRepresentation(image, 0.95)];
    [array addObject:UIImageJPEGRepresentation([image GB_imageByResizeToSize:CGSizeMake(200, 200)], 0.95)];
    [array addObject:UIImageJPEGRepresentation([image GB_imageByResizeToSize:CGSizeMake(40, 40)], 0.95)];
    return array;
}

- (UIImage *)imageHeadPhoto_origin{
    return [UIImage imageWithData:self.headPhoto_origin];
}

- (UIImage *)imageHeadPhoto_Login{
    return [UIImage imageWithData:self.headPhoto_Login];
}

- (UIImage *)imageHeadPhoto_Home{
    return [UIImage imageWithData:self.headPhoto_Home];
}

@end
