# XYWLogerManager
XYW日志系统，依赖库：CocoaLumberjack
本地日志系统，格式化控制台信息，并输出日志信息到本地log文件，可捕获崩溃信息并保存日志文件到沙盒，可直接发送运行设备的本地详细日志或者崩溃日志到指定邮箱。
### 使用方法：
1.先在pch中添加以下内容：
<pre><code>
    #import \<CocoaLumberjack.h\>
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
### 发送日志到邮箱
日志已被记录到沙盒，可通过【隐式触发】来让用户发送日志文件到开发者邮箱，以追踪信息。</br>
比如在“设置”中，通过点击10次app名字触发以下方法：
<pre><code>
[[XYWLogerManager shareManager]sendLogFileToEmail:@"xueyongwei@foxmail.com"];
</pre></code>
来获取用户的详细运行日志。<br>
如果要追踪崩溃日志，可以通过调用以下方法：
<pre><code>
[[XYWLogerManager shareManager]sendCrashFileToEmail:@"xueyongwei@foxmail.com"];
</pre></code>
来获取崩溃日志。
### 参数设置
在XYWLogerManager.m文件中的setUpLoger方法中，可修改rollingFrequency或maximumNumberOfLogFiles等属性。
