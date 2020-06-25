#import "BTTVEmote.h"

@implementation BTTVEmote

- (id)initWithDictData:(NSDictionary *)data emoteType:(EmoteType)type {
    self = [super init];

    if(self) {
        _emoteType = type;
        
        if(data[@"code"])
            _emoteText = data[@"code"];
        
        if(data[@"id"]) {
            if([data[@"id"] isKindOfClass:[NSNumber class]])
                _emoteID = [data[@"id"] stringValue];
            else
                _emoteID = data[@"id"];
        }
        
        if(data[@"imageType"] && [data[@"imageType"] isKindOfClass:[NSString class]])
            _isAnimated = [data[@"imageType"] isEqualToString:@"gif"];

        if(data[@"images"]) {
            //Emotes like this are ffz emotes, which have IDs that conflict with the default twitch emotes
            //To make them unique I add "ffz" to the end of the ID
            _emoteID = [_emoteID stringByAppendingString:@"ffz"];
            if(data[@"images"][@"1x"] && [data[@"images"][@"1x"] isKindOfClass:[NSString class]])
                _image1x = [NSURL URLWithString:data[@"images"][@"1x"]];
            if(data[@"images"][@"2x"] && [data[@"images"][@"2x"] isKindOfClass:[NSString class]])
                _image2x = [NSURL URLWithString:data[@"images"][@"2x"]];
        } else {
            _image1x = [NSURL URLWithString:[NSString stringWithFormat:@"https://cdn.betterttv.net/emote/%@/1x", _emoteID]];
            _image2x = [NSURL URLWithString:[NSString stringWithFormat:@"https://cdn.betterttv.net/emote/%@/2x", _emoteID]];
        }
    }

    return self;
}

@end