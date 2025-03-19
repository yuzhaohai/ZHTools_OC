//
//  ZHTools.h
//  ZHTools_ObjC
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface ZHTools : NSObject


/**
 设置UIScrollView的contentInsetAdjustmentBehavior为UIScrollViewContentInsetAdjustmentNever
 */
+ (void)setScrollViewContentInsetAdjustmentNever;

/**
 获取当前显示的ViewController
 */
+ (UIViewController *)getCurrentViewController;

/**
 数字转罗马数字字符串
 */
+ (NSString *)romanNumeralFromInteger:(NSInteger)integerValue;

/**
生成随机数，包含start和end
*/
+ (int)randomNumberFrom:(int)start to:(int)end;

+ (UIFont *)zh_FontWithTTFPath:(NSString *)ttfPath size:(CGFloat)size ;


@end
