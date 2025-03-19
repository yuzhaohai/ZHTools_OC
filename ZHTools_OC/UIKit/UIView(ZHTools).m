//
//  UIView(ZHTools).m
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import "UIView(ZHTools).h"
#import "UIColor(ZHTools).h"
#import "ZHButton.h"
#import <objc/runtime.h>

@implementation UIView(ZHTools)


#pragma mark -  UIView
- (UIView * (^)(BOOL))zh_userInteractionEnabled {
    return ^id(BOOL attribute) {
        self.userInteractionEnabled = attribute;
        return self;
    };
}

- (UIView * (^)(NSInteger))zh_tag {
    return ^id(NSInteger attribute) {
        self.tag = attribute;
        return self;
    };
}

- (UIView * (^)(BOOL))zh_clipsToBounds {
    return ^id(BOOL attribute) {
        self.clipsToBounds = attribute;
        return self;
    };
}

- (UIView * (^)(id))zh_backgroundColor {
    return ^id(id attribute) {
        UIColor *_color = [attribute isKindOfClass:UIColor.class] ? attribute : ([attribute isKindOfClass:NSString.class] ? [UIColor zh_colorWithHexString:attribute] : nil);
        if (_color) {
            self.backgroundColor = _color;
        }
        return self;
    };
}

- (UIView * (^)(CGFloat))zh_alpha {
    return ^id(CGFloat attribute) {
        self.alpha = attribute;
        return self;
    };
}

- (UIView * (^)(BOOL))zh_opaque {
    return ^id(BOOL attribute) {
        self.opaque = attribute;
        return self;
    };
}

- (UIView * (^)(BOOL))zh_hidden {
    return ^id(BOOL attribute) {
        self.hidden = attribute;
        return self;
    };
}

- (UIView * (^)(UIViewContentMode))zh_contentMode {
    return ^id(UIViewContentMode attribute) {
        self.contentMode = attribute;
        return self;
    };
}

- (UIView * (^)(id))zh_tintColor {
    return ^id(id attribute) {
        UIColor *_color = [attribute isKindOfClass:UIColor.class] ? attribute : ([attribute isKindOfClass:NSString.class] ? [UIColor zh_colorWithHexString:attribute] : nil);
        if (_color) {
            self.tintColor = _color;
        }
        return self;
    };
}

- (UIView * (^)(CGRect))zh_frame {
    return ^id(CGRect attribute) {
        self.frame = attribute;
        return self;
    };
}

- (UIView * (^)(UIView *))zh_superView {
    return ^id(UIView *attribute) {
        [attribute addSubview:self];
        return self;
    };
}

#pragma mark -  UIButton
- (UIView * (^)(BOOL))zh_enabled {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setEnabled:)]) {
            ((UIButton *)self).enabled = attribute;
        }
        return self;
    };
}

- (UIView * (^)(BOOL))zh_selected {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setSelected:)]) {
            ((UIButton *)self).selected = attribute;
        }
        return self;
    };
}

- (UIView * (^)(BOOL))zh_highlighted {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setHighlighted:)]) {
            ((UIButton *)self).highlighted = attribute;
        }
        return self;
    };
}

- (UIView * (^)(UIControlContentVerticalAlignment))zh_contentVerticalAlignment {
    return ^id(UIControlContentVerticalAlignment attribute) {
        if ([self respondsToSelector:@selector(setContentVerticalAlignment:)]) {
            ((UIButton *)self).contentVerticalAlignment = attribute;
        }
        return self;
    };
}

- (UIView * (^)(UIControlContentHorizontalAlignment))zh_contentHorizontalAlignment {
    return ^id(UIControlContentHorizontalAlignment attribute) {
        if ([self respondsToSelector:@selector(setContentHorizontalAlignment:)]) {
            ((UIButton *)self).contentHorizontalAlignment = attribute;
        }
        return self;
    };
}

- (UIView * (^)(NSString *, UIControlState))zh_title4State {
    return ^id(NSString *title, UIControlState state) {
        if ([self isKindOfClass:UIButton.class]) {
            [((UIButton *)self) setTitle:title forState:state];
        }
        return self;
    };
}

- (UIView * (^)(NSAttributedString *, UIControlState))zh_attributedTitle4State {
    return ^id(NSAttributedString *title, UIControlState state) {
        if ([self isKindOfClass:UIButton.class]) {
            [((UIButton *)self) setAttributedTitle:title forState:state];
        }
        return self;
    };
}

