//
//  XYWVersonHelper.m
//  downloader
//
//  Created by xueyognwei on 2017/5/2.
//  Copyright © 2017年 xueyognwei. All rights reserved.
//

#import "XYWAppVersionHelper.h"
@implementation XYWAppVersionHelper

+(instancetype)shareHelper
{
    static XYWAppVersionHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
        [sharedInstance appDidFinishLaunch];
    });
    return sharedInstance;
}

-(void)appDidFinishLaunch{
    NSUserDefaults *usf = [NSUserDefaults standardUserDefaults];
    float lastVersionInter = [usf floatForKey:@"lastAppVersionIntegerValue"];
    //取本次启动时app的版本
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSRange dotrange = [version rangeOfString:@"."];
    NSString *bigVersion = [version substringToIndex:dotrange.location];
    NSString *smallVersion = [version substringFromIndex:dotrange.location+dotrange.length];
    float currentVersion = bigVersion.integerValue*100+smallVersion.floatValue;
    self.currentVersion = currentVersion;
    [usf setFloat:currentVersion forKey:@"lastAppVersionIntegerValue"];
    [usf synchronize];
    if (lastVersionInter>0) {//已有版本记录，启动过
        self.lastVersion = lastVersionInter;
        if (currentVersion != lastVersionInter) {//版本不同
            self.lunchType = XYWVersonHelperLunchTypeFirstLuchThisVersion;
        }else{
            self.lunchType = XYWVersonHelperLunchTypeNormal;
        }
    }else{//没有记录，安装后第一次启动
        self.lastVersion = currentVersion;
        self.lunchType = XYWVersonHelperLunchTypeFirstLuchAfterInstall;
    }
}
@end
