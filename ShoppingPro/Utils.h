//
//  Utils.h
//  Flash2Pay
//
//  Created by Tao Xie on 4/23/12.
//  Copyright (c) 2012 Trilleum Interactives. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface Utils : NSObject

+ (NSString*)appVersion;
+ (NSString*)appBuildNumber;
+ (NSString*)cleanString:(NSString*)str;
+ (NSMutableArray*)loadHistory;
+ (void)saveHistory:(NSMutableArray*)history;
+ (void)saveRecentScan:(NSMutableDictionary*)recentScan;

+ (NSMutableDictionary*)loadSettings;
+ (void)saveSettings:(NSMutableDictionary *)settings;

@end