- (UIView * (^)(id, SEL, UIControlEvents))zh_addTargetAction4Events {
    return ^id(id target, SEL selector, UIControlEvents events) {
        if ([self isKindOfClass:UIButton.class]) {
            [((UIButton *)self) addTarget:target action:selector forControlEvents:events];
        }
        return self;
    };
}

- (UIView * (^)(id, UIControlState))zh_titleColor4State {
    return ^id(id color, UIControlState state) {
        if ([self isKindOfClass:UIButton.class]) {
            UIColor *_color = [color isKindOfClass:UIColor.class] ? color : ([color isKindOfClass:NSString.class] ? [UIColor zh_colorWithHexString:color] : nil);
            if (_color) {
                [((UIButton *)self) setTitleColor:_color forState:state];
            }
        }
        return self;
    };
}

- (UIView * (^)(id, UIControlState))zh_image4State {
    return ^id(id image, UIControlState state) {
        if ([self isKindOfClass:UIButton.class]) {
            UIImage *_image = [image isKindOfClass:UIImage.class] ? image : ([image isKindOfClass:NSString.class] ? [UIImage imageNamed:image] : nil);
            if (_image) {
                [((UIButton *)self) setImage:_image forState:state];
            }
        }
        return self;
    };
}

- (UIView * (^)(id, UIControlState))zh_backgroundImage4State {
    return ^id(id image, UIControlState state) {
        if ([self isKindOfClass:UIButton.class]) {
            UIImage *_image = [image isKindOfClass:UIImage.class] ? image : ([image isKindOfClass:NSString.class] ? [UIImage imageNamed:image] : nil);
            if (_image) {
                [((UIButton *)self) setBackgroundImage:_image forState:state];
            }
        }
        return self;
    };
}

- (UIView * (^)(id))zh_font {
    return ^id(id attribute) {
        UIFont *font = [attribute isKindOfClass:UIFont.class] ? attribute : ([attribute isKindOfClass:NSNumber.class] ? [UIFont systemFontOfSize:[attribute floatValue]] : nil);
        if ([self respondsToSelector:@selector(setFont:)]) {
            ((UILabel *)self).font = font;
        } else if ([self isKindOfClass:UIButton.class]) {
            ((UIButton *)self).titleLabel.font = font;
        }
        return self;
    };
}

- (UIView * (^)(NSTextAlignment))zh_textAlignment {
    return ^id(NSTextAlignment attribute) {
      if ([self respondsToSelector:@selector(setTextAlignment:)]) {
            ((UILabel *)self).textAlignment = attribute;
        } else if ([self isKindOfClass:UIButton.class]) {
            ((UIButton *)self).titleLabel.textAlignment = attribute;
        }
        return self;
    };
}

- (UIView * (^)(NSInteger))zh_numberOfLines {
    return ^id(NSInteger attribute) {
        if ([self respondsToSelector:@selector(setNumberOfLines:)]) {
            ((UILabel *)self).numberOfLines = attribute;
        } else if ([self isKindOfClass:UIButton.class]) {
            ((UIButton *)self).titleLabel.numberOfLines = attribute;
        }
        return self;
    };
}

- (UILabel * (^)(NSLineBreakMode))zh_lineBreakMode {
    return ^id(NSLineBreakMode attribute) {
        if ([self respondsToSelector:@selector(setLineBreakMode:)]) {
            ((UILabel *)self).lineBreakMode = attribute;
        }
        return self;
    };
}

- (UIView * (^)(BOOL))zh_adjustsImageWhenHighlighted {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setAdjustsImageWhenHighlighted:)]) {
            ((UIButton *)self).adjustsImageWhenHighlighted = attribute;
        }
        return self;
    };
}

- (UIView * (^)(BOOL))zh_adjustsImageWhenDisabled {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setAdjustsImageWhenDisabled:)]) {
            ((UIButton *)self).adjustsImageWhenDisabled = attribute;
        }
        return self;
    };
}

- (UIView * (^)(BOOL))zh_showsTouchWhenHighlighted {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setShowsTouchWhenHighlighted:)]) {
            ((UIButton *)self).showsTouchWhenHighlighted = attribute;
        }
        return self;
    };
}

#pragma mark -  UISwitch : UIControl
- (UIView * (^)(id))zh_onTintColor {
    return ^id(id attribute) {
        UIColor *_color = [attribute isKindOfClass:UIColor.class] ? attribute : ([attribute isKindOfClass:NSString.class] ? [UIColor zh_colorWithHexString:attribute] : nil);
        if ([self respondsToSelector:@selector(setOnTintColor:)] && _color) {
            ((UISwitch *)self).onTintColor = _color;
        }
        return self;
    };
}

