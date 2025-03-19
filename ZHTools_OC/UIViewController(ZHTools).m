//
//  UIViewController+ZHTools.m
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import "UIViewController(ZHTools).h"

@implementation UIViewController (ZHTools)

- (void)goBack {
    if (self.navigationController && ([self.navigationController.viewControllers indexOfObject:self] > 0)) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else if (self.presentingViewController) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    }
}

@end
