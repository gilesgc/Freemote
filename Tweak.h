@interface TWMessageEmoteToken : NSObject
@property (nonatomic, retain) NSString *emoteId;
@property (nonatomic, retain) NSString *emoteText;
- (id)initWithEmoteId:(NSString *)id emoteText:(NSString *)text;
@end

@interface TWMessageTextToken : NSObject
@property (nonatomic, retain) NSString *text;
- (id)initWithText:(NSString *)text autoModFlags:(id)autoModFlags;
@end

@interface TWMessageStringLayerCheermoteAnimatedImageLayer : CALayer
- (void)setCurrentFrameIndex:(unsigned long long)index;
- (unsigned long long)currentFrameIndex;
- (id)animatedImage;
@end