//
//  XYWLogerManager.h
//  Jump
//
//  Created by xueyognwei on 2017/7/13.
//  Copyright © 2017年 xueyognwei. All rights reserved.
//

#import <Foundation/Foundation.h>


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
@interface XYWLogerManager : NSObject
+(void)setUpLoger;
@end
