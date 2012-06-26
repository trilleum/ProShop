//
//  MessageDialogViewController.m
//  Flash2Pay
//
//  Created by Tao Xie on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MessageDialogViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Recursion.h"
@interface MessageDialogViewController ()

@end

@implementation MessageDialogViewController
@synthesize titleLabel, contentLabel;
@synthesize title, content;
@synthesize okButton;

- (IBAction)okPressed:(id)sender {
    NSLog(@"okPressed");
    [self.view.window enableInteraction];
    for (UIView* view in self.view.window.subviews) {
        [view enableInteraction];
    }
    [self.view removeFromSuperview];
}

- (id)initWithTitle:(NSString*)_title content:(NSString*)_content {
    if ((self = [[MessageDialogViewController alloc] initWithNibName:@"MessageDialogViewController" bundle:nil])) {
        self.title = _title;
        self.content = _content;
        return self;
    }
    return nil;    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    titleLabel.text = self.title;
    contentLabel.text = self.content;
    
    self.view.layer.cornerRadius = 10;
    [self.view.layer setMasksToBounds:YES];
    [self.view setAlpha:0.90];
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - self.view.bounds.size.width)/2;
    CGFloat y = ([UIScreen mainScreen].bounds.size.height - self.view.bounds.size.height)/2; 
    [self.view setFrame:CGRectMake(x, y, self.view.bounds.size.width, self.view.bounds.size.height)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.okButton = nil;
    self.titleLabel = nil;
    self.contentLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
