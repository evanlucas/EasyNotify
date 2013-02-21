#import <UIKit/UIKit.h>
#import "libeasynotify.h"
#import <objc/runtime.h>
%hook BBBulletin
- (id)sectionIconImageWithFormat:(int)format {
	Class EasyNotifier = objc_getClass("EasyNotifier");
	if (!EasyNotifier) {
		NSLog(@"Unable to grab the EasyNotifier instance");
		return %orig;
	}
    
	EasyNotifier *notifier = [EasyNotifier sharedInstance];
    NSDictionary *resources = [notifier resources];
    if (![resources objectForKey:[self sectionID]]) {
        return %orig;
    } else {
        NSString *path = [resources objectForKey:[self sectionID]];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            NSLog(@"Trying to load image from invalid path.");
            return %orig;
        }
        return [notifier imageForBundleID:[self sectionID]];
    }
    
    return %orig;
}
%end

%ctor {
    if (![[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.bulletinboard"]) {
        return;
    }
}