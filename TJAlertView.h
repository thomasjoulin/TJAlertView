//
//  TJAlertView.h
//  TJAlertView
//
//  Created by Thomas Joulin on 2/13/13.
//  Copyright (c) 2013 Thomas Joulin. All rights reserved.
//

@interface TJAlertView : UIView

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
- (void)show;
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;
- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;

@property (nonatomic, assign) id<UIAlertViewDelegate> delegate;

@property (nonatomic, copy) NSString        *title;
@property (nonatomic, copy) NSString        *message;

@property (nonatomic, readonly) NSInteger   numberOfButtons;

@property (nonatomic, assign) UIEdgeInsets  contentEdgeInsets;

@property (nonatomic, strong) UIImage       *backgroundImage;

@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UILabel       *messageLabel;

@property (nonatomic, strong) UIButton      *cancelButton;
@property (nonatomic, strong) UIButton      *firstOtherButton;

@end
