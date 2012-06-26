//
//  HomeViewController.m
//  ShoppingPro
//
//  Created by Tao Xie on 6/16/12.
//  Copyright (c) 2012 Trilleum Interactives. All rights reserved.
//

#import "HomeViewController.h"
#import "MultiScanOverlayController.h"
#import "Utils.h"
#import <Parse/Parse.h>
#import "MessageDialogViewController.h"
#import "GPSViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize scanButton, storeButton;
@synthesize tableView;
@synthesize history;
@synthesize cellView;

- (IBAction)storeButtonTapped:(id)sender {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://apps.scout.me/v1/driveto?dt=950+De+Guigne+Drive&title=test&token=4RcsJR8kbHepSTTsLdkc6IVjcT_DemSTaO-n1P39Gk7zDZ6qeTy5JPqpYR6NxRb61Gg8-0apcud0vYAXDj7wh4I7vpGTjcyc-fI8jTpLwhF15q7dwkA28YYOtG0nnxZpCQwXQr2H9dybXz9_iFa91BJe50P6pNosSYYc3LYum3w"]];
    GPSViewController *gpsViewController = [[GPSViewController alloc] initWithNibName:@"GPSViewController" bundle:nil];
    [self presentModalViewController:gpsViewController animated:YES];
}

- (IBAction)scanButtonTapped:(id)sender {
    // Make ourselves an overlay controller and tell the SDK about it.
	// Why 2 different overlays? Only for demonstrating different things that can be done.
	MultiScanOverlayController *overlayController = [[MultiScanOverlayController alloc] init];
	[pickerController setOverlay:overlayController];
	
	// hide the status bar and show the scanner view
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	[self presentModalViewController:pickerController animated:TRUE];

}

- (void) barcodePickerController:(BarcodePickerController*)picker returnResults:(NSSet *)results
{	
	// [[UIApplication sharedApplication] setStatusBarHidden:NO];
	
	// Restore main screen (and restore title bar for 3.0)
	// [self dismissModalViewControllerAnimated:TRUE];
	
	// If there's any results, save them in our scan history
	if (results && [results count])
	{
		NSMutableDictionary *scanSession = [[NSMutableDictionary alloc] init];
		[scanSession setObject:[NSDate date] forKey:@"Session End Time"];
		[scanSession setObject:[results allObjects] forKey:@"Scanned Items"];
        NSLog(@"%@", [[results allObjects] objectAtIndex:0]);
        
        for (BarcodeResult *result in [results allObjects]) {
            NSLog(@"result:%@", result.barcodeString);
            PFQuery *query = [PFQuery queryWithClassName:@"Product"];
            [query whereKey:@"SKU" equalTo:result.barcodeString];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // The find succeeded.
                    NSLog(@"Successfully retrieved %d scores.", objects.count);
                    PFObject *p = [objects objectAtIndex:0];
                    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                 [p objectForKey:kName], kName,
                                                 [p objectForKey:kDescription], kDescription,
                                                 [p objectForKey:kImage], kImage,
                                                 [p objectForKey:kPrice], kPrice,
                                                 [p objectForKey:kSKU], kSKU,
                                                 nil];
                    [self.history addObject:dict];
                    NSLog(@"self.history: %@", self.history);
                    [Utils saveHistory:self.history];
                    [self.tableView reloadData];                  
                }
                else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];

        }
        // [Utils saveHistory:self.history];
        
		// [scanHistory insertObject:scanSession atIndex:0];
		
		// Save our new scans out to the archive file
        //		NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
        //                                                                      NSUserDomainMask, YES) objectAtIndex:0];
        //		NSString *archivePath = [documentsDir stringByAppendingPathComponent:@"ScanHistoryArchive"];
        //		[NSKeyedArchiver archiveRootObject:scanHistory toFile:archivePath];
        //		
        //		[scanHistoryTable reloadData];
        //		[firstTimeView setHidden:TRUE];
        [self dismissModalViewControllerAnimated:YES];
	}
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Home", @"Home");
        self.tabBarItem.image = [UIImage imageNamed:@"53-house"];
        pickerController = [[BarcodePickerController alloc] init];
		[pickerController setDelegate:self];
        // self.history = [[NSMutableArray alloc] init];
    }
    return self;
}
/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(displayPopup:)
                                   userInfo:nil
                                    repeats:NO];

}
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.history = [Utils loadHistory];
// TO PRELOAD IN HOME VIEW
/*
    PFQuery *query = [PFQuery queryWithClassName:@"Product"];
    [query whereKey:@"category" equalTo:@"paint"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d products.", objects.count);
            for (PFObject *p in objects) {
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         [p objectForKey:kName], kName,
                                         [p objectForKey:kDescription], kDescription,
                                         [p objectForKey:kImage], kImage,
                                         [p objectForKey:kPrice], kPrice,
                                         [p objectForKey:kSKU], kSKU,
                                         nil];
                NSLog(@"dict: %@", dict);
                [self.history addObject:dict];
                NSLog(@"self.history: %@", self.history);
                [self.tableView reloadData];                  
            }
        }
        else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
*/
    
    // Popoup Deal
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(displayPopup:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)displayPopup:(id)sender {
    MessageDialogViewController *messageDialogViewController = [[MessageDialogViewController alloc] 
                                                                initWithTitle:@"Don't Forget Dad on Father's Day" 
                                                                subject:@"Give Dad The Gift of Doing"  
                                                                description:@"All Ryobi power tools 10% off." 
                                                                price:@"Combo Kits start from $39.99"   
                                                                image:@"ryobi-ad.png"];
    [messageDialogViewController.view setBackgroundColor:[UIColor darkGrayColor]];
    messageDialogViewController.view.tag = 3001;    
    [self.view.window addSubview:messageDialogViewController.view];
    
    [NSTimer scheduledTimerWithTimeInterval:4.0
                                     target:self
                                   selector:@selector(hidePopup:)
                                   userInfo:nil
                                    repeats:NO];

    
//    sleep(4.0);
//    UIView *view = [self.view.window viewWithTag:3001];
//    [view removeFromSuperview];
}

- (void)hidePopup:(id)sender {
    UIView *view = [self.view.window viewWithTag:3001];
    [view removeFromSuperview];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.history = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [history count];
    // return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 74;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"history-Cell";
    HistoryTableViewCell *cell = (HistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:@"HistoryTableViewCell" owner:self options:nil];
        cell = [topObjects objectAtIndex:0];   
        
        NSMutableDictionary *dict = [self.history objectAtIndex:indexPath.row];
        cell.nameLabel.text = [dict objectForKey:kName];
        cell.descriptionTextView.text = [dict objectForKey:kDescription];
        cell.priceLabel.text = [NSString stringWithFormat:@"$%@", [dict objectForKey:kPrice]];
        UIImage *image = [UIImage imageNamed:[dict objectForKey:kImage]];
        [cell.imageView setImage:image];
        cell.contentView.backgroundColor = [UIColor colorWithRed:255/255.f green:255/255.f blue:240/255.f alpha:1];
        
        // NSMutableDictionary* settings = [Utils loadSettings];    
    }
    
    return cell;
}


@end
