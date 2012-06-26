//
//  OrganizeViewController.m
//  ShoppingPro
//
//  Created by Tao Xie on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrganizeViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import "Utils.h"
#import "UIGlossyButton.h"
#import "UIView+LayerEffects.h"
#import "MessageDialogViewController.h"
#import <Parse/Parse.h>
#import "SuggestionViewController.h"

// Draggable View
@interface DragView : UIImageView {
	CGPoint startLocation;
	NSString *whichFlower;
}
@property (strong, nonatomic) NSString *whichFlower;
@end

@implementation DragView
@synthesize whichFlower;
- (id) initWithFrame: (CGRect) aFrame
{
	self = [super initWithFrame: aFrame];
	if (!self) return NULL;
	self.userInteractionEnabled = YES;
	return self;
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	// Retrieve the touch point
	CGPoint pt = [[touches anyObject] locationInView:self];
	startLocation = pt;
	[[self superview] bringSubviewToFront:self];
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
	// Move relative to the original touch point
	CGPoint pt = [[touches anyObject] locationInView:self];
	CGRect frame = [self frame];
	frame.origin.x += pt.x - startLocation.x;
	frame.origin.y += pt.y - startLocation.y;
	[self setFrame:frame];
}
@end

@interface OrganizeViewController ()

@end

@implementation OrganizeViewController

#define MAXFLOWERS 9
CGPoint randomPoint() { return CGPointMake(random() % 256, random() % 396); }

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Organize", @"Organize");
        self.tabBarItem.image = [UIImage imageNamed:@"191-collection"];
    }
    return self;
}
		
