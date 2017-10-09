# XYWLogerManager
XYW日志系统
### 使用方法：
1.先在pch中添加以下内容：
<pre><code>#import <CocoaLumberjack.h>
    #ifdef DEBUG
    static const int ddLogLevel = DDLogLevelVerbose;
    #else
    static const int ddLogLevel = DDLogLevelError;
    #endif</pre></code>
2.然后在app delegate中导入"XYWLogerManager.h",并在didFinishLaunchingWithOptions中添加以下内容：
 <pre><code>[XYWLogerManager setUpLoger];</pre></code>
3.在代码中使用
    <pre><code>DDLogVerbose(@"%@",_datasource)</pre></code>
或者
    <pre><code>DDLogError(@"%@",_datasource)</pre></code>
替换
    <pre><code>NSLog("%@",_datasource)</pre></code>
输出日志即可;
### 日志文件
崩溃日志存储到/Documents/error.log文件中了。


