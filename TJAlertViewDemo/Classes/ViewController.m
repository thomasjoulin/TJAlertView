//
//  ViewController.m
//  TJAlertView
//
//  Created by Thomas Joulin on 2/13/13.
//  Copyright (c) 2013 Thomas Joulin. All rights reserved.
//

#import "ViewController.h"
#import "TJAlertView.h"

@interface ViewController ()
{
    TJAlertView *_alertView;
}

@end

@implementation ViewController

- (IBAction)showNativeAlertView:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert Label" message:@"Tap Continue and sign in to view account information" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    [alertView show];
}

- (IBAction)showNativeAlertViewSingleButton:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert Label" message:@"Tap Continue and sign in to view account information" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alertView show];
}


- (IBAction)showNativeAlertViewMultipleButtons:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert Label" message:@"Tap Continue and sign in to view account information" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", @"Button 2", @"Button 3", nil];
    [alertView show];
}

- (IBAction)showDefaultStyleAlertView:(id)sender
{
    _alertView = [[TJAlertView alloc] initWithTitle:@"Alert Label" message:@"Tap Continue and sign in to view account information" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    
    [_alertView show];
}

- (IBAction)showCustomStyleAlertView:(id)sender
{
    _alertView = [[TJAlertView alloc] initWithTitle:@"Alert Label" message:@"Tap Continue and sign in to view account information" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    _alertView.backgroundImage = [[UIImage imageNamed:@"alertView-background-2"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 6, 6, 6)];

    _alertView.titleLabel.textColor = [UIColor colorWithRed:115.f/255.f green:115.f/255.f blue:115.f/255.f alpha:1];
    _alertView.titleLabel.shadowColor = [UIColor whiteColor];

    _alertView.messageLabel.textColor = [UIColor colorWithRed:115.f/255.f green:115.f/255.f blue:115.f/255.f alpha:1];
    _alertView.messageLabel.shadowColor = [UIColor whiteColor];
    _alertView.messageLabel.shadowOffset = CGSizeMake(0, 1);

    _alertView.contentEdgeInsets = UIEdgeInsetsMake(2, 3, 3, 3);
    
    [_alertView.cancelButton setTitleColor:[UIColor colorWithRed:115.f/255.f green:115.f/255.f blue:115.f/255.f alpha:1] forState:UIControlStateNormal];
    [_alertView.cancelButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_alertView.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_alertView.cancelButton setTitleShadowColor:[UIColor colorWithRed:115.f/255.f green:115.f/255.f blue:115.f/255.f alpha:1] forState:UIControlStateHighlighted];
    [_alertView.cancelButton setBackgroundImage:[[UIImage imageNamed:@"alertView-button-2"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 3, 4, 3)] forState:UIControlStateNormal];
    [_alertView.cancelButton setBackgroundImage:[[UIImage imageNamed:@"alertView-button-2-highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 3, 4, 3)] forState:UIControlStateHighlighted];
    _alertView.cancelButton.titleLabel.shadowOffset = CGSizeMake(0, 1);

    [_alertView.firstOtherButton setTitleColor:[UIColor colorWithRed:115.f/255.f green:115.f/255.f blue:115.f/255.f alpha:1] forState:UIControlStateNormal];
    [_alertView.firstOtherButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_alertView.firstOtherButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_alertView.firstOtherButton setTitleShadowColor:[UIColor colorWithRed:115.f/255.f green:115.f/255.f blue:115.f/255.f alpha:1] forState:UIControlStateHighlighted];
    [_alertView.firstOtherButton setBackgroundImage:[[UIImage imageNamed:@"alertView-button-2"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 3, 4, 3)] forState:UIControlStateNormal];
    [_alertView.firstOtherButton setBackgroundImage:[[UIImage imageNamed:@"alertView-button-2-highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 3, 4, 3)] forState:UIControlStateHighlighted];
    _alertView.firstOtherButton.titleLabel.shadowOffset = CGSizeMake(0, 1);

    [_alertView show];
}

- (IBAction)showAlertViewSingleButton:(id)sender
{
    _alertView = [[TJAlertView alloc] initWithTitle:@"Alert Label" message:@"Tap Continue and sign in to view account information" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    
    [_alertView show];
}


@end
