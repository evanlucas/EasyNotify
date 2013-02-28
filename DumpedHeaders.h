@interface BBBulletin : NSObject
- (id)sectionIconImageWithFormat:(int)format;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *sectionID;
@end

@interface SBBulletinBannerController : NSObject
- (void)observer:(id)observer addBulletin:(id)bulletin forFeed:(int)feed;
+ (id)sharedInstance;
@end

@interface BBBulletinRequest : BBBulletin
@end
