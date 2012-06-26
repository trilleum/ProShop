//
//  ScanViewController.h
//  ShoppingPro
//
//  Created by Tao Xie on 6/16/12.
//  Copyright (c) 2012 Trilleum Interactives. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedLaserSDK.h"

@interface ScanViewController : UIViewController {
    BarcodePickerController *pickerController;
}

- (IBAction)scanButtonPressed:(id)sender;
@end
