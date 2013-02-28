## EasyNotify

### Goal: To provide a dead simple way to show a notification banner from anywhere with a customizable message, title, bundle, and icon (regardless of whether there is a application bundle ID which you specify.

### How to use
- Get theos

		git clone https://github.com/DHowett/theos

- Clone the repo

		git clone https://github.com/evanlucas/easynotify
		cd easynotify
		ln -s $THEOS theos			# Done so we can get a reference to theos
		make package install		# To get it on your device 
		cp obj/libeasynotify.dylib $THEOS/lib

- Create a new tweak 

		$THEOS/bin/nic.pl		#Follow prompts
		cd <tweak_name>
		cp ../easynotify/libeasynotify.h .
	
- Modify Makefile

Directly after `<tweak_name>_FILES`, add

		<tweak_name>_LDFLAGS = -L$(THEOS_OBJ_DIR)
		<tweak_name>_CFLAGS = -I.
		<tweak_name>_LIBRARIES = easynotify

- Open Tweak.xm

		#import "libeasynotify.h"
		%hook SBUIController
		- (void)finishedUnscattering {
			%orig;
			EasyNotifier *note = [EasyNotifier sharedInstance];
			NSString *icon = @"path to the icon";
			[note addImagePath:icon forBundleID:@"<whatever bundleID you want>"];
			[note showNotificationWithTitle:@"Notification Title" message:@"Notification Message" bundleID:@"<same bundle ID as above>"];
			
		}
		%end

- If EasyNotify cannot find the image, the notification will still be shown, but with no image...

### Documentation

- Generating the documentation requires that [appledoc](https://github.com/tomaz/appledoc) be installed

		./docs.sh


### Feel free to use it in projects or whatever

### Thanks:

- DHowett (for theos)
- saurik (for, well, a lot like Cydia, substrate, veency, cycript, and all of his others)
- All other iOS developers
