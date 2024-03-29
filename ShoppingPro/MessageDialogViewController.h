//
//  MessageDialogViewController.h
//  Flash2Pay
//
//  Created by Tao Xie on 5/17/12.
//  Copyright (c) 2012 Trilleum Interactives. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageDialogViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subjectLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *xButton;

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* subject;
@property (strong, nonatomic) NSString* price;
@property (strong, nonatomic) NSString* description;
@property (strong, nonatomic) NSString* imageName;

- (IBAction)xButtonTapped:(id)sender;
- (id)initWithTitle:(NSString*) _title subject:(NSString*)_subject description:(NSString*)_description price:(NSString*)_price image:(NSString*)_imageName;
@end