- (UIView * (^)(id))zh_thumbTintColor {
    return ^id(id attribute) {
        UIColor *_color = [attribute isKindOfClass:UIColor.class] ? attribute : ([attribute isKindOfClass:NSString.class] ? [UIColor zh_colorWithHexString:attribute] : nil);
        if ([self respondsToSelector:@selector(setOnTintColor:)] && _color) {
            ((UISwitch *)self).thumbTintColor = _color;
        }
        return self;
    };
}

- (UIView * (^)(BOOL))zh_on {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setOn:)]) {
            ((UISwitch *)self).on = attribute;
        }
        return self;
    };
}

#pragma mark -  UITextField
- (UIView * (^)(NSString *))zh_text {
    return ^id(NSString *attribute) {
        if ([self respondsToSelector:@selector(setText:)]) {
            ((UILabel *)self).text = attribute;
        }
        return self;
    };
}

- (UIView * (^)(NSAttributedString *))zh_attributedText {
    return ^id(NSAttributedString *attribute) {
        if ([self respondsToSelector:@selector(setAttributedText:)]) {
            ((UILabel *)self).attributedText = attribute;
        }
        return self;
    };
}

- (UIView * (^)(id))zh_textColor {
    return ^id(id attribute) {
        UIColor *_color = [attribute isKindOfClass:UIColor.class] ? attribute : ([attribute isKindOfClass:NSString.class] ? [UIColor zh_colorWithHexString:attribute] : nil);
        if ([self respondsToSelector:@selector(setTextColor:)] && _color) {
            ((UILabel *)self).textColor = _color;
        }
        return self;
    };
}

- (UIView * (^)(NSString *))zh_placeholder {
    return ^id(NSString *attribute) {
        if ([self respondsToSelector:@selector(setPlaceholder:)]) {
            ((UITextField *)self).placeholder = attribute;
        }
        return self;
    };
}

- (UIView * (^)(NSAttributedString *))zh_attributedPlaceholder {
    return ^id(NSAttributedString *attribute) {
        if ([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            ((UITextField *)self).attributedPlaceholder = attribute;
        }
        return self;
    };
}

- (UIView * (^)(BOOL))zh_clearsOnBeginEditing {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(clearsOnBeginEditing)]) {
            ((UITextField *)self).clearsOnBeginEditing = attribute;
        }
        return self;
    };
}

- (UIView * (^)(BOOL))zh_adjustsFontSizeToFitWidth {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(adjustsFontSizeToFitWidth)]) {
            ((UITextField *)self).adjustsFontSizeToFitWidth = attribute;
        }
        return self;
    };
}

- (UIView * (^)(id))zh_delegate {
    return ^id(id attribute) {
        if ([self respondsToSelector:@selector(setDelegate:)]) {
            ((UITextField *)self).delegate = attribute;
        }
        return self;
    };
}

- (UIView * (^)(UITextFieldViewMode))zh_clearButtonMode {
    return ^id(UITextFieldViewMode mode) {
        if ([self respondsToSelector:@selector(setClearButtonMode:)]) {
            ((UITextField *)self).clearButtonMode = mode;
        }
        return self;
    };
}

- (UIView * (^)(UIView *))zh_leftView {
    return ^id(UIView *view) {
        if ([self respondsToSelector:@selector(setLeftView:)]) {
            ((UITextField *)self).leftView = view;
        }
        return self;
    };
}

- (UIView * (^)(UITextFieldViewMode))zh_leftViewMode {
    return ^id(UITextFieldViewMode mode) {
        if ([self respondsToSelector:@selector(setLeftViewMode:)]) {
            ((UITextField *)self).leftViewMode = mode;
        }
        return self;
    };
}

- (UIView * (^)(UIView *))zh_rightView {
    return ^id(UIView *view) {
        if ([self respondsToSelector:@selector(setRightView:)]) {
            ((UITextField *)self).rightView = view;
        }
        return self;
    };
}

- (UIView * (^)(UITextFieldViewMode))zh_rightViewMode {
    return ^id(UITextFieldViewMode mode) {
        if ([self respondsToSelector:@selector(setRightViewMode:)]) {
            ((UITextField *)self).rightViewMode = mode;
        }
        return self;
    };
}

- (UIView * (^)(UIKeyboardType))zh_keyboardType {
    return ^id(UIKeyboardType type) {
        if ([self respondsToSelector:@selector(setKeyboardType:)]) {
            ((UITextField *)self).keyboardType = type;
        }
        return self;
    };
}

- (UIView * (^)(BOOL))zh_secureTextEntry {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setSecureTextEntry:)]) {
            ((UITextField *)self).secureTextEntry = attribute;
        }
        return self;
    };
}

