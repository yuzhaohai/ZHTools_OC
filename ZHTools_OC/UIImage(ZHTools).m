//
//  UIImage(ZHTools).m
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import "UIImage(ZHTools).h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "UIColor(ZHTools).h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation UIImage(ZHTools)

+ (UIImage *)zh_captureView:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, [UIScreen mainScreen].scale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)zh_captureScrollView:(UIScrollView *)view {
    
    UIImage* image = nil;

    UIGraphicsBeginImageContextWithOptions(view.contentSize, view.opaque, [UIScreen mainScreen].scale);
    {
        CGPoint savedContentOffset = view.contentOffset;
        CGRect savedFrame = view.frame;
        
        view.contentOffset = CGPointZero;
        view.frame = CGRectMake(0, 0, view.contentSize.width, view.contentSize.height);
        
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        view.contentOffset = savedContentOffset;
        view.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)zh_imageWithColor:(id)color {
    return [self zh_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)zh_imageWithColor:(id)color size:(CGSize)size {
  UIColor *_color = [color isKindOfClass:UIColor.class] ? color : ([color isKindOfClass:NSString.class] ? [UIColor zh_colorWithHexString:color] : UIColor.clearColor);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [_color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)zh_imageNamed:(NSString *)name {
    return [UIImage zh_imageNamed:name inBundle:[NSBundle mainBundle]];
}

+ (UIImage *)zh_imageNamed:(NSString *)name inBundle:(NSBundle *)bundle {
    NSString *extension = [name pathExtension] ? : @"png";
    
    name = [name substringToIndex:(name.length - (extension.length + 1))];
    
    if (![@"png" isEqualToString:extension]) {
        return [UIImage imageWithContentsOfFile:[bundle pathForResource:name ofType:extension]];
    }
    
    if (name.length > 3) {
        NSString *suffix = [name substringFromIndex:(name.length - 3)];
        
        if ([@[@"@2x", @"@3x"] containsObject:suffix]) {
            name = [name substringToIndex:(name.length - suffix.length)];
        }
    }
    
    if ([UIScreen mainScreen].scale == 3.0) {
        NSString *newName = [name stringByAppendingString:@"@3x"];
        NSString *path = [bundle pathForResource:newName ofType:extension];
        
        if (path) {
            return [UIImage imageWithContentsOfFile:path];
        }
    }
    
    NSString *newName = [name stringByAppendingString:@"@2x"];
    NSString *path = [bundle pathForResource:newName ofType:extension];
    
    if (path) {
        return [UIImage imageWithContentsOfFile:path];
    }
    
    return [UIImage imageWithContentsOfFile:[bundle pathForResource:name ofType:extension]];
}

+ (UIImage *)zh_imageFromVideoWithPath:(NSString *)path {
    NSURL *url = [NSURL URLWithString:path];
    if (!url || ![url scheme]) {
        url = [NSURL fileURLWithPath:path];
    }
    
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:nil];//
    
    //获取视频时长，单位：秒
    
    NSLog(@"%llu",urlAsset.duration.value/urlAsset.duration.timescale);
    
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    
    
    generator.appliesPreferredTrackTransform = YES;
    
    generator.maximumSize = CGSizeMake(1136, 640);
    
    NSError *error = nil;
    
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(10, 10) actualTime:NULL error:&error];
    
    UIImage *image = [UIImage imageWithCGImage: img];
    
    return image;
}

+ (UIImage *)zh_launchImage {
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    
    NSString *viewOrientation = nil;
    if (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) || ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait)) {
        viewOrientation = @"Portrait";
    }else {
        viewOrientation = @"Landscape";
    }
    
    NSString *launchImage = nil;
    
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    
    return [UIImage imageNamed:launchImage];
}

/// 获取应用图标
+ (UIImage *)zh_appIcon {
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    UIImage* image = [UIImage imageNamed:icon];
    return image;
}

- (void)zh_save2AlbumWitnCompleteBlock:(void(^)(id zhObject))completeBlock {
    
    PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
    
    switch (photoAuthorStatus) {
      case PHAuthorizationStatusAuthorized:{
          
          [[PHPhotoLibrary sharedPhotoLibrary]performChanges:^{
              
              [PHAssetChangeRequest creationRequestForAssetFromImage:self];
              
          } completionHandler:^(BOOL success, NSError * _Nullable error) {
              
              if (completeBlock) {
                  completeBlock(@(success));
              }
              
          }];
          
          break;
      }
      case PHAuthorizationStatusNotDetermined:{
          
          [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
              
              if (status == PHAuthorizationStatusAuthorized) {
                  [self zh_save2AlbumWitnCompleteBlock:completeBlock];
              }
              
          }];
          break;
          
      }
      default:
          break;
    }
}

- (UIImage*)zh_imageWithCornerRadius:(CGFloat)radius {
    
    CGRect rect = (CGRect){0.f,0.f,self.size};
    
    // void UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale);
    //size——同UIGraphicsBeginImageContext,参数size为新创建的位图上下文的大小
    //    opaque—透明开关，如果图形完全不用透明，设置为YES以优化位图的存储。
    //    scale—–缩放因子
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    
    //根据矩形画带圆角的曲线
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    
    [self drawInRect:rect];
    
    //图片缩放，是非线程安全的
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
  
    return image;
}

@end
