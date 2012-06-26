//
//  GPSViewController.m
//  ShoppingPro
//
//  Created by Tao Xie on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GPSViewController.h"

@interface GPSViewController ()

@end

@implementation GPSViewController
@synthesize webView;
@synthesize closeButton;
@synthesize location;

- (IBAction)closeButtonTapped:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.location = @"http://apps.scout.me/v1/driveto?dt=950+De+Guigne+Drive&title=test&token=4RcsJR8kbHepSTTsLdkc6IVjcT_DemSTaO-n1P39Gk7zDZ6qeTy5JPqpYR6NxRb61Gg8-0apcud0vYAXDj7wh4I7vpGTjcyc-fI8jTpLwhF15q7dwkA28YYOtG0nnxZpCQwXQr2H9dybXz9_iFa91BJe50P6pNosSYYc3LYum3w";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *urlAddress = @"http://apps.scout.me/v1/driveto?dt=950+De+Guigne+Drive&title=test&token=4RcsJR8kbHepSTTsLdkc6IVjcT_DemSTaO-n1P39Gk7zDZ6qeTy5JPqpYR6NxRb61Gg8-0apcud0vYAXDj7wh4I7vpGTjcyc-fI8jTpLwhF15q7dwkA28YYOtG0nnxZpCQwXQr2H9dybXz9_iFa91BJe50P6pNosSYYc3LYum3w";
    
    NSURL *url = [NSURL URLWithString:urlAddress];    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    self.webView.scalesPageToFit = YES;
    //Load the request in the UIWebView.
    [self.webView loadRequest:requestObj];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
