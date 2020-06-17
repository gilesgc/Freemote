@interface BTTVEmote : NSObject
@property (nonatomic, retain) NSString *emoteText;
@property (nonatomic, retain) NSString *emoteID;
@property (assign) BOOL isAnimated;
@property (nonatomic, retain) NSURL *image1x;
@property (nonatomic, retain) NSURL *image2x;

- (id)initWithDictData:(NSDictionary *)data;
@end