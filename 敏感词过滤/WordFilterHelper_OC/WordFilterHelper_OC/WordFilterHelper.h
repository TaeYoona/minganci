//
//  WordFilterHelper.h
//  Flashfish
//
//  Created by zhangcong on 2017/8/18.
//  Copyright © 2017年 zhangcong. All rights reserved.
//

#import <Foundation/Foundation.h>
#define EXIST @"isExists"
@interface WordFilterHelper : NSObject

+(instancetype)shared;

@property (nonatomic,strong) NSMutableDictionary *root;

@property (nonatomic,assign) BOOL isFilterClose;

- (NSString *)filter:(NSString *)str ;
@end
