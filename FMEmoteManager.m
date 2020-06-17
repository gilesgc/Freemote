#import "FMEmoteManager.h"

@implementation FMEmoteManager

- (id)init {
    self = [super init];

    if(self) {
        _httpClient = [[FMHTTPClient alloc] init];
        _emoteRegistry = [[NSMutableDictionary alloc] init];
        _emoteNameRegistry = [[NSMutableDictionary alloc] init];
        _globalEmoteRegistry = [[NSMutableDictionary alloc] init];
        _globalEmoteNameRegistry = [[NSMutableDictionary alloc] init];
    }

    NSDictionary *bttvGlobalEmoteInfo = [_httpClient bttvGlobalEmotes];
    NSDictionary *ffzGlobalEmoteInfo = [_httpClient ffzGlobalEmotes];

    [self addEmoteInfo:bttvGlobalEmoteInfo toRegistry:_globalEmoteRegistry nameRegistry:_globalEmoteNameRegistry];
    [self addEmoteInfo:ffzGlobalEmoteInfo toRegistry:_globalEmoteRegistry nameRegistry:_globalEmoteNameRegistry];

    return self;
}

- (void)updateEmoteRegistry:(NSNumber *)channelID {
    [_emoteRegistry removeAllObjects];
    [_emoteNameRegistry removeAllObjects];

    NSDictionary *bttvEmoteInfo = [_httpClient bttvEmoteInformationForChannelID:channelID];
    NSDictionary *ffzEmoteInfo = [_httpClient ffzEmoteInformationForChannelID:channelID];

    if(bttvEmoteInfo && bttvEmoteInfo[@"channelEmotes"]) {
        [self addEmoteInfo:bttvEmoteInfo[@"channelEmotes"] toRegistry:_emoteRegistry nameRegistry:_emoteNameRegistry];
        [self addEmoteInfo:bttvEmoteInfo[@"sharedEmotes"] toRegistry:_emoteRegistry nameRegistry:_emoteNameRegistry];
    }

    if(ffzEmoteInfo) {
        [self addEmoteInfo:ffzEmoteInfo toRegistry:_emoteRegistry nameRegistry:_emoteNameRegistry];
    }

    [_emoteRegistry addEntriesFromDictionary:_globalEmoteRegistry];
    [_emoteNameRegistry addEntriesFromDictionary:_globalEmoteNameRegistry];
}

- (void)addEmoteInfo:(NSDictionary *)emoteInfo toRegistry:(NSMutableDictionary *)registry nameRegistry:(NSMutableDictionary *)nameRegistry {
    for(NSDictionary *emoteDict in emoteInfo) {
        BTTVEmote *emote = [[BTTVEmote alloc] initWithDictData:emoteDict];
        [registry setObject:emote forKey:emote.emoteID];
        [nameRegistry setObject:emote forKey:emote.emoteText];
    }
}

- (NSURL *)imageURLForBTTVEmoteID:(NSString *)emoteID {
    BTTVEmote *emote = _emoteRegistry[emoteID];
    if(emote) {
        if(emote.image2x)
            return emote.image2x;
        else if(emote.image1x)
            return emote.image1x;
    }
    return nil;
}

@end