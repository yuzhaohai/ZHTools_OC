//
//  NSTimer(ZHTools).m
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import "NSTimer(ZHTools).h"
#import "NSDate(ZHTools).h"

@implementation NSTimer(ZHTools)

+ (NSTimer *)zh_scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats block:(ZHTimerBlock)block {
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(executeBlock:) userInfo:block repeats:repeats];
            
    return timer;
}

+ (void)executeBlock:(NSTimer *)timer {
    
    ZHTimerBlock block = [timer userInfo];

    if (block) {
        block(timer);
    }
}

- (void)zh_pause {
    NSDate *date = [NSDate distantFuture];
    [self setFireDate:date];
}

- (void)zh_resume {
    
    NSDate *date = [NSDate distantPast];
    [self setFireDate:date];
    
}

/**
NStimer原有的isValid属性不再准确，请使用zh_IsValid
*/
- (BOOL)zh_isValid {
    return self.isValid;
}

@end
