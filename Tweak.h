@interface TWMessageEmoteToken : NSObject
@property (nonatomic, retain) NSString *emoteId;
@property (nonatomic, retain) NSString *emoteText;
- (id)initWithEmoteId:(NSString *)id emoteText:(NSString *)text;
@end

@interface TWMessageTextToken : NSObject
@property (nonatomic, retain) NSString *text;
- (id)initWithText:(NSString *)text autoModFlags:(id)autoModFlags;
@end

@interface TWMessageStringLayer : CALayer
- (void)configureAnimatedImageLayer:(id)arg1 withImageLayerData:(id)arg2 fadeInIfDownloaded:(BOOL)arg3 animatedImageAvailableBlock:(void(^)(void))arg4;
- (NSArray *)emoteImageLayers;
@end

@interface TWMessageStringImageData : NSObject
@property (nonatomic, retain) NSURL *staticURL;
@end

@interface TWMessageStringImageLayerData : NSObject
- (CGRect)frame;
- (void)setFrame:(CGRect)frame;
@end