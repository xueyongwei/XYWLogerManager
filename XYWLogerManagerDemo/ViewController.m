//
//  ViewController.m
//  XYWLogerManagerDemo
//
//  Created by xueyognwei on 2017/7/13.
//  Copyright © 2017年 xueyognwei. All rights reserved.
//

#import "ViewController.h"
#import "XYWLogerManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)verbose:(id)sender {
    DDLogVerbose(@"DDLogVerbose");
}
- (IBAction)warning:(id)sender {
    DDLogWarn(@"DDLogWarn");
}
- (IBAction)err:(id)sender {
    DDLogError(@"DDLogError");
}

- (IBAction)sendlog:(id)sender {
    [[XYWLogerManager shareManager]sendLogFileToEmail:@"xueyongwei@foxmail.com"];
}

- (IBAction)sendCrash:(id)sender {
    [[XYWLogerManager shareManager]sendCrashFileToEmail:@"xueyongwei@foxmail.com"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
