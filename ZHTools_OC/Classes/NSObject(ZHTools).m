//
//  NSObject(ZHTools).m
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import "NSObject(ZHTools).h"

#import <objc/runtime.h>
#import <objc/message.h>


@implementation NSObject(ZHTools)

- (void)zh_performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay {
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    
    dispatch_after(popTime, dispatch_get_main_queue(), block);

}

+ (BOOL)zh_swizzleMethod:(SEL)origionalMethod toMethod:(SEL)newMethod {
    
    Method origionalMethodX = class_getInstanceMethod(self, origionalMethod);
    
    if (!origionalMethodX) {
        NSLog(@"%@", [NSString stringWithFormat:@"%@ 类里没有找到 %@ 方法", [self class], NSStringFromSelector(origionalMethod)]);
        return NO;
    }
    
    Method newMethodX = class_getInstanceMethod(self, newMethod);
    if (!newMethodX) {
        NSLog(@"%@", [NSString stringWithFormat:@"%@ 类里没有找到 %@ 方法", [self class], NSStringFromSelector(newMethod)]);
        return NO;
    }
    
    class_addMethod(self, origionalMethod, class_getMethodImplementation(self, origionalMethod), method_getTypeEncoding(origionalMethodX));
    
    class_addMethod(self, newMethod, class_getMethodImplementation(self, newMethod), method_getTypeEncoding(newMethodX));
    
    method_exchangeImplementations(class_getInstanceMethod(self, origionalMethod), class_getInstanceMethod(self, newMethod));
    return YES;
}

- (id)zh_removeNULL {
    if ([self isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)self;
        return [array zh_removeNULL];
    } else if([self isKindOfClass:[NSDictionary class]]){
        NSDictionary *dict = (NSDictionary *)self;
        return [dict zh_removeNULL];
    }else{
        return self;
    }
}

@end
