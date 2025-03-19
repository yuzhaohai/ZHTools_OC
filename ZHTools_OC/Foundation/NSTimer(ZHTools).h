//
//  NSTimer(ZHTools).h
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^ZHTimerBlock)(NSTimer *timer);

@interface NSTimer(ZHTools)

+ (NSTimer *)zh_scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats block:(ZHTimerBlock)block;

/**
 暂停,调用此方法后NStimer原有的isValid属性不再准确，请使用zh_IsValid
 */
- (void)zh_pause;

/**
 开始,调用此方法后NStimer原有的isValid属性不再准确，请使用zh_IsValid
 */
- (void)zh_resume;

@end
