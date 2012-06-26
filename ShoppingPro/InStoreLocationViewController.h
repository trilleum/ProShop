//
//  InStoreLocationViewController.h
//  ShoppingPro
//
//  Created by Tao Xie on 6/17/12.
//  Copyright (c) 2012 Trilleum Interactives. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InStoreLocationViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView *imageScrollView;
	UIImageView *imageView;
}

@property (nonatomic, retain) IBOutlet UIScrollView *imageScrollView;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@end
