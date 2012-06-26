//
//  HomeViewController.h
//  ShoppingPro
//
//  Created by Tao Xie on 6/16/12.
//  Copyright (c) 2012 Trilleum Interactives. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedLaserSDK.h"
#import "OverlayController.h"
#import "HistoryTableViewCell.h"

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, BarcodePickerControllerDelegate> {
    BarcodePickerController		*pickerController;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *scanButton;
@property (strong, nonatomic) IBOutlet UIButton *storeButton;
@property (strong, nonatomic) NSMutableArray *history;
@property (nonatomic) HistoryTableViewCell *cellView;

- (IBAction)storeButtonTapped:(id)sender;
- (IBAction)scanButtonTapped:(id)sender;
@end
