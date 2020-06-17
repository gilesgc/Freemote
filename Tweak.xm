#import "Tweak.h"
#import "FMEmoteManager.h"

static Class EmoteToken, TextToken;
static FMEmoteManager *emoteManager;

NSMutableArray* stringToBTTVTokenizedArray(NSString *string) {
    NSMutableArray *tokens = [[NSMutableArray alloc] init];
    BOOL emotesFound = NO;
    for(NSString *component in [string componentsSeparatedByString:@" "]) {
        if(emoteManager.emoteNameRegistry[component]) {
            emotesFound = YES;
            NSArray<NSString *> *stringSeparatedByEmoteText = [string componentsSeparatedByString:component];
            NSObject *leftText = [[TextToken alloc] initWithText:stringSeparatedByEmoteText[0] autoModFlags:nil];
            NSObject *emote = [[EmoteToken alloc] initWithEmoteId:emoteManager.emoteNameRegistry[component].emoteID emoteText:component];
            [tokens addObject:leftText];
            [tokens addObject:emote];

            if(stringSeparatedByEmoteText[1]) {
                [tokens addObjectsFromArray:stringToBTTVTokenizedArray(stringSeparatedByEmoteText[1])];
                return tokens;
            }
            else {
                return tokens;
            }
        }
    }

    if(!emotesFound) {
        [tokens addObject:[[TextToken alloc] initWithText:string autoModFlags:nil]];
    }

    return tokens;
}

NSMutableArray* substituteBTTVStringsWithEmoteTokens(NSMutableArray *tokens) {
    NSMutableArray *newTokens = [[NSMutableArray alloc] init];
    for(NSObject *token in tokens) {
        if([token isKindOfClass:TextToken]) {
            [newTokens addObjectsFromArray:stringToBTTVTokenizedArray([token performSelector:@selector(text)])];
        } else {
            [newTokens addObject:token];
        }
    }

    return newTokens;
}

%hook TWChatMessage

- (id)initWithTokens:(NSMutableArray *)tokens senderIdentity:(id)arg2 badges:(id)arg3 date:(id)arg4 messageID:(id)arg5 liveMessageID:(id)arg6 color:(id)arg7 flags:(unsigned long long)arg8 kind:(long long)arg9 userModes:(unsigned long long)arg10 messageType:(id)arg11 messageTags:(id)arg12 {
    tokens = substituteBTTVStringsWithEmoteTokens(tokens);
    return %orig(tokens, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
}

%end

%hook TWTwitchChatAdapter

- (NSURL *)emoteImageURLForId:(NSString *)emoteID scale:(double)arg2 {
    NSURL *imageURL = [emoteManager imageURLForBTTVEmoteID:emoteID];
    if(imageURL) {
        return imageURL;
    }
    return %orig;
}

- (void)joinChannel:(NSNumber *)channelID withMaybeUser:(id)arg2 {
    [emoteManager updateEmoteRegistry:channelID];
    %orig;
}

%end

%hook TWMessageStringImageData

- (id)initWithStaticURL:(NSURL *)arg1 animatedURL:(NSURL *)arg2 isAnimated:(BOOL)arg3 isAvatar:(BOOL)arg4 {
    if([[arg1 absoluteString] containsString:@"betterttv"]) {
        NSString *emoteUrl = arg1.absoluteString;
        for(BTTVEmote *emote in emoteManager.emoteRegistry.allValues) {
            if([emote.image1x.absoluteString isEqualToString:emoteUrl] || [emote.image2x.absoluteString isEqualToString:emoteUrl]) {
               if(emote.isAnimated)
                    return %orig(arg1, arg1, YES, arg4);
                else
                    break;
            }
        }
    }
    
    return %orig;
}

%end

%hook TWMessageStringLayer

- (BOOL)shouldAnimateCheermotes {
    return YES;
}

- (void)setShouldAnimateCheermotes:(BOOL)animateCheermotes {
    %orig(YES);
}

%end

%ctor {
    %init(TWChatMessage = objc_getClass("TwitchKit.TWChatMessage"));
    EmoteToken = objc_getClass("TwitchKit.TWMessageEmoteToken");
    TextToken = objc_getClass("TwitchKit.TWMessageTextToken");
    emoteManager = [[FMEmoteManager alloc] init];
}
