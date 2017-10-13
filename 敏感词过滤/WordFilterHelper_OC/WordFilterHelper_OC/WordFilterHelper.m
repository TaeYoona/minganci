//
//  WordFilterHelper.m
//  Flashfish
//
//  Created by zhangcong on 2017/8/18.
//  Copyright © 2017年 zhangcong. All rights reserved.
//

#import "WordFilterHelper.h"
#import <stdio.h>

@implementation WordFilterHelper

static WordFilterHelper * _instance = nil;
+(instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[WordFilterHelper alloc] init] ;
    });
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.root = [NSMutableDictionary dictionary];
        [self initFilter:nil];
    }
    return self;
}

- (void)initFilter:(NSString *)filepath{
    filepath = [[NSBundle mainBundle] pathForResource:@"minganci" ofType:@"txt"];
     NSString *dataFile = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
    NSArray *dataarr = [dataFile componentsSeparatedByString:@"\n"];
    for (NSString *str in dataarr) {
        if(str.length > 0)
            [self insertWords:str];
    }
}

-(void)insertWords:(NSString *)words{
    NSMutableDictionary *node = self.root;
    
    for (int i = 0; i < words.length; i ++) {
        NSString *word = [words substringWithRange:NSMakeRange(i, 1)];
        
        if (node[word] == nil) {
            node[word] = [NSMutableDictionary dictionary];
        }
        
        node = node[word];
    }
    
    //敏感词最后一个字符标识
    node[EXIST] = [NSNumber numberWithInt:1];
}

- (NSString *)filter:(NSString *)str {
    
    if (self.isFilterClose || !self.root) {
        return str;
    }
    
    NSMutableString *result = result = [str mutableCopy];
    
    for (int i = 0; i < str.length; i ++) {
        NSString *subString = [str substringFromIndex:i];
        NSMutableDictionary *node = [self.root mutableCopy] ;
        int num = 0;
        
        for (int j = 0; j < subString.length; j ++) {
            NSString *word = [subString substringWithRange:NSMakeRange(j, 1)];
            
            if (node[word] == nil) {
                break;
            }else{
                num ++;
                node = node[word];
            }
            
            //敏感词匹配成功
            if ([node[EXIST]integerValue] == 1) {
                
                NSMutableString *symbolStr = [NSMutableString string];
                for (int k = 0; k < num; k ++) {
                    [symbolStr appendString:@"*"];
                }
                
                [result replaceCharactersInRange:NSMakeRange(i, num) withString:symbolStr];
                
                i += j;
                break;
            }
        }
    }
    
    return result;
}

- (void)freeFilter{
    self.root = nil;
}

- (void)stopFilter:(BOOL)b{
    self.isFilterClose = b;
}

@end
