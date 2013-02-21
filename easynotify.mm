#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "libeasynotify.h"

#define PreferencesFilePath [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Preferences/com.curapps.easynotify.plist"]

@interface BBBulletin : NSObject
- (id)sectionIconImageWithFormat:(int)format;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *sectionID;
@end

@interface BBBulletinRequest : BBBulletin
@end

@interface SBBulletinBannerController : NSObject
- (void)observer:(id)observer addBulletin:(id)bulletin forFeed:(int)feed;
@end

@interface EasyNotifier ()
- (BOOL)prefsExist;
- (void)createEmptyPrefs;
@end

@implementation EasyNotifier
static EasyNotifier *controller = nil;
+ (EasyNotifier *)sharedInstance {
	@synchronized(self) {
		if (controller == nil) {
			controller = [[self alloc] init];
		}
	}
	return controller;
}
- (id)init {
    if (self = [super init]) {
        if (![self prefsExist]) {
            [self createEmptyPrefs];
        }
    }
    return self;
}
- (BOOL)prefsExist {
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:PreferencesFilePath]) {
        return NO;
    }
    return YES;
}

- (void)createEmptyPrefs {
    NSDictionary *d = [NSDictionary dictionary];
    [d writeToFile:PreferencesFilePath atomically:YES];
}
- (void)addImagePath:(NSString *)path forBundleID:(NSString *)bundleID {
    if ([path isEqualToString:@""]) {
        NSLog(@"Trying to add image with empty path.");
        return;
    }
    
    if ([bundleID isEqualToString:@""]) {
        NSLog(@"Trying to add image for empty bundle ID.");
        return;
    }
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithContentsOfFile:PreferencesFilePath];
    [d setObject:path forKey:bundleID];
    [d writeToFile:PreferencesFilePath atomically:YES];
    
    
}

- (void)showNotificationWithTitle:(NSString *)title message:(NSString *)message bundleID:(NSString *)bundleID {
	Class BBBulletinRequest = objc_getClass("BBBulletinRequest");
	Class SBBulletinBannerController = objc_getClass("SBBulletinBannerController");
	BBBulletinRequest *request = [[[BBBulletinRequest alloc] init] autorelease];
	[request setTitle:title];
	[request setMessage:message];
	[request setSectionID:bundleID];
	[[SBBulletinBannerController sharedInstance] observer:nil addBulletin:request forFeed:2];
}

- (BOOL)hasImageForBundleID:(NSString *)bundleID {
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:PreferencesFilePath];
	if (!dict) return NO;
    if ([dict objectForKey:bundleID]) {
        if (![[dict objectForKey:bundleID] isEqualToString:@""]) {
            return YES;
        }
    }
    return NO;
}

- (NSDictionary *)resources {
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:PreferencesFilePath];
    return dict;
}
- (UIImage *)imageForBundleID:(NSString *)bundleID {
	if (![self hasImageForBundleID:bundleID]) {
		NSLog(@"No image provided for bundle ID: %@", bundleID);
		return nil;
	}
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:PreferencesFilePath];
	
	if (!dict) {
		return nil;
	}
    NSString *path = [dict objectForKey:bundleID];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return nil;
    }
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
    UIImage *newimg = [UIImage imageWithImage:img scaleForSize:CGSizeMake(20,20)];
    [dict release];
    return newimg;    
}
@end

@implementation UIImage (EasyNotifier)
+ (UIImage *)imageWithImage:(UIImage *)image scaleForSize:(CGSize)size {
	UIGraphicsBeginImageContextWithOptions(size, NULL, 0.0);
	[image drawInRect:CGRectMake(0, 0, size.width, size.height)];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

@end