- (UIView * (^)(UIReturnKeyType))zh_returnKeyType {
    return ^id(UIReturnKeyType type) {
        if ([self respondsToSelector:@selector(setReturnKeyType:)]) {
            ((UITextField *)self).returnKeyType = type;
        }
        return self;
    };
}

#pragma mark -  UIScrollView : UIView
- (UIView * (^)(BOOL))zh_bounces {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setBounces:)]) {
            ((UIScrollView *)self).bounces = attribute;
        }
        return self;
    };
}

- (UIView * (^)(BOOL))zh_alwaysBounceVertical {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setAlwaysBounceVertical:)]) {
            ((UIScrollView *)self).alwaysBounceVertical = attribute;
        }
        return self;
    };
}

- (UIView * (^)(BOOL))zh_alwaysBounceHorizontal {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setAlwaysBounceHorizontal:)]) {
            ((UIScrollView *)self).alwaysBounceHorizontal = attribute;
        }
        return self;
    };
}

- (UIView * (^)(BOOL))zh_pagingEnabled {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setPagingEnabled:)]) {
            ((UIScrollView *)self).pagingEnabled = attribute;
        }
        return self;
    };
}

- (UIView * (^)(BOOL))zh_scrollEnabled {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setScrollEnabled:)]) {
            ((UIScrollView *)self).scrollEnabled = attribute;
        }
        return self;
    };
}

- (UIView * (^)(BOOL))zh_showsVerticalScrollIndicator {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setShowsVerticalScrollIndicator:)]) {
            ((UIScrollView *)self).showsVerticalScrollIndicator = attribute;
        }
        return self;
    };
}

- (UIView * (^)(BOOL))zh_showsHorizontalScrollIndicator {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setShowsHorizontalScrollIndicator:)]) {
            ((UIScrollView *)self).showsHorizontalScrollIndicator = attribute;
        }
        return self;
    };
}

#pragma mark -  UITextView : UIScrollView
- (UIView * (^)(BOOL))zh_editable {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setEditable:)]) {
            ((UITextView *)self).editable = attribute;
        }
        return self;
    };
}

- (UIView * (^)(BOOL))zh_selectable {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setSelectable:)]) {
            ((UITextView *)self).selectable = attribute;
        }
        return self;
    };
}

- (UIView * (^)(UIEdgeInsets))zh_textContainerInset {
    return ^id(UIEdgeInsets attribute) {
        if ([self respondsToSelector:@selector(setTextContainerInset:)]) {
            ((UITextView *)self).textContainerInset = attribute;
        }
        return self;
    };
}

#pragma mark -  UITableView / UICollectionView : UIScrollView
- (UIView * (^)(id))zh_dataSource {
    return ^id(id attribute) {
        if ([self respondsToSelector:@selector(setDataSource:)]) {
            ((UITableView *)self).dataSource = attribute;
        }
        return self;
    };
}

- (UIView * (^)(BOOL))zh_allowsSelection {
    return ^id(BOOL attribute) {
        if ([self respondsToSelector:@selector(setAllowsSelection:)]) {
            ((UITableView *)self).allowsSelection = attribute;
        }
        return self;
    };
}

- (UIView * (^)(UITableViewCellSeparatorStyle))zh_separatorStyle {
    return ^id(UITableViewCellSeparatorStyle attribute) {
        if ([self respondsToSelector:@selector(setSeparatorStyle:)]) {
            ((UITableView *)self).separatorStyle = attribute;
        }
        return self;
    };
}

- (UIView * (^)(id))zh_separatorColor {
    return ^id(id attribute) {
        UIColor *_color = [attribute isKindOfClass:UIColor.class] ? attribute : ([attribute isKindOfClass:NSString.class] ? [UIColor zh_colorWithHexString:attribute] : nil);
        if ([self respondsToSelector:@selector(setSeparatorColor:)] && _color) {
            ((UITableView *)self).separatorColor = _color;
        }
        return self;
    };
}

#pragma mark -  UIImageView : UIView
- (UIView * (^)(id))zh_image {
    return ^id(id attribute) {
        UIImage *_image = [attribute isKindOfClass:UIImage.class] ? attribute : ([attribute isKindOfClass:NSString.class] ? [UIImage imageNamed:attribute] : nil);
        if ([self isKindOfClass:UIImageView.class] && _image) {
            ((UIImageView *)self).image = _image;
        }
        return self;
    };
}

