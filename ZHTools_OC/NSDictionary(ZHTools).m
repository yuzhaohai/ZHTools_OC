//
//  NSDictionary+ZHTools.m
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import "NSDictionary(ZHTools).h"
#import "NSString(ZHTools).h"
#import "NSArray(ZHTools).h"

/**
 NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"ZHTools", @"stop", @5, @2, @0, @".", @1, @3, @1, @4] forKeys:@[@"key0", @"key1", @"key1", @"key3", @"key4", @"key5", @"key6", @"key7", @"key8", @"key9"]];
 [dict enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
 
 NSLog(@"key:%@ -> value:%@", key, obj);
 
 if ([obj isKindOfClass:[NSString class]]) {
 [dict setValue:nil forKey:key];
 }
 
 if ([obj isKindOfClass:[NSString class]] && [@"stop" isEqualToString:obj]) {
 *stop = YES;
 }
 
 }];
 */

@implementation NSDictionary (ZHTools)

- (void)zh_each:(void (^)(id, id))block {
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        block(key, obj);
    }];
}

- (id)valueForKey:(NSString *)key {
    return [self objectForKey:key];
}

- (id)zh_value4Key:(NSString *)key {
    return [self objectForKey:key];
}

- (NSString *)zh_stringValue4Key:(NSString *)key {
    
    NSString *string;
    id value = [self zh_value4Key:key];
    
    if ([value isKindOfClass:[NSString class]]) {
        
        string = (NSString *)value;
        
    } else if([value isKindOfClass:[NSNumber class]]) {
        
        string = [value stringValue];
    }
    
    return string;
}

- (NSData *)zh_jsonDataValue {
    return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
}

+ (NSDictionary *)zh_dictionaryFromJSONData:(NSData *)data {
    NSDictionary *dict;
    if ([data isKindOfClass:[NSData class]]) {
        dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    return dict;
}

/**
 NSString 转 NSDictionary
 */
+ (NSDictionary *)zh_dictionaryFromJson:(NSString *)json {
    //string转data
    NSData * jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    //json解析
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return obj;
}

- (NSString *)zh_jsonStringValue {
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (jsonData == nil) {
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (NSDictionary *)zh_dictionaryFromURL:(NSURL *)url {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc]init];
    //传入url创建url组件类
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];
    //回调遍历所有参数，添加入字典
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [parm setObject:obj.value forKey:obj.name];
    }];
    return parm;
}

- (NSString *)zh_urlQueryStringValue {
    NSMutableString *string = [NSMutableString string];
    
    for (NSString *key in [self allKeys]) {
        
        if ([string length]) {
            [string appendString:@"&"];
        }
        
        NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
        NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
        NSString *escaped = [self[key] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];

        [string appendFormat:@"%@=%@", key, escaped];
        
    }
    
    return string;
}

- (NSMutableDictionary *)zh_removeNULL {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    for (NSString *strKey in self.allKeys) {
        NSValue *value = self[strKey];
        // 删除NSDictionary中的NSNull，再保存进字典
        if ([value isKindOfClass:NSDictionary.class]) {
            mdic[strKey] = [(NSDictionary *)value zh_removeNULL];
        }
        // 删除NSArray中的NSNull，再保存进字典
        else if ([value isKindOfClass:NSArray.class]) {
            mdic[strKey] = [(NSArray *)value zh_removeNULL];
        }
        // 剩余的非NSNull类型的数据保存进字典
        else if (![value isKindOfClass:NSNull.class]) {
            mdic[strKey] = self[strKey];
        }
    }
    return mdic;
}

@end
