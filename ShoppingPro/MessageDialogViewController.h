//
//  MessageDialogViewController.h
//  Flash2Pay
//
//  Created by Tao Xie on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageDialogViewController : UIViewController
@property (nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic) IBOutlet UIButton *okButton;

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* content;

- (IBAction)okPressed:(id)sender;
- (id)initWithTitle:(NSString*)_title content:(NSString*)_content;
@end
