#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "DumpedHeaders.h"

/**
    Provides a way to show a notification banner
    from anywhere with a customizable message, title, bundleID,
    and icon (regardless of whether the bundle ID that you
    specify already exists.
*/
@interface EasyNotifier : NSObject
///-------------------------------------------------------------
///  @name Initialization
///-------------------------------------------------------------

/**
    Grabs a singleton, creating it if it does not already exist
 
    @result An EasyNotifier object
*/
+ (EasyNotifier *)sharedInstance;

///-------------------------------------------------------------
/// @name Setup
///-------------------------------------------------------------

/**
    Allows EasyNotifier to use the image at the given path with the given bundleID
 
    @param path The path to the image you wish to add
    @param bundleID The bundle identifier you wish to use to show the image
    @warning This method must be called prior to -showNotificationWithTitle:message:bundleID:
*/
- (void)addImagePath:(NSString *)path forBundleID:(NSString *)bundleID;

/**
    This could become an internal method in the future.
 
    @param bundleID The bundle identifier you wish to remove the image for
    @warning Should only be used to remove the bundle ID that your application/tweak added
*/
- (void)removeBundleID:(NSString *)bundleID;


- (void)showNotificationWithTitle:(NSString *)title message:(NSString *)message bundleID:(NSString *)bundleID;


///-------------------------------------------------------------
/// @name Internal
///-------------------------------------------------------------

/**
    Checks if the given bundle ID is registered
    @param bundleID The bundle identifier to query for
    @result YES if bundleID is registered, otherwise NO
*/
- (BOOL)hasImageForBundleID:(NSString *)bundleID;

/**
    Gets the image for the given bundle ID
    @param bundleID The bundle identifier for which to grab the image
    @result A UIImage object
*/
- (UIImage *)imageForBundleID:(NSString *)bundleID;

/**
    Grabs all registered bundle IDs
    @result A NSDictionary object containing all of the registered bundle IDs
*/
- (NSDictionary *)resources;
@end

/**
    @category EasyNotifier(UIImage)
*/
@interface UIImage (EasyNotifier)
/**
    Used to resize an actual UIImage
    
    @param image The image to resize
    @param size The desired end size
    @result UIImage
*/
+ (UIImage *)imageWithImage:(UIImage *)image scaleForSize:(CGSize)size;
@end
