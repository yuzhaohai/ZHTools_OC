//
//  UIImage(ZHTools).h
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIImage(ZHTools)

+ (UIImage *)zh_captureView:(UIView *)view ;

+ (UIImage *)zh_captureScrollView:(UIScrollView *)view ;

+ (UIImage *)zh_imageWithColor:(id)color ;

+ (UIImage *)zh_imageWithColor:(id)color size:(CGSize)size ;

+ (UIImage *)zh_imageNamed:(NSString *)name ;

+ (UIImage *)zh_imageNamed:(NSString *)name inBundle:(NSBundle *)bundle ;

+ (UIImage *)zh_launchImage ;

/// 获取应用图标
+ (UIImage *)zh_appIcon ;

- (UIImage*)zh_imageWithCornerRadius:(CGFloat)radius ;

@end
