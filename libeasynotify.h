#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface EasyNotifier : NSObject
+ (EasyNotifier *)sharedInstance;
- (void)addImagePath:(NSString *)path forBundleID:(NSString *)bundleID;
- (void)showNotificationWithTitle:(NSString *)title message:(NSString *)message bundleID:(NSString *)bundleID;
- (BOOL)hasImageForBundleID:(NSString *)bundleID;
- (UIImage *)imageForBundleID:(NSString *)bundleID;
- (NSDictionary *)resources;
@end

@interface UIImage (EasyNotifier)
+ (UIImage *)imageWithImage:(UIImage *)image scaleForSize:(CGSize)size;
@end
