#import <UIKit/UIKit.h>
#import <objc/runtime.h>

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
+ (id)sharedInstance;
@end

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
