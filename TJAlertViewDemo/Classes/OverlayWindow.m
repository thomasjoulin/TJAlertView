//
//  OverlayWindow.m
//  TJAlertView
//
//  Created by Thomas Joulin on 2/14/13.
//  Copyright (c) 2013 Thomas Joulin. All rights reserved.
//

#import "OverlayWindow.h"

@interface OverlayWindow ()
{
    UIWindow *_previousKeyWindow;
}

@end

@implementation OverlayWindow

- (void)makeKeyAndVisible
{
    _previousKeyWindow = [[UIApplication sharedApplication] keyWindow];

    self.windowLevel = UIWindowLevelAlert;

    [super makeKeyAndVisible];
}

- (void)resignKeyWindow
{
    [super resignKeyWindow];

    [_previousKeyWindow makeKeyWindow];
}
    
- (void)drawRect:(CGRect)rect
{
    CGFloat width = self.frame.size.width + 20;
    CGFloat height  = self.frame.size.height + 20;
    CGFloat locations[3] = { 0.0, 0.5, 1.0};
    CGFloat components[12] = { 0.7, 0.7, 0.7, 0.2,
                               0, 0, 0, 0.5,
                               0, 0, 0, 0.7
                             };
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef backgroundGradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 3);
    CGColorSpaceRelease(colorspace);
    CGContextDrawRadialGradient(UIGraphicsGetCurrentContext(),
                                backgroundGradient,
                                CGPointMake(width/2, height/2), 0,
                                CGPointMake(width/2, height/2), width,
                                0);
    CGGradientRelease(backgroundGradient);
}

@end