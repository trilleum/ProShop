//
//  Utils.h
//  Flash2Pay
//
//  Created by Tao Xie on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface Utils : NSObject

+ (NSString*)appVersion;
+ (NSString*)appBuildNumber;
+ (NSString*)cleanString:(NSString*)str;
+ (NSMutableArray*)loadRecentActivities;
+ (void)saveRecentActivities:(NSMutableArray*)recentActivities;
+ (void)saveRecentActivity:(NSMutableDictionary*)recentActivity;

+ (NSMutableDictionary*)loadSettings;
+ (void)saveSettings:(NSMutableDictionary *)settings;

@end
