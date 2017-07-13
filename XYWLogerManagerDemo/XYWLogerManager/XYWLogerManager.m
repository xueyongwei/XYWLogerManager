//
//  XYWLogerManager.m
//  Jump
//
//  Created by xueyognwei on 2017/7/13.
//  Copyright © 2017年 xueyognwei. All rights reserved.
//

#import "XYWLogerManager.h"
#import "XYWCatchCrash.h"
#import "XYWDDLogFormatter.h"
@implementation XYWLogerManager
/* 使用方法：
 //⚠️先在pch中添加以下内容：
 #import <CocoaLumberjack.h>
 #ifdef DEBUG
 static const int ddLogLevel = DDLogLevelVerbose;
 #else
 static const int ddLogLevel = DDLogLevelError;
 #endif
 //⚠️然后在app delegate中导入"XYWLogerManager.h",并在didFinishLaunchingWithOptions中添加以下内容：
 [XYWLogerManager setUpLoger];
 //⚠️在代码中使用DDLogVerbose(@"%@",_datasource)或者DDLogError(@"%@",_datasource)替换NSLog("%@",_datasource)输出日志即可;
 //⚠️崩溃日志存储到/Documents/error.log文件中
 */
+(void)setUpLoger{
    //初始化日志系统
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    //    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
//    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];// 启用颜色区分
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    [DDTTYLogger sharedInstance].logFormatter = [[XYWDDLogFormatter alloc] init];
    //ddlog抓取崩溃日志
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
}
@end