- (void)loadView
{
	// Create the main view
	UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	contentView.backgroundColor = [UIColor colorWithRed:250/255.f green:250/255.f blue:210/255.f alpha:1];
	self.view = contentView;
	
	// Attempt to read in previous colors and locations
	NSMutableArray *colors, *locs;
	colors = [[NSUserDefaults standardUserDefaults] objectForKey:@"colors"];
	locs = [[NSUserDefaults standardUserDefaults] objectForKey:@"locs"];

    NSMutableArray* history = [Utils loadHistory];
    NSLog(@"-----> history:%@", history);
    
    int i = 0;
    for (NSMutableDictionary* pro in history) {
        NSString* imageName = [pro objectForKey:kImage];
        // Set the flower to a random point unless there's a previous location
		CGRect dragRect;
		if (locs && ([locs count] == MAXFLOWERS)) 
			dragRect = CGRectFromString([locs objectAtIndex:i]);
		else
		{
			dragRect = CGRectMake(0.0f, 0.0f, 64.0f, 64.0f);
			dragRect.origin = randomPoint();
            if (dragRect.origin.y > 350) {
                dragRect.origin.y = 200;
            }
            if (dragRect.origin.y < 15) {
                dragRect.origin.y = 26;
            }
		}
		
		// Create the view
		DragView *dragger = [[DragView alloc] initWithFrame:dragRect];
        
        
		// Use a random color unless there's a previous color
        NSString *whichFlower = [NSString stringWithFormat:@"%@.png", imageName];
		[dragger setWhichFlower:whichFlower];
		[dragger setImage:[UIImage imageNamed:whichFlower]];
		
		// Add the subview
		[self.view addSubview:dragger];
        i++;
    }
    // All non iPhone-like but nice buttons
    
    UIGlossyButton *gardenButton = (UIGlossyButton*) [UIGlossyButton buttonWithType:UIButtonTypeCustom];
    [gardenButton setTitle:@"garden" forState:UIControlStateNormal];
    gardenButton.titleLabel.font = [UIFont boldSystemFontOfSize:12]; 
	[gardenButton useWhiteLabel: YES]; 
    gardenButton.tintColor = [UIColor colorWithRed:84/255.f green:139/255.f blue:84/255.f alpha:1.0];
	[gardenButton setShadow:[UIColor colorWithRed:84/255.f green:139/255.f blue:84/255.f alpha:1.0] opacity:0.8 offset:CGSizeMake(0, 1) blurRadius: 4];
	[gardenButton setShadow:[UIColor blackColor] opacity:0.8 offset:CGSizeMake(0, 1) blurRadius: 4];
    gardenButton.frame = CGRectMake(16.0, 0.0, 60.0, 34.0);
    gardenButton.tag = 1000;
    [gardenButton addTarget:self action:@selector(pushRecoView:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:gardenButton];
    
	UIGlossyButton *plumbingButton = (UIGlossyButton*) [UIGlossyButton buttonWithType:UIButtonTypeCustom];
    [plumbingButton setTitle:@"plumbing" forState:UIControlStateNormal];
    plumbingButton.titleLabel.font = [UIFont boldSystemFontOfSize:12]; 
	[plumbingButton useWhiteLabel: YES]; 
    plumbingButton.tintColor = [UIColor darkGrayColor];
	[plumbingButton setShadow:[UIColor blackColor] opacity:0.8 offset:CGSizeMake(0, 1) blurRadius: 4];
    plumbingButton.frame = CGRectMake(90.0, 0.0, 64.0, 34.0);
    plumbingButton.tag = 1001;
    [plumbingButton addTarget:self action:@selector(pushRecoView:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:plumbingButton];
    
    UIGlossyButton *paintButton = (UIGlossyButton*) [UIGlossyButton buttonWithType:UIButtonTypeCustom];
    [paintButton setTitle:@"paint" forState:UIControlStateNormal];
    paintButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
	[paintButton useWhiteLabel: YES]; 
    paintButton.tintColor = [UIColor colorWithRed:58/255.f green:95/255.f blue:205/255.f alpha:1.0];
    [paintButton setShadow:[UIColor colorWithRed:58/255.f green:95/255.f blue:205/255.f alpha:1.0] opacity:0.8 offset:CGSizeMake(0, 1) blurRadius: 4];    
    paintButton.frame = CGRectMake(168.0, 0.0, 60.0, 34.0);
    paintButton.tag = 1002;
    [paintButton addTarget:self action:@selector(pushRecoView:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:paintButton];

    UIGlossyButton *housefixButton = (UIGlossyButton*) [UIGlossyButton buttonWithType:UIButtonTypeCustom];
    [housefixButton setTitle:@"fixing" forState:UIControlStateNormal];
    housefixButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
	[housefixButton useWhiteLabel: YES]; 
    housefixButton.tintColor = [UIColor colorWithRed:156/255.f green:102/255.f blue:31/255.f alpha:1.0];
	[housefixButton setShadow:[UIColor colorWithRed:156/255.f green:102/255.f blue:31/255.f alpha:1.0] opacity:0.8 offset:CGSizeMake(0, 1) blurRadius: 4];
    housefixButton.frame = CGRectMake(240.0, 0.0, 62.0, 34.0);
    housefixButton.tag = 1003;
    [housefixButton addTarget:self action:@selector(pushRecoView:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:housefixButton];
    
    UIView *sepeartor = [[UIView alloc] initWithFrame:CGRectMake(0.0, 334.0, 317.0, 3.0)];
    sepeartor.backgroundColor = [UIColor colorWithRed:205/255.f green:149/255.f blue:12/255.f alpha:1.0];
    [self.view addSubview:sepeartor];
    
    // scroll-view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 336.0, 320.0, 77.0)];
    [scrollView setBackgroundColor:[UIColor whiteColor]];
	[scrollView setCanCancelContentTouches:NO];
	scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
	scrollView.scrollEnabled = YES;
	scrollView.pagingEnabled = YES;
    scrollView.userInteractionEnabled = YES;
    
    // load all the images from our bundle and add them to the scroll view
//    NSArray* imageNames = [NSArray arrayWithObjects:@"paint.png", @"pvc.png", @"brush.png", @"roller2.png", @"faucet.png", @"valve.png", @"tool2.png", @"tool1.png", @"hinge2.png", @"knob3.png", @"tape.png", @"paint2.png", nil];
    NSArray* imageNames = [NSArray arrayWithObjects:@"scroll01.png", @"scroll02.png", @"scroll03.png", @"scroll04.png", nil];
             
    for (NSString* imageName in imageNames) {
		UIImage *image = [UIImage imageNamed:imageName];
		// UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 318.0, 75.0)];
        [imageView setImage:image];
		imageView.tag = i;	// tag our images for later use when we place them in serial fashion
		[scrollView addSubview:imageView];        
    }
    [self layoutScrollImages:scrollView];
    [self.view addSubview:scrollView];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 336.0, 320.0, 77.0)];
//    [imageView setImage:[UIImage imageNamed:@"scroll-view.png"]];
//    [self.view addSubview:imageView];
}

const CGFloat kScrollObjHeight	= 77.0;
const CGFloat kScrollObjWidth	= 318.0;
const NSUInteger kNumImages		= 4;


- (void)layoutScrollImages:(UIScrollView*)_scrollView
{
	UIImageView *view = nil;
	NSArray *subviews = [_scrollView subviews];
    
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
			
			curXLoc += (kScrollObjWidth);
		}
	}
	
	// set the content size so it can be scrollable
	[_scrollView setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), [_scrollView bounds].size.height)];
}


