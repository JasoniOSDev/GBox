//
//  GoodClassifyModel.h
//  GBox
//
//  Created by jason on 2016/10/24.
//  Copyright © 2016年 jason. All rights reserved.
//

RLM_ARRAY_TYPE(GoodClassifyModel)

@interface GoodClassifyModel : RLMObject

@property GoodClassifyModel* superClassify;
@property RLMArray<GoodClassifyModel*><GoodClassifyModel>* childClassify;
@property NSString* ID;
@property NSString* name;
@property int level;//等级，从0开始

+ (instancetype)createClassifyWithName:(NSString*)name ChilfOfClassify:(GoodClassifyModel*)classify;
+ (instancetype)createClassifyWithName:(NSString*)name;

+ (NSMutableArray<GoodClassifyModel*>*)AllFirstClassify;
+ (NSMutableArray<GoodClassifyModel*>*)AllSecondClassify;
@end
