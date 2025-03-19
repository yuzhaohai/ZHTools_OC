//
//  NSData+ZHTools.h
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (ZHTools)

///  NSDictionary / NSArray 转 jsonData
+ (NSData *)zh_dataWithJSONObject:(id)theObject ;

///  jsonData 转 NSDictionary / NSArray
- (id)zh_jsonObjectValue ;

@end

NS_ASSUME_NONNULL_END
