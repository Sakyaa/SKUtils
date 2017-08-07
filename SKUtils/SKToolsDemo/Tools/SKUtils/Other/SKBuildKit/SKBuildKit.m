//
//  SKBuildKit.m
//  ThePartyBuild
//
//  Created by Sakya on 17/4/28.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "SKBuildKit.h"

@implementation SKBuildKit
/**
 1 @property(readwrite) CGFloat lineSpacing;　　　　　　　　　　　　　　//行间距
 2 @property(readwrite) CGFloat paragraphSpacing;　　　　　　　　　　　//段间距
 3 @property(readwrite) NSTextAlignment alignment;　　　　　　　　　　 //对齐方式
 4 @property(readwrite) CGFloat firstLineHeadIndent;　　　　　　　　　 //首行缩紧
 5 @property(readwrite) CGFloat headIndent;　　　　　　　　　　　　　　 //除首行之外其他行缩进
 6 @property(readwrite) CGFloat tailIndent;　　　　　　　　　　　　　　 //每行容纳字符的宽度
 7 @property(readwrite) NSLineBreakMode lineBreakMode;　　　　　　　  //换行方式
 8 @property(readwrite) CGFloat minimumLineHeight;　　　　　　　　　　 //最小行高
 9 @property(readwrite) CGFloat maximumLineHeight;　　　　　　　　　　 //最大行高
 */

/**text*/
+(UILabel *)labelWithBackgroundColor:(UIColor *)backgroundColor
                           textColor:(UIColor *)textColor
                        textAligment:(NSTextAlignment)textAligment
                       numberOfLines:(NSInteger)numberOfLines
                                text:(NSString *)text
                                font:(UIFont *)font{
    
    UILabel *label = [[UILabel alloc] init];
    if (backgroundColor) label.backgroundColor = backgroundColor;
    label.text = text;
    label.textColor = textColor;
    label.numberOfLines = numberOfLines;
    label.font = font;
    label.textAlignment = textAligment;
    return label;
}

/**attributedString*/
+(UILabel *)labelWithBackgroundColor:(UIColor *)backgroundColor
                        textAligment:(NSTextAlignment)textAligment
                       numberOfLines:(NSInteger)numberOfLines
                    attributedString:(NSMutableAttributedString *)text{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = backgroundColor;
    if (text) label.attributedText = text;
    label.numberOfLines = numberOfLines;
    label.textAlignment = textAligment;
    return label;
    
}

+(NSMutableAttributedString *)attributedStringWithString:(NSString *)string
                                          paragraphStyle:
(NSMutableParagraphStyle *)paragraphStyle
                                               textColor:
(UIColor *)textColor
                                                textFont:
(UIFont *)font {
    
    if (!string) return nil;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    if (paragraphStyle) {
        [params setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    }
    if (textColor) {
        [params setObject:textColor forKey:NSForegroundColorAttributeName];
    }
    if (font) {
        [params setObject:font forKey:NSFontAttributeName];
    }
    [attributeString addAttributes:params range:NSMakeRange(0, string.length)];
    return attributeString;
    
}
+ (NSMutableParagraphStyle *)paragraphStyleLineSpace:
(CGFloat)lineSpace
                                 firstLineHeadIndent:
(CGFloat)firstLineHeadIndent {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // <--- indention if you need it
    if (firstLineHeadIndent > 0)  paragraphStyle.firstLineHeadIndent = firstLineHeadIndent;
    return paragraphStyle;
}

#pragma mark - publick
//创建tableView
+ (UITableView *)tableViewWithFrame:(CGRect)frame
                      delegateAgent:(id)agent
                          superview:(UIView *)superview {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [tableView setDelegate:agent];
    [tableView setDataSource:agent];
    [tableView setTableFooterView:[[UIView alloc] init]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor whiteColor]];
    if (superview) [superview addSubview:tableView];
    return tableView;
}
+ (UIButton *)buttonTitle:(NSString *)title
          backgroundColor:(UIColor *)backgroundColor
               titleColor:(UIColor *)titleColor
                     font:(UIFont *)font
             cornerRadius:(CGFloat)cornerRadius
                superview:(UIView *)superview {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:backgroundColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;

    if (cornerRadius > 0) {
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:cornerRadius];
    }
    if (superview) [superview addSubview:button];
    return button;
    
}
+ (UIButton *)buttonWithImageName:(NSString *)imageName
                        superview:(UIView *)superview
                           target:(id)target
                           action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (superview) [superview addSubview:button];
    return button;
    
}

@end
