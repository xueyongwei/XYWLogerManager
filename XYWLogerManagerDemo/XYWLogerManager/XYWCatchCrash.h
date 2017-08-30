//
//  XYWCatchCrash.h
//  Jump
//
//  Created by xueyognwei on 2017/7/13.
//  Copyright © 2017年 xueyognwei. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface XYWCatchCrash : NSObject
void uncaughtExceptionHandler(NSException *exception);
@end