- (void)pushRecoView:(id)sender {
    UIButton* b = (UIButton*)sender;
    PFObject *obj = nil;
    switch (b.tag) {
        case 1001: {
            NSLog(@"Plumbing suggestion");
            PFQuery *query = [PFQuery queryWithClassName:@"Product"];
            [query whereKey:@"SKU" equalTo:@"0021130584420"];
            NSArray* objs = [query findObjects];
            obj = [objs objectAtIndex:0];            
            break;
        }
        case 1002: {
            NSLog(@"Paint suggestion");
            PFQuery *query = [PFQuery queryWithClassName:@"Product"];
            [query whereKey:@"SKU" equalTo:@"0305747090124"];
            NSArray* objs = [query findObjects];
            obj = [objs objectAtIndex:0];            
            break;
        }
        case 1003: {
            NSLog(@"House fix suggestion");
            PFQuery *query = [PFQuery queryWithClassName:@"Product"];
            [query whereKey:@"SKU" equalTo:@"0041333002477"];
            NSArray* objs = [query findObjects];
            obj = [objs objectAtIndex:0];      
            break;
        }
        default:
            break;
    }
    MessageDialogViewController *messageDialogViewController = [[MessageDialogViewController alloc] 
                                                                initWithTitle:@"You may need" 
                                                                subject:[obj objectForKey:kName] 
                                                                description:[obj objectForKey:kDescription] 
                                                                price:[NSString stringWithFormat:@"$%@", [obj objectForKey:kPrice]]  
                                                                image:[obj objectForKey:kImage]];
    messageDialogViewController.view.tag = 3000;
    [self.view.window addSubview:messageDialogViewController.view];
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(closeView:)
                                   userInfo:nil
                                    repeats:NO];
    
//    [messageDialogViewController.xButton addTarget:self action:@selector(xButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//
//    [messageDialogViewController.xButton becomeFirstResponder];
    // [messageDialogViewController becomeFirstResponder];
    // [self presentModalViewController:messageDialogViewController animated:YES];
    /*
    SuggestionViewController *suggestionViewController = [[SuggestionViewController alloc] 
                                                                initWithSubject:[obj objectForKey:kName] 
                                                                description:[obj objectForKey:kDescription] 
                                                                price:[NSString stringWithFormat:@"$%@", [obj objectForKey:kPrice]]  
                                                                image:[obj objectForKey:kImage]];
    
    [self presentModalViewController:suggestionViewController animated:YES];
     */
}

- (void) closeView:(id)sender {
    UIView *view = [self.view.window viewWithTag:3000];
    [view removeFromSuperview];
}

- (void) xButtonTapped:(id)sender {
    NSLog(@"xPressed");
    //    [self.view.window enableInteraction];
    //    for (UIView* view in self.view.window.subviews) {
    //        [view enableInteraction];
    //    }
    [self.view removeFromSuperview];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
