//
//  NSUserDefaults(ZHTools).m
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import "NSUserDefaults(ZHTools).h"

@implementation NSUserDefaults(ZHTools)

- (id)valueForKey:(NSString *)key {
    return [self objectForKey:key];
}

+ (id)zh_value4Key:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)zh_setValue:(id)value forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

+ (NSString *)zh_stringForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

+ (NSArray *)zh_arrayForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] arrayForKey:key];
}

+ (NSDictionary *)zh_dictionaryForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:key];
}

+ (NSData *)zh_dataForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] dataForKey:key];
}

+ (NSArray *)zh_stringArrayForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] stringArrayForKey:key];
}

+ (NSInteger)zh_integerForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+ (float)zh_floatForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] floatForKey:key];
}

+ (double)zh_doubleForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:key];
}

+ (BOOL)zh_boolForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}


@end
