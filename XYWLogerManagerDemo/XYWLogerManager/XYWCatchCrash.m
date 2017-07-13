//
//  XYWCatchCrash.m
//  Jump
//
//  Created by xueyognwei on 2017/7/13.
//  Copyright © 2017年 xueyognwei. All rights reserved.
//

#import "XYWCatchCrash.h"

@implementation XYWCatchCrash
void uncaughtExceptionHandler(NSException *exception)
{
    //获取系统当前时间，（注：用[NSDate date]直接获取的是格林尼治时间，有时差）
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *crashTime = [formatter stringFromDate:[NSDate date]];
    //异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    //出现异常的原因
    NSString *reason = [exception reason];
    //异常名称
    NSString *name = [exception name];
    
    //拼接错误信息,存储到/Documents/error.log文件中
    NSString *exceptionInfo = [NSString stringWithFormat:@"crashTime: %@ Exception reason: %@\nException name: %@\nException stack:%@", crashTime, name, reason, stackArray];
    NSString *errorLogPath = [NSString stringWithFormat:@"%@/Documents/error.log", NSHomeDirectory()];
    
    BOOL localErrprLog =  [[NSFileManager defaultManager] fileExistsAtPath:errorLogPath];
    if (!localErrprLog) {//还没有，直接写文件
        [exceptionInfo writeToFile:errorLogPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }else{//追加内容
        NSFileHandle  *outFile;
        NSData *buffer;
        
        outFile = [NSFileHandle fileHandleForWritingAtPath:errorLogPath];
        
        if(outFile == nil)
        {
            DDLogWarn(@"Open of file for writing failed");
        }
        //找到并定位到outFile的末尾位置(在此后追加文件)
        [outFile seekToEndOfFile];
        //读取inFile并且将其内容写到outFile中
        buffer = [exceptionInfo dataUsingEncoding:NSUTF8StringEncoding];
        [outFile writeData:buffer];
        //关闭读写文件
        [outFile closeFile];
    }
}
@end
