//
//  UILabel(ZHTools).m
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import "UILabel(ZHTools).h"
#import "UIView(ZHTools).h"


@implementation UILabel(ZHTools)

- (UILabel *)setText:(NSString *)text withFont:(UIFont *)font width:(CGFloat)width lineSpace:(float)lineSpace minHeight:(CGFloat)minHeight {
    if (!text || text.length < 1) {
        self.height = minHeight;
        self.text = nil;
        return self;
    }
    
    self.height = 0;
    self.font = font;
    self.width = width;
    self.numberOfLines = 0;
    NSMutableAttributedString *attributStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    [self setAttributedText:attributStr];
    [self sizeToFit];
    
    float padding = fabs(self.height - minHeight);
    if (padding < 10 && self.height + 10 > minHeight) {
        self.height += 10;
    }
    
    if (self.height < minHeight) {
        self.height = minHeight;
    }
    
    return self;
}


@end
