//
//  NSString(ZHTools).h
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString(ZHTools)


/*!
 *
 *  @brief  计算指定字体、宽度下文本的高度
 *
 */
- (CGFloat)zh_heightWithFont:(id)font width:(CGFloat)width;

- (CGSize)zh_sizeWithFont:(id)font height:(CGFloat)height;

/*!
 *
 *  @brief  计算指定字体、高度下文本的宽度
 *
 */
- (CGFloat)zh_widthWithFont:(id)font height:(CGFloat)height;


/*!
 *
 *  @brief  计算指定字体、宽度、行距下文本的高度
 *
 */
- (CGFloat)zh_heightWithFont:(id)font width:(CGFloat)width lineSpace:(NSInteger)lineSpace;

/*!
 *
 *  @brief  去除空格后的字符串
 *
 */
- (NSString *)zh_trimedStringByWhitespace;

/*!
 *
 *  @brief  去除空格与空行后的字符串
 *
 */
- (NSString *)zh_trimedStringByWhitespaceAndNewlines;

/*!
 *
 *  @brief  JSON字符串转NSDictionary / NSArray
 *
 */
- (id)zh_jsonObjectValue;

/*!
 *
 *  @brief  NSDictionary / NSArray转JSON字符串
 *
 */
+ (NSString *)zh_jsonStringFromObject:(id)object;

/*!
 *
 *  @brief  判断字符串是否包含汉字
 *
 */
- (BOOL)zh_isContainChineseCharacter;

/*!
*
*  @brief  是否是手机号
*
*/
- (BOOL)zh_isMobileNumber ;

/*!
*
*  @brief  是否是邮件地址
*
*/
- (BOOL)zh_isEmailAddress ;

/*!
*
*  @brief  是否是座机号
*
*/
- (BOOL)zh_isFixedLineTelephoneNumber ;

/*!
*
*  @brief  返回字符数量限制的字符串
*
*/
- (NSString *)zh_stringCutted4ShownCharacterAmount:(NSInteger)charecterAmount ;

/*!
*
*  @brief  移除子字符串
*
*/
- (NSString *)zh_removeCharactors:(NSArray *)array ;

/*!
*
*  @brief  身份证号校验
*
*/
- (BOOL)zh_isValidateIDCardNumber ;

/*!
*
*  @brief  NSDate 转成易识别的字符串
*
*/
+ (NSString *)zh_readableStringFromDate:(NSDate *)date ;

/*!
*
*  @brief  创建目录
*
*/
- (BOOL)zh_createFilePath;

/*!
*
*  @brief  拨号
*
*/
- (void)zh_call ;

@end
