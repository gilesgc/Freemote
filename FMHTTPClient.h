@interface FMHTTPClient : NSObject
- (NSDictionary *)bttvEmoteInformationForChannelID:(NSNumber *)channelID;
- (NSDictionary *)ffzEmoteInformationForChannelID:(NSNumber *)channelID;
- (NSDictionary *)bttvGlobalEmotes;
- (NSDictionary *)ffzGlobalEmotes;
@end