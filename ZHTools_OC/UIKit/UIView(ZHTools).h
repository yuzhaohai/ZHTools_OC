//
//  UIView(ZHTools).h
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^ZHGestureRecognizerBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (ZHTools)

#pragma mark - UIView
- (UIView * (^)(BOOL))zh_userInteractionEnabled;

- (UIView * (^)(NSInteger))zh_tag;

- (UIView * (^)(BOOL))zh_clipsToBounds;

- (UIView * (^)(id))zh_backgroundColor;

- (UIView * (^)(CGFloat))zh_alpha;

- (UIView * (^)(BOOL))zh_opaque;

- (UIView * (^)(BOOL))zh_hidden;

- (UIView * (^)(UIViewContentMode))zh_contentMode;

- (UIView * (^)(id))zh_tintColor;

- (UIView * (^)(CGRect))zh_frame;

- (UIView * (^)(UIView *))zh_superView;

#pragma mark - UIButton
- (UIView * (^)(BOOL))zh_enabled;

- (UIView * (^)(BOOL))zh_selected;

- (UIView * (^)(BOOL))zh_highlighted;

- (UIView * (^)(UIControlContentVerticalAlignment))zh_contentVerticalAlignment;

- (UIView * (^)(UIControlContentHorizontalAlignment))zh_contentHorizontalAlignment;

- (UIView * (^)(NSString *, UIControlState))zh_title4State;

- (UIView * (^)(NSAttributedString *, UIControlState))zh_attributedTitle4State;

- (UIView * (^)(id, SEL, UIControlEvents))zh_addTargetAction4Events;

- (UIView * (^)(id, UIControlState))zh_titleColor4State;

- (UIView * (^)(id, UIControlState))zh_image4State;

- (UIView * (^)(id, UIControlState))zh_backgroundImage4State;

- (UIView * (^)(id))zh_font;

- (UIView * (^)(NSTextAlignment))zh_textAlignment;

- (UIView * (^)(NSInteger))zh_numberOfLines;

- (UILabel * (^)(NSLineBreakMode))zh_lineBreakMode;

- (UIView * (^)(BOOL))zh_adjustsImageWhenHighlighted;

- (UIView * (^)(BOOL))zh_adjustsImageWhenDisabled;

- (UIView * (^)(BOOL))zh_showsTouchWhenHighlighted;

#pragma mark - UISwitch : UIControl
- (UIView * (^)(id))zh_onTintColor;

- (UIView * (^)(id))zh_thumbTintColor;

- (UIView * (^)(BOOL))zh_on;

#pragma mark - UITextField
- (UIView * (^)(NSString *))zh_text;

- (UIView * (^)(NSAttributedString *))zh_attributedText;

- (UIView * (^)(id))zh_textColor;

- (UIView * (^)(NSString *))zh_placeholder;

- (UIView * (^)(NSAttributedString *))zh_attributedPlaceholder;

- (UIView * (^)(BOOL))zh_clearsOnBeginEditing;

- (UIView * (^)(BOOL))zh_adjustsFontSizeToFitWidth;

- (UIView * (^)(id))zh_delegate;

- (UIView * (^)(UITextFieldViewMode))zh_clearButtonMode;

- (UIView * (^)(UIView *))zh_leftView;

- (UIView * (^)(UITextFieldViewMode))zh_leftViewMode;

- (UIView * (^)(UIView *))zh_rightView;

- (UIView * (^)(UITextFieldViewMode))zh_rightViewMode;

- (UIView * (^)(UIKeyboardType))zh_keyboardType;

- (UIView * (^)(BOOL))zh_secureTextEntry;

- (UIView * (^)(UIReturnKeyType))zh_returnKeyType;

#pragma mark - UIScrollView : UIView
- (UIView * (^)(BOOL))zh_bounces;

- (UIView * (^)(BOOL))zh_alwaysBounceVertical;

- (UIView * (^)(BOOL))zh_alwaysBounceHorizontal;

- (UIView * (^)(BOOL))zh_pagingEnabled;

- (UIView * (^)(BOOL))zh_scrollEnabled;

- (UIView * (^)(BOOL))zh_showsVerticalScrollIndicator;

- (UIView * (^)(BOOL))zh_showsHorizontalScrollIndicator;

#pragma mark - UITextView : UIScrollView
- (UIView * (^)(BOOL))zh_editable;

- (UIView * (^)(BOOL))zh_selectable;

- (UIView * (^)(UIEdgeInsets))zh_textContainerInset;

#pragma mark - UITableView / UICollectionView : UIScrollView
- (UIView * (^)(id))zh_dataSource;

- (UIView * (^)(BOOL))zh_allowsSelection;

- (UIView * (^)(UITableViewCellSeparatorStyle))zh_separatorStyle;

- (UIView * (^)(id))zh_separatorColor;

#pragma mark - UIImageView : UIView
- (UIView * (^)(id))zh_image;

- (UIView * (^)(id))zh_highlightedImage;

#pragma mark - UITableViewCell : UIView
- (UIView * (^)(UITableViewCellSelectionStyle))zh_selectionStyle;

- (UIView * (^)(UITableViewCellAccessoryType))zh_accessoryType;

#pragma mark - CALayer
- (UIView * (^)(CGFloat))zh_borderWidth;

- (UIView * (^)(id))zh_borderColor;

- (UIView * (^)(CGFloat))zh_cornerRadius;

- (UIView * (^)(BOOL))zh_masksToBounds;

#pragma mark - ZHButton
- (UIView * (^)(CGRect))zh_titleRect;

- (UIView * (^)(CGRect))zh_imageRect;

#pragma mark - 添加UIBezierPath圆角绘制相关属性
- (UIView * (^)(CGFloat, UIRectCorner))zh_addBezierPathRadiusWithCornersCorner;

- (UIViewController *)zh_viewController;

#pragma mark - 添加tap手势
- (void)zh_addTapGestureRecognizerWithBlock:(ZHGestureRecognizerBlock)block;

#pragma mark - 添加线条
- (void)zh_addLineWithFrame:(CGRect)frame color:(id)color;
- (void)zh_addLineWithFrame:(CGRect)frame color:(id)color cornerRadius:(CGFloat)cornerRadius;


#pragma mark -  UIAdditions
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

@end
