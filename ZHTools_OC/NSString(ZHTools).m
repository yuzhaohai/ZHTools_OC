//
//  NSString(ZHTools).m
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import "NSString(ZHTools).h"
#import "NSDate(ZHTools).h"

@implementation NSString(ZHTools)

- (CGFloat)zh_widthWithFont:(id)font height:(CGFloat)height {
  UIFont *_font = [font isKindOfClass:UIFont.class] ? font : ([font isKindOfClass:NSNumber.class] ? [UIFont systemFontOfSize:[font floatValue]] : nil);
  if (!_font) {
        return 0;
    }
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName: _font, NSParagraphStyleAttributeName: paragraph};
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                     options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine)
                                  attributes:attributes
                                     context:nil].size;
    
    return ceil(size.width);
}

- (CGSize)zh_sizeWithFont:(id)font height:(CGFloat)height {
  UIFont *_font = [font isKindOfClass:UIFont.class] ? font : ([font isKindOfClass:NSNumber.class] ? [UIFont systemFontOfSize:[font floatValue]] : nil);
  if (!_font) {
    return CGSizeZero;
  }
  
  NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
  paragraph.lineBreakMode = NSLineBreakByWordWrapping;
  
  NSDictionary *attributes = @{NSFontAttributeName: _font, NSParagraphStyleAttributeName: paragraph};
  
  CGSize size = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                   options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine)
                                attributes:attributes
                                   context:nil].size;
  
  return size;
}

- (CGFloat)zh_heightWithFont:(id)font width:(CGFloat)width {
    
  UIFont *_font = [font isKindOfClass:UIFont.class] ? font : ([font isKindOfClass:NSNumber.class] ? [UIFont systemFontOfSize:[font floatValue]] : nil);
  if (!_font) {
        return 0;
    }
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName: _font, NSParagraphStyleAttributeName: paragraph};
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                         options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine)
                                      attributes:attributes
                                         context:nil].size;
    
    return ceil(size.height);
}

- (CGFloat)zh_heightWithFont:(id)font width:(CGFloat)width lineSpace:(NSInteger)lineSpace {
    
  UIFont *_font = [font isKindOfClass:UIFont.class] ? font : ([font isKindOfClass:NSNumber.class] ? [UIFont systemFontOfSize:[font floatValue]] : nil);
  if (!_font) {
        return 0;
    }
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.lineSpacing = lineSpace;
    
    NSDictionary *attributes = @{NSFontAttributeName: _font, NSParagraphStyleAttributeName: paragraph};
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                     options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine)
                                  attributes:attributes
                                     context:nil].size;
    
    return ceil(size.height);
}

- (NSString *)zh_trimedStringByWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)zh_trimedStringByWhitespaceAndNewlines {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (id)zh_jsonObjectValue {
    NSError *error;
    
    id theObject = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"fail to get dictioanry from JSON: %@, error: %@", self, error);
    }
    
    return theObject;
}

+ (NSString *)zh_jsonStringFromObject:(id)object {
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"Got          an              error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

- (BOOL)zh_isContainChineseCharacter {
    
    NSUInteger length = [self length];
    
    for (NSUInteger i = 0; i < length; i++) {
        
        NSRange range = NSMakeRange(i, 1);
        
        NSString *subString = [self substringWithRange:range];
        
        const char *cString = [subString UTF8String];
        
        if (strlen(cString) == 3) {
            return YES;
        }
        
    }
    
    return NO;
}

- (BOOL)zh_isMobileNumber {
    NSString *pattern = @"^1+[345789]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)zh_isEmailAddress {
    BOOL result = NO;
    if ([self isKindOfClass:[NSString class]] && self.length > 0) {
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        result = [emailTest evaluateWithObject:self];
    }
    return result;
}

- (BOOL)zh_isFixedLineTelephoneNumber {
    //验证输入的固话中带 "-"符号
    NSString * strNum = @"^(0\\d{2,3}-?\\d{7,8}$)";
    NSPredicate *checktest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum];
    BOOL isPhene = [checktest evaluateWithObject:self];
    NSString * strNum1 = @"^(\\d{7,8}$)";
    NSPredicate *checktest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum1];
    BOOL isPhene1 = [checktest1 evaluateWithObject:self];
    if (isPhene || isPhene1) {
        return YES;
    }
    return NO;
}

