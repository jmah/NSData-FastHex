//
//  NSData-FastHex.m
//  Pods
//
//  Created by Jonathon Mah on 2015-05-13.
//
//

#import "NSData-FastHex.h"


@implementation NSData (FastHex)

+ (instancetype)dataWithHexString:(NSString *)hexString
{ return [self dataWithHexString:hexString ignoreOtherCharacters:YES]; }

+ (instancetype)dataWithHexString:(NSString *)hexString ignoreOtherCharacters:(BOOL)ignoreOtherCharacters
{
    return nil;
}

- (NSString *)hexString
{
    NSMutableString *hexString = [NSMutableString string];
    const uint8_t *bytes = self.bytes;
    for (NSInteger i = 0; i < self.length; ++i) {
        [hexString appendFormat:@"%02X", bytes[i]];
    }
    return hexString;
}

@end