- (UIView * (^)(id))zh_highlightedImage {
    return ^id(id attribute) {
        UIImage *_image = [attribute isKindOfClass:UIImage.class] ? attribute : ([attribute isKindOfClass:NSString.class] ? [UIImage imageNamed:attribute] : nil);
        if ([self isKindOfClass:UIImageView.class] && _image) {
            ((UIImageView *)self).highlightedImage = _image;
        }
        return self;
    };
}

#pragma mark -  UITableViewCell : UIView
- (UIView * (^)(UITableViewCellSelectionStyle))zh_selectionStyle {
    return ^id(UITableViewCellSelectionStyle attribute) {
        if ([self respondsToSelector:@selector(setSelectionStyle:)]) {
            ((UITableViewCell *)self).selectionStyle = attribute;
        }
        return self;
    };
}

- (UIView * (^)(UITableViewCellAccessoryType))zh_accessoryType {
    return ^id(UITableViewCellAccessoryType attribute) {
        if ([self respondsToSelector:@selector(setAccessoryType:)]) {
            ((UITableViewCell *)self).accessoryType = attribute;
        }
        return self;
    };
}

#pragma mark -  CALayer
- (UIView * (^)(CGFloat))zh_borderWidth {
    return ^id(CGFloat attribute) {
        self.layer.borderWidth = attribute;
        return self;
    };
}

- (UIView * (^)(id))zh_borderColor {
    return ^id(id attribute) {
        UIColor *_color = [attribute isKindOfClass:UIColor.class] ? attribute : ([attribute isKindOfClass:NSString.class] ? [UIColor zh_colorWithHexString:attribute] : nil);
        if (_color) {
            self.layer.borderColor = _color.CGColor;
        }
        return self;
    };
}

- (UIView * (^)(CGFloat))zh_cornerRadius {
    return ^id(CGFloat attribute) {
        self.layer.cornerRadius = attribute;
        return self;
    };
}

- (UIView * (^)(BOOL))zh_masksToBounds {
    return ^id(BOOL attribute) {
        self.layer.masksToBounds = attribute;
        return self;
    };
}

#pragma mark -  ZHButton
- (UIView * (^)(CGRect))zh_titleRect {
    return ^id(CGRect rect) {
        if ([self respondsToSelector:@selector(setTitleRect:)]) {
            ((ZHButton *)self).titleRect = rect;
        }
        return self;
    };
}

- (UIView * (^)(CGRect))zh_imageRect {
    return ^id(CGRect rect) {
        if ([self respondsToSelector:@selector(setImageRect:)]) {
            ((ZHButton *)self).imageRect = rect;
        }
        return self;
    };
}

#pragma mark -  添加UIBezierPath圆角绘制相关属性
- (UIView * (^)(CGFloat, UIRectCorner))zh_addBezierPathRadiusWithCornersCorner {
    return ^id(CGFloat radius, UIRectCorner corners) {
        UIBezierPath *maskPath =  [UIBezierPath bezierPathWithRoundedRect:self.bounds      byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
        return self;
    };
}

- (UIViewController *)zh_viewController {
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

#pragma mark -  添加tap手势
static char zh_GestureRecognizerKey;
static char zh_GestureRecognizerBlockKey;

- (void)zh_addTapGestureRecognizerWithBlock:(ZHGestureRecognizerBlock)block {
    if (!self.userInteractionEnabled) {
        self.userInteractionEnabled = YES;
    }
    
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &zh_GestureRecognizerKey);
    
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
        
        [self addGestureRecognizer:gesture];
        
        objc_setAssociatedObject(self, &zh_GestureRecognizerKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &zh_GestureRecognizerBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (tapGestureRecognizer.state == UIGestureRecognizerStateRecognized) {
        ZHGestureRecognizerBlock block = objc_getAssociatedObject(self, &zh_GestureRecognizerBlockKey);
        if (block) {
            block(tapGestureRecognizer);
        }
    }
}

- (void)zh_addLineWithFrame:(CGRect)frame color:(id)color {
    [self zh_addLineWithFrame:frame color:color cornerRadius:0];
}

- (void)zh_addLineWithFrame:(CGRect)frame color:(id)color cornerRadius:(CGFloat)cornerRadius {
    UIColor *_color = [color isKindOfClass:UIColor.class] ? color : ([color isKindOfClass:NSString.class] ? [UIColor zh_colorWithHexString:color] : nil);
    if (!_color) {
        return;
    }
    
    CAGradientLayer *shadow = [CAGradientLayer layer];
    shadow.frame = frame;
    shadow.backgroundColor = [color CGColor];
    shadow.cornerRadius = cornerRadius;
    [self.layer addSublayer:shadow];
}

#pragma mark -  UIAdditions
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
