# XYWLogerManager
XYW日志系统
### 使用方法：
1.先在pch中添加以下内容：
    #import <CocoaLumberjack.h>
    #ifdef DEBUG
    static const int ddLogLevel = DDLogLevelVerbose;
    #else
    static const int ddLogLevel = DDLogLevelError;
    #endif
2.然后在app delegate中导入"XYWLogerManager.h",并在didFinishLaunchingWithOptions中添加以下内容：
    [XYWLogerManager setUpLoger];
3.在代码中使用
    DDLogVerbose(@"%@",_datasource)
或者
    DDLogError(@"%@",_datasource)
替换
    NSLog("%@",_datasource)
输出日志即可;
 

崩溃日志存储到/Documents/error.log文件中


