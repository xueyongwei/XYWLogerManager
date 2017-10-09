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
{
    
}
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

+(instancetype)shareManager
{
    static XYWLogerManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}
-(void)setUpLoger{
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

-(void)sendLogFileToEmail:(NSString *)email{
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    if (!mailCompose) {
        UIAlertView *alv = [[UIAlertView alloc]initWithTitle:@"无法发送邮件" message:@"请检查是否已登陆可用的邮箱账户" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alv show];
        return;
    }
    // 设置邮件主题
    [mailCompose setSubject:@"jumper report"];
    mailCompose.mailComposeDelegate = self;
    // 设置收件人
    [mailCompose setToRecipients:@[email]];
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    NSString *mailBody = [NSString stringWithFormat:@"</br></br></br></br> iOS %.2f, %@ v%@ ",[UIDevice currentDevice].systemVersion.doubleValue,appName,appVersion];
    
    [mailCompose setMessageBody:mailBody isHTML:YES];
    
    NSString *logDir = [[self cachesDir] stringByAppendingPathComponent:@"Logs"];
    NSArray *files = [self listFilesInDirectoryAtPath:logDir deep:NO];
    for (NSString *fileName in files) {
        NSData *pdf = [NSData dataWithContentsOfFile:[logDir stringByAppendingPathComponent:fileName]];
        [mailCompose addAttachmentData:pdf mimeType:@"" fileName:fileName];
    }
    
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:mailCompose animated:YES completion:nil];
    
}
-(void)sendCrashFileToEmail:(NSString *)email{
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    if (!mailCompose) {
        //        CoreSVPCenterMsg(@"无法发送邮件！");
        return;
    }
    // 设置邮件主题
    [mailCompose setSubject:@"report"];
    mailCompose.mailComposeDelegate = self;
    // 设置收件人
    [mailCompose setToRecipients:@[email]];
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    NSString *mailBody = [NSString stringWithFormat:@"</br></br></br></br> iOS %.2f, %@ v%@ ",[UIDevice currentDevice].systemVersion.doubleValue,appName,appVersion];
    
    [mailCompose setMessageBody:mailBody isHTML:YES];
    
    NSString *crashPath = [NSString stringWithFormat:@"%@/Documents/error.log", NSHomeDirectory()];
    NSData *file = [NSData dataWithContentsOfFile:crashPath];
    if (file) {
        [mailCompose addAttachmentData:file mimeType:@"" fileName:@"crash.data"];
    }
    
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:mailCompose animated:YES completion:nil];
}


- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: // 用户取消编辑
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved: // 用户保存邮件
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent: // 用户点击发送
            NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
    }
    // 关闭邮件发送视图
    [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 本地沙盒

- (NSString *)cachesDir {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSArray *)listFilesInDirectoryAtPath:(NSString *)path deep:(BOOL)deep {
    NSArray *listArr;
    NSError *error;
    NSFileManager *manager = [NSFileManager defaultManager];
    if (deep) {
        // 深遍历
        NSArray *deepArr = [manager subpathsOfDirectoryAtPath:path error:&error];
        if (!error) {
            listArr = deepArr;
        }else {
            listArr = nil;
        }
    }else {
        // 浅遍历
        NSArray *shallowArr = [manager contentsOfDirectoryAtPath:path error:&error];
        if (!error) {
            listArr = shallowArr;
        }else {
            listArr = nil;
        }
    }
    return listArr;
}
@end
