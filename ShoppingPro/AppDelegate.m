//
//  AppDelegate.m
//  ShoppingPro
//
//  Created by Tao Xie on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "OrganizeViewController.h"
#import "ScanViewController.h"
#import "SetupViewController.h"
#import "RedLaserSDK.h"
#import "HomeViewController.h"
#import "InStoreLocationViewController.h"
#import "CatalogViewController.h"
#import <Parse/Parse.h>

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSLog(@"CFBundleVersion: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]);
    NSLog(@"CFBundleIdentifier: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"]);
    NSLog(@"CFBundleDisplayName: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]);
    // int error = rlcheckreadystatus();
    
    [Parse setApplicationId:@"YMUWGUBz4x5XlCwuCKT8URuAErhvW404rSoCGvQV" 
                  clientKey:@"HC7lVNeuRLcFoXzX6kpcypSyhFwqNYID56NEAsde"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIViewController *homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    UIViewController *organizeViewController = [[OrganizeViewController alloc] initWithNibName:@"OrganizeViewController" bundle:nil];
    
    UIViewController *inStoreViewController = [[InStoreLocationViewController alloc] initWithNibName:@"InStoreLocationViewController" bundle:nil];
    
    UIViewController *catalogViewController = [[CatalogViewController alloc] initWithNibName:@"CatalogViewController" bundle:nil];
    
    UIViewController *viewController3 = [[SetupViewController alloc] initWithNibName:@"SetupViewController" bundle:nil];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:homeViewController, organizeViewController, inStoreViewController, catalogViewController, viewController3, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
