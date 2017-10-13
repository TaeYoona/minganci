//
//  ViewController.m
//  WordFilterHelper_OC
//
//  Created by zhangcong on 2017/10/13.
//  Copyright © 2017年 zhangcong. All rights reserved.
//

#import "ViewController.h"
#import "WordFilterHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"我爱胡锦涛 过滤后 ： %@",[WordFilterHelper.shared filter:@"我爱胡锦涛"]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
