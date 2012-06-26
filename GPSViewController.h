//
//  GPSViewController.h
//  ShoppingPro
//
//  Created by Tao Xie on 6/17/12.
//  Copyright (c) 2012 Trilleum Interactives. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPSViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;

@property (strong, nonatomic) NSString* location;

- (IBAction)closeButtonTapped:(id)sender;

@end