- (NSString *)zh_stringCutted4ShownCharacterAmount:(NSInteger)charecterAmount {
    __block NSString * returnValue = self;
    __block NSInteger length = 0;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        BOOL isEmojiOrChineseCharacter = NO;
        const unichar hs = [substring characterAtIndex:0];
        
        if (0x4E00 <= hs && hs <=0x9FFF) {//汉字
            
            isEmojiOrChineseCharacter = YES;
            
        }else if (0xd800 <= hs && hs <= 0xdbff) {
            
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                
                const int uc = (hs - 0xd800) * 0x400 + (ls - 0xdc00) + 0x10000;
                
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEmojiOrChineseCharacter = YES;
                }
            }
            
        }else if (substring.length > 1){
            
            const unichar ls = [substring characterAtIndex:1];
            
            if (ls == 0x20e3) {
                isEmojiOrChineseCharacter = YES;
            }
            
        }else{
            
            if (0x2100 <= hs && hs <= 0x27ff) {
                isEmojiOrChineseCharacter = YES;
            }else if (0x2B05 <= hs && hs <= 0x2b07){
                isEmojiOrChineseCharacter = YES;
            }else if (0x2934 <= hs && hs <= 0x2935) {
                isEmojiOrChineseCharacter = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEmojiOrChineseCharacter = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                isEmojiOrChineseCharacter = YES;
            }
            
        }
        
        length = isEmojiOrChineseCharacter ? length + 2 : length + 1;
        
        if (length > charecterAmount) {
            returnValue = [self substringToIndex:substringRange.location];
            
            *stop = YES;
        }
        
    }];
    
    return returnValue;
}

- (NSString *)zh_removeCharactors:(NSArray *)array {
    NSString *string = self;
    
    for (NSString *s in array) {
        if ([s isKindOfClass:[NSString class]]) {
            string = [string stringByReplacingOccurrencesOfString:s withString:@""];
        }
    }
    
    return string;
    
}

- (BOOL)zh_isValidateIDCardNumber {
    NSString *identityCard = self;
    
    //判断是否为空
    if (identityCard==nil||identityCard.length <= 0) {
        return NO;
    }
    //判断是否是18位，末尾是否是x
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if(![identityCardPredicate evaluateWithObject:identityCard]){
        return NO;
    }
    //判断生日是否合法
    NSRange range = NSMakeRange(6,8);
    NSString *datestr = [identityCard substringWithRange:range];
    NSDateFormatter *formatter = [NSDate zh_sharedDateFormatter];
    [formatter setDateFormat : @"yyyyMMdd"];
    if([formatter dateFromString:datestr]==nil){
        return NO;
    }
    
    //判断校验位
    if(identityCard.length==18)
    {
        NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
        NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
        for(int i=0;i<17;i++){
            idCardWiSum+=[[identityCard substringWithRange:NSMakeRange(i,1)] intValue]*[idCardWi[i] intValue];
        }
        
        int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
        NSString *idCardLast=[identityCard substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast intValue]==[idCardY[idCardMod] intValue]){
                return YES;
            }else{
                return NO;
            }
        }
    }
    return NO;
}

+ (NSString *)zh_readableStringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [NSDate zh_sharedDateFormatter];
    
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    
    NSString * timeString = nil;
    
    NSTimeInterval cha =  0 - [date timeIntervalSinceDate:[NSDate date]];
    
    if (cha/3600 < 1) {
        
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        int num= [timeString intValue];
        
        if (num <= 1) {
            
            timeString = [NSString stringWithFormat:@"刚刚"];
            
        }else{
            
            timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
            
        }
        
    }
    
    if (cha/3600 > 1 && cha/86400 < 1) {
        
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        [dateFormatter setDateFormat:@"dd"];
        
        NSString *messageTimeStr = [dateFormatter stringFromDate:date];
        
        NSString *currentTimeStr = [dateFormatter stringFromDate:[NSDate date]];
        
        if ([messageTimeStr isEqualToString:currentTimeStr]) {
            
            timeString = [NSString stringWithFormat:@"%@小时前", timeString];
            
        }else{
            
            [dateFormatter setDateFormat:@"HH:mm"];
            
            NSString *timeStr = [dateFormatter stringFromDate:date];
            
            timeString = [NSString stringWithFormat:@"昨天 %@",timeStr];
            
        }
        
        
        
    }
    
    if (cha/86400 > 1) {
        
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        int num = [timeString intValue];
        
        if (num < 2) {
            [dateFormatter setDateFormat:@"HH:mm"];
            NSString *timeStr = [dateFormatter stringFromDate:date];
            timeString = [NSString stringWithFormat:@"昨天 %@",timeStr];
            
        }else{
            timeString =[dateFormatter stringFromDate:date];
            
        }
    }
    
    return timeString;
}

- (BOOL)zh_createFilePath {
    
    NSFileManager * manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:self]) {
        
        return YES;
        
    }else{
        
        NSError * error;
        if ([manager createDirectoryAtPath:self withIntermediateDirectories:YES attributes:nil error:&error]) {
            
            return YES;
            
        }else{
            
            NSLog(@"创建目录失败");
            return NO;
            
        }
        
    }
    
}

- (void)zh_call {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:self]] options:@{} completionHandler:^(BOOL success) {
        
    }];
}

@end
