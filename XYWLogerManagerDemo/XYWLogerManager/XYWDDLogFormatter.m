//
//  XYWDDLogFormatter.m
//  downloader
//
//  Created by xueyognwei on 2017/4/20.
//  Copyright © 2017年 xueyognwei. All rights reserved.
//

#import "XYWDDLogFormatter.h"


@implementation XYWDDLogFormatter
-(NSString *)formatLogMessage:(DDLogMessage* )logMessage {
    NSString *logLevel;
    switch (logMessage->_flag) {
        case DDLogFlagError : logLevel = @"⛔️⛔️⛔️"; break;
        case DDLogFlagWarning : logLevel = @"⚠️⚠️⚠️"; break;
        case DDLogFlagInfo : logLevel = @"ℹ️ℹ️ℹ️"; break;
        case DDLogFlagDebug : logLevel = @"🛠🛠🛠"; break;
        default : logLevel = @"⤵️⤵️⤵️"; break;
    }
    //以上是根据不同的类型 定义不同的标记字符
    return [NSString stringWithFormat:@"\n%@-%@:%zd-%@\n%@\n",logMessage->_timestamp,logMessage->_function,logMessage->_line, logLevel,logMessage->_message];
    //以上就是加入文件名 行号 方法名的
}
@end
