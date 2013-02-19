//
//  TJAlertView.m
//  TJAlertView
//
//  Created by Thomas Joulin on 2/13/13.
//  Copyright (c) 2013 Thomas Joulin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "TJAlertView.h"
#import "OverlayWindow.h"

@interface TJAlertView ()
{
    OverlayWindow    *_window;
    UIImageView      *_backgroundImageView;
}

@end

@implementation TJAlertView

@synthesize backgroundImage = _backgroundImage;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if ((self = [super initWithFrame:CGRectMake(0, 0, 284, 165)]))
    {
        _title = title;
        _message = message;
        
        _contentEdgeInsets = UIEdgeInsetsMake(3, 6, 10, 6);
        
        _window = [[OverlayWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _window.opaque = NO;

        self.center = _window.center;
        
        [_window addSubview:self];
        
        [self setupView];
    }
    
    return self;
}

- (void)setupView
{
    _backgroundImageView = [[UIImageView alloc] initWithImage:self.backgroundImage];
    _backgroundImageView.frame = self.bounds;

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = self.title;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.titleLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.8];
    self.titleLabel.shadowOffset = CGSizeMake(0, -1);
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.messageLabel = [[UILabel alloc] init];
    self.messageLabel.text = self.message;
    self.messageLabel.font = [UIFont systemFontOfSize:16];
    self.messageLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.8];
    self.messageLabel.shadowOffset = CGSizeMake(0, -1);
    self.messageLabel.backgroundColor = [UIColor clearColor];
    self.messageLabel.textColor = [UIColor whiteColor];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.numberOfLines = 2;
    
    self.cancelButton = [[UIButton alloc] init];
    self.firstOtherButton = [[UIButton alloc] init];
    
    UIImage *defaultButtonBackgroundImage = [[UIImage imageNamed:@"UIPopupAlertSheetDefaultButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    UIImage *pressedButtonBackgroundImage = [[UIImage imageNamed:@"UIPopupAlertSheetButtonPress"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];

    
    self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.cancelButton.titleLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.8];
    self.cancelButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
    self.cancelButton.tag = 0;
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton setBackgroundImage:defaultButtonBackgroundImage forState:UIControlStateNormal];
    [self.cancelButton setBackgroundImage:pressedButtonBackgroundImage forState:UIControlStateHighlighted];
    [self.cancelButton addTarget:self action:@selector(_dismissAlertView:) forControlEvents:UIControlEventTouchUpInside];
    
    self.firstOtherButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.firstOtherButton.titleLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.8];
    self.firstOtherButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
    self.firstOtherButton.tag = 1;
    [self.firstOtherButton setTitle:@"Continue" forState:UIControlStateNormal];
    [self.firstOtherButton setBackgroundImage:self.buttonBackgroundImage forState:UIControlStateNormal];
    [self.firstOtherButton setBackgroundImage:pressedButtonBackgroundImage forState:UIControlStateHighlighted];
    [self.firstOtherButton addTarget:self action:@selector(_dismissAlertView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupSubviewFrames];

    [self addSubview:_backgroundImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.messageLabel];
    [self addSubview:self.cancelButton];
    [self addSubview:self.firstOtherButton];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(_contentEdgeInsets.left, _contentEdgeInsets.top, self.frame.size.width - _contentEdgeInsets.left - _contentEdgeInsets.right, self.frame.size.height - _contentEdgeInsets.top - _contentEdgeInsets.bottom)];
    v.backgroundColor = [UIColor clearColor];
    v.layer.borderWidth = 1;
    v.layer.borderColor = [UIColor redColor].CGColor;
//    [self addSubview:v];
}

- (void)setupSubviewFrames
{
    CGFloat         buttonSeparatorMargin = 8;
    UIEdgeInsets    buttonEdgeInsets = UIEdgeInsetsMake(0, 5, 6, 5);
    CGSize          buttonSize = (CGSize) { (self.frame.size.width - _contentEdgeInsets.left - _contentEdgeInsets.right - buttonEdgeInsets.left - buttonEdgeInsets.right - buttonSeparatorMargin) / 2, 43 };
    
    NSLog(@"%@", NSStringFromCGRect(self.frame));

    self.titleLabel.frame = (CGRect) { _contentEdgeInsets.left, _contentEdgeInsets.top + 16, self.frame.size.width - _contentEdgeInsets.left - _contentEdgeInsets.right, 18 };
    self.messageLabel.frame = (CGRect) { _contentEdgeInsets.left, CGRectGetMaxY(self.titleLabel.frame) + 12.f, self.frame.size.width - _contentEdgeInsets.left - _contentEdgeInsets.right, 36 };
    self.cancelButton.frame = (CGRect) { _contentEdgeInsets.left + buttonEdgeInsets.left, CGRectGetMaxY(self.bounds) - _contentEdgeInsets.bottom - buttonSize.height - buttonEdgeInsets.bottom, buttonSize };
    self.firstOtherButton.frame = (CGRect) { CGRectGetMaxX(self.cancelButton.frame) + buttonSeparatorMargin, self.cancelButton.frame.origin.y, buttonSize };
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
{
    _contentEdgeInsets = contentEdgeInsets;
    
    [self setupSubviewFrames];    
}

- (UIImage *)backgroundImage
{
    if (!_backgroundImage)
    {
        _backgroundImage = [[UIImage imageNamed:@"UIPopupAlertSheetBackground"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 0, 30, 0)];
    }
    
    return _backgroundImage;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    
    _backgroundImageView.image = backgroundImage;
}

- (UIImage *)buttonBackgroundImage
{
    if (!_buttonBackgroundImage)
    {
        _buttonBackgroundImage = [[UIImage imageNamed:@"UIPopupAlertSheetButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    }
    
    return _buttonBackgroundImage;
}

- (void)show
{
    CGFloat     animationDuration = 1.f / 3.f;
    CGFloat     keyframeDuration = (1.5 * (animationDuration / 3.f));
    
    [_window makeKeyAndVisible];

    self.transform = CGAffineTransformMakeScale(0.4, 0.4);
    self.alpha = 0;

    [UIView
        animateWithDuration:keyframeDuration animations:^
        {
            self.alpha = 1;
            self.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }
        completion:^(BOOL finished)
        {
            [UIView
                animateWithDuration:keyframeDuration / 2 animations:^
                {
                    self.transform = CGAffineTransformMakeScale(0.9, 0.9);
                }
                completion:^(BOOL finished)
                {
                    [UIView
                        animateWithDuration:keyframeDuration / 2 animations:^
                        {
                            self.transform = CGAffineTransformMakeScale(1, 1);
                        }];
                }];
        }];
}

- (void)_dismissAlertView:(UIButton *)clickedButton
{
    [self dismissWithClickedButtonIndex:clickedButton.tag animated:YES];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    [UIView animateWithDuration:0.25 / 2.f
                     animations:^{
                         self.alpha = 0;
                     } completion:^(BOOL finished) {
                         [_window resignKeyWindow];
                         _window = nil;
                     }];
}

@end
