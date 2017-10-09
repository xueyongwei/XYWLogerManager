//
//  XYWVersonHelper.h
//  downloader
//
//  Created by xueyognwei on 2017/5/2.
//  Copyright © 2017年 xueyognwei. All rights reserved.
//


/*
 处理一些版本升级兼容问题时用到。
 你可以更改bundleID来测试。
 理论来讲只需要用到appThislaunchType方法，根据返回值来做相应的操作。
 ⚠️注意，仅支持最多3段数字类型的版本号,且第二段不大于100（eg，1、3.0、5.1.5、10.88.666）
 -----------
 this simple version Helper is used to deal with version compatibility issues
 you can edit the bundle id to show the result of this laucn
 ⚠️warning，your version string should like 1、3.0、5.1.5、10.88.666
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, XYWVersonHelperLunchType) {//道具类型
    XYWVersonHelperLunchTypeNormal=0,
    XYWVersonHelperLunchTypeFirstLuchThisVersion,
    XYWVersonHelperLunchTypeFirstLuchAfterInstall,
};

@interface XYWAppVersionHelper : NSObject

/**
 float 上次启动时的版本号 ／ Version number of last launch
 
 @return float 类型的版本号，便于比较 / a float value
 */
@property (nonatomic,assign) float lastVersion;

/**
 float 本次启动时的版本号 ／ Version number of this launch
 
 @return float 类型的版本号，便于比较 / a float value
 */
@property (nonatomic,assign) float currentVersion;

/**
 本次APP启动类型 / This APP launch type
 
 
 @return 启动类型 / launch type
 */
@property (nonatomic,assign) XYWVersonHelperLunchType lunchType;


/**
 共享的管理器，单例

 @return 管理器
 */
+(instancetype)shareHelper;

@end
