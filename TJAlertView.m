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
    NSMutableArray   *_otherButtons;
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
        _delegate = delegate;
        
        _contentEdgeInsets = UIEdgeInsetsMake(3, 6, 10, 6);

        _window = [[OverlayWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _window.opaque = NO;
        
        if (cancelButtonTitle)
        {
            self.cancelButton = [[UIButton alloc] init];
            [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        }
        
        if (otherButtonTitles)
        {
            _otherButtons = [[NSMutableArray alloc] init];

            va_list args;
            va_start(args, otherButtonTitles);
            for (NSString *buttonTitle = otherButtonTitles; buttonTitle != nil; buttonTitle = va_arg(args, NSString *))
            {
                UIButton *button = [[UIButton alloc] init];
                [button setTitle:buttonTitle forState:UIControlStateNormal];
                [_otherButtons addObject:button];
            }
            va_end(args);
        }
            
        self.center = _window.center;
        
        [_window addSubview:self];
        
        [self setupView];
    }
    
    return self;
}

- (void)setupView
{
    UIImage *defaultButtonBackgroundImage = [[UIImage imageNamed:@"UIPopupAlertSheetDefaultButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    UIImage *pressedButtonBackgroundImage = [[UIImage imageNamed:@"UIPopupAlertSheetButtonPress"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];

    _backgroundImageView = [[UIImageView alloc] initWithImage:self.backgroundImage];
    _backgroundImageView.frame = self.bounds;
    [self addSubview:_backgroundImageView];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = self.title;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.titleLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.8];
    self.titleLabel.shadowOffset = CGSizeMake(0, -1);
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    self.messageLabel = [[UILabel alloc] init];
    self.messageLabel.text = self.message;
    self.messageLabel.font = [UIFont systemFontOfSize:16];
    self.messageLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.8];
    self.messageLabel.shadowOffset = CGSizeMake(0, -1);
    self.messageLabel.backgroundColor = [UIColor clearColor];
    self.messageLabel.textColor = [UIColor whiteColor];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.numberOfLines = 2;    
    [self addSubview:self.messageLabel];

    if (self.cancelButton)
    {
        self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.cancelButton.titleLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.8];
        self.cancelButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
        self.cancelButton.tag = 0;
        [self.cancelButton setBackgroundImage:defaultButtonBackgroundImage forState:UIControlStateNormal];
        [self.cancelButton setBackgroundImage:pressedButtonBackgroundImage forState:UIControlStateHighlighted];
        [self.cancelButton addTarget:self action:@selector(_buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cancelButton];
    }

    [self setupSubviewFrames];

    for (UIButton *button in _otherButtons)
    {
        button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateDisabled];
        [button setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.8] forState:UIControlStateNormal];
        [button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateDisabled];
        button.titleLabel.shadowOffset = CGSizeMake(0, -1);
        // We should not set tag but use indexOfObject in dismissButtonAtIndex:
        button.tag = [_otherButtons indexOfObject:button] + 1;
        [button setBackgroundImage:[[UIImage imageNamed:@"UIPopupAlertSheetButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)] forState:UIControlStateNormal];
        [button setBackgroundImage:pressedButtonBackgroundImage forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(_buttonPressed:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:button];
    }

    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(_contentEdgeInsets.left, _contentEdgeInsets.top, self.frame.size.width - _contentEdgeInsets.left - _contentEdgeInsets.right, self.frame.size.height - _contentEdgeInsets.top - _contentEdgeInsets.bottom)];
    v.backgroundColor = [UIColor clearColor];
    v.layer.borderWidth = 1;
    v.layer.borderColor = [UIColor redColor].CGColor;
//    [self addSubview:v];
}

- (UIButton *)firstOtherButton
{
    return [_otherButtons objectAtIndex:0];
}

- (void)setupSubviewFrames
{
    CGFloat         buttonSeparatorMargin = 8;
    UIEdgeInsets    buttonEdgeInsets = UIEdgeInsetsMake(0, 5, 6, 5);
    
    self.titleLabel.frame = (CGRect) { _contentEdgeInsets.left, _contentEdgeInsets.top + 16, self.frame.size.width - _contentEdgeInsets.left - _contentEdgeInsets.right, 18 };
    self.messageLabel.frame = (CGRect) { _contentEdgeInsets.left, CGRectGetMaxY(self.titleLabel.frame) + 12.f, self.frame.size.width - _contentEdgeInsets.left - _contentEdgeInsets.right, 36 };

    if ([_otherButtons count] == 0)
    {
        CGSize  buttonSize = (CGSize) { self.frame.size.width - _contentEdgeInsets.left - _contentEdgeInsets.right - buttonEdgeInsets.left - buttonEdgeInsets.right, 43 };

        self.cancelButton.frame = (CGRect) { _contentEdgeInsets.left + buttonEdgeInsets.left, CGRectGetMaxY(self.bounds) - _contentEdgeInsets.bottom - buttonSize.height - buttonEdgeInsets.bottom, buttonSize };
    }
    else if ([_otherButtons count] == 1)
    {
        UIButton    *button = [_otherButtons objectAtIndex:0];
        CGSize      buttonSize = (CGSize) { (self.frame.size.width - _contentEdgeInsets.left - _contentEdgeInsets.right - buttonEdgeInsets.left - buttonEdgeInsets.right - buttonSeparatorMargin) / 2, 43 };
        
        self.cancelButton.frame = (CGRect) { _contentEdgeInsets.left + buttonEdgeInsets.left, CGRectGetMaxY(self.bounds) - _contentEdgeInsets.bottom - buttonSize.height - buttonEdgeInsets.bottom, buttonSize };
        button.frame = (CGRect) { CGRectGetMaxX(self.cancelButton.frame) + buttonSeparatorMargin, self.cancelButton.frame.origin.y, buttonSize };
    }
    else
    {
        
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setMessage:(NSString *)message
{
    _message = message;
    
    self.messageLabel.text = message;
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

- (void)setButtonBackgroundImage:(UIImage *)buttonBackgroundImage
{
    
}

- (void)show
{
    CGFloat     animationDuration = 1.f / 3.f;
    CGFloat     keyframeDuration = (1.5 * (animationDuration / 3.f));
    
    [_window makeKeyAndVisible];

    self.transform = CGAffineTransformMakeScale(0.4, 0.4);
    self.alpha = 0;

    if ([_otherButtons count])
    {
        UIButton *button = [_otherButtons objectAtIndex:0];
        BOOL     enabled = YES;
        
        if ([self.delegate respondsToSelector:@selector(alertViewShouldEnableFirstOtherButton:)])
        {
            enabled = [self.delegate alertViewShouldEnableFirstOtherButton:(UIAlertView *)self];
        }

        button.enabled = enabled;
    }

    if ([self.delegate respondsToSelector:@selector(willPresentAlertView:)])
    {
        [self.delegate willPresentAlertView:(UIAlertView *)self];
    }

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
                        }
                        completion:^(BOOL finished)
                        {
                            if ([self.delegate respondsToSelector:@selector(didPresentAlertView:)])
                            {
                                [self.delegate didPresentAlertView:(UIAlertView *)self];
                            }
                        }];
                }];
        }];
}

- (void)_buttonPressed:(UIButton *)pressedButton
{
    [self dismissWithClickedButtonIndex:pressedButton.tag animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)])
    {
        [self.delegate alertView:(UIAlertView *)self clickedButtonAtIndex:pressedButton.tag];
    }
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    if ([self.delegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)])
    {
        [self.delegate alertView:(UIAlertView *)self willDismissWithButtonIndex:buttonIndex];
    }

    [UIView animateWithDuration:0.25 / 2.f
                     animations:^{
                         self.alpha = 0;
                     } completion:^(BOOL finished) {
                         [_window resignKeyWindow];
                         _window = nil;
                         
                         if ([self.delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)])
                         {
                             [self.delegate alertView:(UIAlertView *)self didDismissWithButtonIndex:buttonIndex];
                         }
                     }];
}

@end
