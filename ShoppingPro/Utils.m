//
//  Utils.m
//  Flash2Pay
//
//  Created by Tao Xie on 4/23/12.
//  Copyright (c) 2012 Trilleum Interactives. All rights reserved.
//
#import "Constants.h"
#import "Utils.h"

#define DEBUG

@implementation Utils

+(NSString*)appVersion { 
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+(NSString*)appBuildNumber {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

+ (NSString*)cleanString:(NSString*)str {
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

+ (NSMutableArray*)load:(NSString*)fileName {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:fileName];
	
    NSLog(@"plist path:%@", plistPath);
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]){
		return [NSMutableArray arrayWithContentsOfFile: plistPath];
	} else {
		// return [[NSMutableArray alloc] init];
        return [[NSMutableArray alloc] init];
    }
}

+ (void)save:(NSMutableArray*)data toFile:(NSString*)fileName {
	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:fileName];
#ifdef DEBUG	
    NSLog(@"~~~~~~~ Utils.save: data:%@", data);
    NSLog(@"[INFO] PLIST: Document %@ was written to disk!", fileName);
#endif
	[data writeToFile:plistPath atomically:YES];
}

+ (NSMutableArray*)loadHistory {
    return [Utils load:historyFileName];
}
+ (void)saveHistory:(NSMutableArray *)history {
	[Utils save:history toFile:historyFileName];    
}

+ (void)saveRecentScan:(NSMutableDictionary *)recentScan {
    NSLog(@"ready to save recent activity:%@", recentScan);
    NSMutableArray* history = [Utils loadHistory];
    [history addObject:recentScan];
    [Utils saveHistory:history];
}

+ (NSMutableDictionary*)loadSettings {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:settingsFileName];
    NSLog(@"plistPath:%@", plistPath);
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]){
        // NSLog(@"settings plist exists");
        return [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    } else {
        // Default values for miscellenous settings
        NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         nil, kAccountId, nil];
        
        // [Utils saveSettings:settings];
        return settings;
    }
    
}

+ (void)saveSettings:(NSMutableDictionary*)settings {
    
    // [Utils save:settings toFile:settingsFileName];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:settingsFileName];
    NSLog(@"Utils.save: data:%@", settings);
	[settings writeToFile:plistPath atomically:YES];
	NSLog(@"[INFO] PLIST: Document %@ was written to disk!", settingsFileName); 
}

@end
