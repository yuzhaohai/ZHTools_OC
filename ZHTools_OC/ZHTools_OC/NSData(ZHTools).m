//
//  NSData+ZHTools.m
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import "NSData(ZHTools).h"
#import <Foundation/Foundation.h>

@implementation NSData (ZHTools)

+ (NSData *)zh_dataWithJSONObject:(id)theObject {
    NSData *data;
    if ([theObject isKindOfClass:[NSDictionary class]] || [theObject isKindOfClass:[NSArray class]]) {
        data = [NSJSONSerialization dataWithJSONObject:theObject options:NSJSONWritingPrettyPrinted error:nil];
    }
    return data;
}

- (id)zh_jsonObjectValue {
    return [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:nil];
}

@end
