//
//  ViewController.m
//  XYWLogerManagerDemo
//
//  Created by xueyognwei on 2017/7/13.
//  Copyright © 2017年 xueyognwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DDLogVerbose(@"正在使用XYWLogerManager哦！");
    DDLogInfo(@"启动成功");
    DDLogError(@"输出个错误信息");
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
