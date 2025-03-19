//
//  UIColor(ZHTools).m
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import "UIColor(ZHTools).h"

@implementation UIColor(ZHTools)

+ (UIColor *)zh_randomColor {
    int r = arc4random() % 255;
    int g = arc4random() % 255;
    int b = arc4random() % 255;
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

+ (UIColor *)zh_colorWithHex:(UInt32)hex {
    return [UIColor zh_colorWithHex:hex alpha:1.0];
}

+ (UIColor *)zh_colorWithHex:(UInt32)hex alpha:(float)alpha {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:alpha];
}

+ (UIColor *)zh_colorWithHexString:(NSString *)hexString {
    return [UIColor zh_colorWithHexString:hexString alpha:1.0f];
}

+ (UIColor *)zh_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    unsigned rgbValue = 0;
    
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    hexString = [hexString stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    hexString = [hexString stringByReplacingOccurrencesOfString:@"0X" withString:@""];
    
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor zh_colorWithHex:rgbValue alpha:alpha];
    
}

- (NSString *)zh_webColorStringValue {
    CGFloat *arrRGBA = [self zh_getRGB];
    
    int r = arrRGBA[0] * 255;
    int g = arrRGBA[1] * 255;
    int b = arrRGBA[2] * 255;

    NSString *webColor = [NSString stringWithFormat:@"#%02X%02X%02X", r, g, b];
    
    return webColor;
}

- (CGFloat *) zh_getRGB {
    UIColor * uiColor = self;
    
    CGColorRef cgColor = [uiColor CGColor];
    
    int numComponents = (int)CGColorGetNumberOfComponents(cgColor);
    
    if (numComponents == 4){
        
        static CGFloat * components = Nil;
        components = (CGFloat *) CGColorGetComponents(cgColor);
        
        return (CGFloat *)components;
        
    } else { //否则默认返回黑色
        
        static CGFloat components[4] = {0};
        CGFloat f = 0;
        
        //非RGB空间的系统颜色单独处理
        if ([uiColor isEqual:[UIColor whiteColor]]) {
            f = 1.0;
        } else if ([uiColor isEqual:[UIColor lightGrayColor]]) {
            f = 0.8;
        } else if ([uiColor isEqual:[UIColor grayColor]]) {
            f = 0.5;
        }
        
        components[0] = f;
        components[1] = f;
        components[2] = f;
        components[3] = 1.0;
        
        return (CGFloat *)components;
    }
}

+ (UIColor *)zh_gradientColorFrom:(id)color1 to:(id)color2 padding:(CGFloat)padding direction:(ZHColorGradientDirection)direction {
  UIColor *_color1 = [color1 isKindOfClass:UIColor.class] ? color1 : ([color1 isKindOfClass:NSString.class] ? [UIColor zh_colorWithHexString:color1] : nil);
  UIColor *_color2 = [color2 isKindOfClass:UIColor.class] ? color2 : ([color2 isKindOfClass:NSString.class] ? [UIColor zh_colorWithHexString:color2] : nil);
  
  if (!_color1 || !_color2) {
    return nil;
  }
    
    CGSize size;
    CGPoint endPoint;
    if (direction == ZHColorGradientDirection_Vertical) {
        size = CGSizeMake(1, padding);
        endPoint = CGPointMake(0, padding);
    } else {
        size = CGSizeMake(padding, 1);
        endPoint = CGPointMake(padding, 0);
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray* colors = [NSArray arrayWithObjects:(id)_color1.CGColor, (id)_color2.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), endPoint, 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}


@end
