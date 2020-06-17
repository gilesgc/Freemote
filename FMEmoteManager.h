#import "FMHTTPClient.h"
#import "BTTVEmote.h"

@interface FMEmoteManager : NSObject {
    NSMutableDictionary *_globalEmoteRegistry;
    NSMutableDictionary *_globalEmoteNameRegistry;
}
@property (nonatomic, retain) FMHTTPClient *httpClient;
@property (nonatomic, retain) NSMutableDictionary<NSString *, BTTVEmote *> *emoteRegistry;
@property (nonatomic, retain) NSMutableDictionary<NSString *, BTTVEmote *> *emoteNameRegistry;

- (void)updateEmoteRegistry:(NSNumber *)channelID;
- (NSURL *)imageURLForBTTVEmoteID:(NSString *)emoteID;

@end