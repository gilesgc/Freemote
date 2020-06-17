#import "FMHTTPClient.h"

@implementation FMHTTPClient

- (NSDictionary *)bttvEmoteInformationForChannelID:(NSNumber *)channelID {
    return [self getJSON:[NSURL URLWithString:[@"https://api.betterttv.net/3/cached/users/twitch/" stringByAppendingString:[channelID stringValue]]]];  
}

- (NSDictionary *)ffzEmoteInformationForChannelID:(NSNumber *)channelID {
    return [self getJSON:[NSURL URLWithString:[@"https://api.betterttv.net/3/cached/frankerfacez/users/twitch/" stringByAppendingString:[channelID stringValue]]]];
}

- (NSDictionary *)bttvGlobalEmotes {
    return [self getJSON:[NSURL URLWithString:@"https://api.betterttv.net/3/cached/emotes/global"]];
}

- (NSDictionary *)ffzGlobalEmotes {
    return [self getJSON:[NSURL URLWithString:@"https://api.betterttv.net/3/cached/frankerfacez/emotes/global"]];
}

- (NSDictionary *)getJSON:(NSURL *)url {
    NSData *data = [NSData dataWithContentsOfURL:url];

    if(!data)
        return nil;

    NSError *error;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    return result;  
}

@end