typedef enum {
    BTTV, FFZ, BTTVGlobal, FFZGlobal
} EmoteType;

@interface BTTVEmote : NSObject
@property (nonatomic, retain) NSString *emoteText;
@property (nonatomic, retain) NSString *emoteID;
@property (nonatomic, retain) NSURL *image1x;
@property (nonatomic, retain) NSURL *image2x;
@property (assign) BOOL isAnimated;
@property (assign) EmoteType emoteType;

- (id)initWithDictData:(NSDictionary *)data emoteType:(EmoteType)type;
@end