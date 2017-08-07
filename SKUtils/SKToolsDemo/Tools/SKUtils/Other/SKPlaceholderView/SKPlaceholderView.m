//
//  SKPlaceholderView.m
//  ThePartyBuild
//
//  Created by Sakya on 17/5/2.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "SKPlaceholderView.h"


#define IMAGEVIEWSITSIZE SKXFrom6(100)

@interface SKPlaceholderView () {
    
    SKPlaceholderViewType _viewType;
    
    UIImageView *_placeholderImageView;
    
    
}

@end


@implementation SKPlaceholderView
/**
- (instancetype)initWithFrame:(CGRect)frame placeholderType:(SKPlaceholderViewType)placeholderType {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _viewType = placeholderType;
        self.backgroundColor = [UIColor whiteColor];
        [self initCustomView];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGsetureDetected:)];
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}
#pragma mark -- setter
- (void)setTitleText:(NSString *)titleText {
    
    _titleText = titleText;
    _titleLabel.text = titleText;
    
}
- (void)setImageName:(NSString *)imageName {
    
    //特定的bundleImage;
    [_placeholderImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"DefaultPlaceholder.bundle/%@",imageName]]];
}
- (void)setButtonTitle:(NSString *)buttonTitle {
    [_defaultButton setTitle:buttonTitle forState:UIControlStateNormal];
}
-(void)initCustomView {
    
    CGFloat labelOriginY =  CGRectGetHeight(self.frame) / 2;
    
    if (_viewType == SKPlaceholderViewSimpleType) {
        
        CGFloat imgHeight = IMAGEVIEWSITSIZE ;
        if (CGRectGetHeight(self.frame) < kScreen_Height/2) {
            imgHeight = imgHeight * CGRectGetHeight(self.frame) * 2 / kScreen_Height;
        }
        labelOriginY =  CGRectGetHeight(self.frame) * 0.4 - imgHeight * 5/6;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.center.x - imgHeight/2, labelOriginY, imgHeight, imgHeight)];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:imageView];
        labelOriginY = CGRectGetMaxY(imageView.frame) + 5;
        _placeholderImageView = imageView;
        
    } else if (_viewType == SKPlaceholderViewDefaultType) {
        
        CGFloat imgHeight = IMAGEVIEWSIZE ;
        if (CGRectGetHeight(self.frame) < kScreen_Height/2) {
            imgHeight = imgHeight * CGRectGetHeight(self.frame) * 2 / kScreen_Height;
        }
        labelOriginY =  CGRectGetHeight(self.frame) / 6;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.center.x - imgHeight/2, labelOriginY, imgHeight, imgHeight)];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:imageView];
        labelOriginY = CGRectGetMaxY(imageView.frame) + 5;
        _placeholderImageView = imageView;
        
    }
    
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, labelOriginY, self.bounds.size.width - 40, 40)];
        [titleLabel setFont:FONT_16];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
        labelOriginY += 40;
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, labelOriginY, self.bounds.size.width - 60, 40)];
        [detailLabel setFont:FONT_15];
        [detailLabel setTextColor:Color_9];
        [detailLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:detailLabel];
        _detailLabel = detailLabel;
        labelOriginY += 50;
        
    if (_viewType == SKPlaceholderViewDefaultType) {
        
        UIButton *defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [defaultButton setFrame:CGRectMake(15, labelOriginY, kScreen_Width - 30, 45)];
        [defaultButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [defaultButton setTitle:@"完成" forState:UIControlStateNormal];
        [defaultButton.titleLabel setFont:FONT_16];
        defaultButton.backgroundColor = Color_system_red;
        defaultButton.layer.cornerRadius = ControlsCornerRadius;
        [defaultButton addTarget:self action:@selector(clickEventsDelete:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:defaultButton];
        _defaultButton = defaultButton;
    }
}

- (void)clickEventsDelete:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(placeholderViewButtonActionDetected:)]) {
        [self.delegate placeholderViewButtonActionDetected:sender];
    }
}
#pragma mark -- tapGesture
- (void)tapGsetureDetected:(UITapGestureRecognizer *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(placeholderViewButtonActionDetected:)]) {
        [_delegate placeholderViewButtonActionDetected:nil];
    }
}
 */

@end
