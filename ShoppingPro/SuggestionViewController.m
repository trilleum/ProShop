//
//  SuggestionViewController.m
//  ShoppingPro
//
//  Created by Tao Xie on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SuggestionViewController.h"

@interface SuggestionViewController ()

@end

@implementation SuggestionViewController
@synthesize subjectLabel, descriptionTextView, imageView, priceLabel;
@synthesize xButton;
@synthesize subject, description, price, imageName;

- (void) xButtonTapped:(id)sender {
    NSLog(@"closePressed");
    //    [self.view.window enableInteraction];
    //    for (UIView* view in self.view.window.subviews) {
    //        [view enableInteraction];
    //    }
    // [self.view removeFromSuperview];
    [self dismissModalViewControllerAnimated:YES];
}

- (id)initWithSubject:(NSString *)_subject description:(NSString *)_description price:(NSString *)_price image:(NSString *)_imageName {
    if ((self = [[SuggestionViewController alloc] initWithNibName:@"SuggestionViewController" bundle:nil])) {
        self.subject = _subject;
        self.description = _description;
        self.imageName = _imageName;
        self.price = _price;
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
    [self.subjectLabel setText:self.subject];
    [self.priceLabel setText:self.price];
    [self.descriptionTextView setText:self.description];
    [self.imageView setImage:[UIImage imageNamed:self.imageName]];
    NSLog(@"self.xButton: %@", self.xButton);
    [self.xButton addTarget:self action:@selector(xButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    /*
    self.view.layer.cornerRadius = 10;
    [self.view.layer setMasksToBounds:YES];
    [self.view setAlpha:0.90];
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - self.view.bounds.size.width)/2;
    CGFloat y = ([UIScreen mainScreen].bounds.size.height - self.view.bounds.size.height)/2; 
    [self.view setFrame:CGRectMake(x, y, self.view.bounds.size.width, self.view.bounds.size.height)];
     */
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.xButton = nil;
    self.subjectLabel = nil;
    self.priceLabel = nil;
    self.imageView = nil;
    self.descriptionTextView = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
