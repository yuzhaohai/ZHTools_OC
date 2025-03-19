//
//  NSArray(ZHTools).m
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import "NSArray(ZHTools).h"
#import "NSDictionary(ZHTools).h"

/**
 数组便利（反向）
 
 
 NSMutableArray *mutableArray = [NSMutableArray arrayWithObjects:@9, @5, @2, @0, @"stop", @5, @2, @0, @".", @1, @3, @1, @4,  nil];
 
 mutableArray[0] = @"ZHTools";
 
 [mutableArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
 
 NSLog(@"%@", obj);
 
 if (![obj isKindOfClass:[NSNumber class]]) {
 [mutableArray removeObjectAtIndex:idx];
 }
 
 if ([obj isKindOfClass:[NSString class]] && [@"stop" isEqualToString:obj]) {
 *stop = YES;
 }
 
 }];
 
 NSString *separator = @"->";
 
 NSString *string = [mutableArray componentsJoinedByString:separator];
 NSLog(@"%@", string);
 
 NSArray *array = [string componentsSeparatedByString:separator];
 NSLog(@"%@", array);
 */

/*
 数组中每一个元素执行一个方法
 
 makeObjectsPerformSelector:
 */

/*
 数组排序
 
 sortedArrayUsingSelector:
 */

/*
 筛选
 
 filteredArrayUsingPredicate:
 */

@implementation NSArray (ZHTools)

- (id)zh_objectAtIndex:(NSUInteger)index {
    if (self.count > index) {
        return self[index];
    } else {
        return nil;
    }
}

- (void)zh_each:(void (^)(id))block {
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block(obj);
    }];
}

- (void)zh_reverseEach:(void (^)(id))block {
    [self enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block(obj);
    }];
}

- (void)zh_eachWithIndex:(void (^)(id, NSInteger))block {
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block(obj, idx);
    }];
}

- (void)zh_reverseEachWithIndex:(void (^)(id, NSInteger))block {
    [self enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block(obj, idx);
    }];
}

- (NSArray *)zh_filter:(BOOL (^)(id object))block {
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return block(evaluatedObject);
    }]];
}

+ (NSArray *)zh_arrayFromData:(NSData *)data {
    NSMutableArray *array;
    if ([data isKindOfClass:[NSData class]]) {
        array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return array;
}

- (NSData *)zh_dataValue {
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}

/**
 Json 转 NSArray
 */
+ (NSArray *)zh_arrayFromJson:(NSString *)json {
    //string转data
    NSData * jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    //json解析
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return obj;
}

- (NSString *)zh_jsonStringValue {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:0
                                                         error:&error];

    if ([jsonData length] && error == nil){
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else{
        return nil;
    }
}

- (NSMutableArray *)zh_removeNULL {
    NSMutableArray *marr = [NSMutableArray array];
    for (int i = 0; i < self.count; i++) {
        NSValue *value = self[i];
        // 删除NSDictionary中的NSNull，再添加进数组
        if ([value isKindOfClass:NSDictionary.class]) {
            [marr addObject:[(NSDictionary *)value zh_removeNULL]];
        }
        // 删除NSArray中的NSNull，再添加进数组
        else if ([value isKindOfClass:NSArray.class]) {
            [marr addObject:[(NSArray *)value zh_removeNULL]];
        }
        // 剩余的非NSNull类型的数据添加进数组
        else if (![value isKindOfClass:NSNull.class]) {
            [marr addObject:value];
        }
    }
    return marr;
}

@end
