//
//  ZHTools.m
//  ZHTools_ObjC
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import "ZHTools.h"

#import "UIImage(ZHTools).h"
#import <CoreText/CoreText.h>


@implementation ZHTools

+ (void)setScrollViewContentInsetAdjustmentNever {
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentViewController {
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    UIViewController *currentVC = [self getCurrentViewControllerFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentViewControllerFrom:(UIViewController *)rootViewController {
    UIViewController *currentViewController;
    
    if ([rootViewController presentedViewController]) {
        // 视图是被presented出来的
        
        rootViewController = [rootViewController presentedViewController];
    }
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentViewController = [self getCurrentViewControllerFrom:[(UITabBarController *)rootViewController selectedViewController]];
        
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentViewController = [self getCurrentViewControllerFrom:[(UINavigationController *)rootViewController visibleViewController]];
        
    } else if ([rootViewController presentedViewController]) {
        
        currentViewController = [self getCurrentViewControllerFrom:[rootViewController presentedViewController]];
        
    } else {
        currentViewController = rootViewController;
    }
    
    return currentViewController;
}

+ (NSString *)romanNumeralFromInteger:(NSInteger)integerValue {
    
    NSArray *numerals = @[@"M", @"CM", @"D", @"CD", @"C", @"XC", @"L", @"XL", @"X", @"IX", @"V", @"IV", @"I"];
    
    NSUInteger valueCount = numerals.count;
    NSUInteger values[] = {1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1};
    
    NSMutableString *numeralString = [NSMutableString string];
    
    for (NSUInteger i = 0; i < valueCount; i++)
    {
        while (integerValue >= values[i])
        {
            integerValue -= values[i];
            [numeralString appendString:[numerals objectAtIndex:i]];
        }
    }
    
    return numeralString;
    
}

+ (unsigned long long)sizeOfFolder:(NSString *)folderPath{
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *contentsEnumurator = [contents objectEnumerator];
    
    NSString *file;
    unsigned long long folderSize = 0;
    
    while (file = [contentsEnumurator nextObject]) {
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:file] error:nil];
        folderSize += [[fileAttributes objectForKey:NSFileSize] intValue];
    }
    return folderSize;
}



+ (int)randomNumberFrom:(int)start to:(int)end {
    return (int)(start + arc4random() % (end - start + 1));
}

+ (UIFont *)zh_FontWithTTFPath:(NSString *)ttfPath size:(CGFloat)size {
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:ttfPath]) {
        return [UIFont systemFontOfSize:size];
    }
    
    CFURLRef fontURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (__bridge CFStringRef)ttfPath, kCFURLPOSIXPathStyle, false);;
    CGDataProviderRef dataProvider = CGDataProviderCreateWithURL(fontURL);
    CFRelease(fontURL);
    CGFontRef graphicsFont = CGFontCreateWithDataProvider(dataProvider);
    CFRelease(dataProvider);
    CTFontRef smallFont = CTFontCreateWithGraphicsFont(graphicsFont, size, NULL, NULL);
    CFRelease(graphicsFont);
    
    UIFont *returnFont = (__bridge UIFont *)smallFont;
    CFRelease(smallFont);
    
    return returnFont;
}

@end
