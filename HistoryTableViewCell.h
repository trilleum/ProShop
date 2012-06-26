//
//  HistoryTableViewCell.h
//  Flash2Pay
//
//  Created by Tao Xie on 5/13/12.
//  Copyright (c) 2012 Netspectrum Inc,. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *plusminusLabel;
@property (strong, nonatomic) IBOutlet UILabel *amountLabel;

@end
