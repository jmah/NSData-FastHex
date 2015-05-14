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
{
    if (!hexString) // nonnull parameter for nonnull return
        return nil;

    NSMutableData *commandToSend= [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    for (int i = 0; i < ([hexString length] / 2); i++) {
        byte_chars[0] = [hexString characterAtIndex:i*2];
        byte_chars[1] = [hexString characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [commandToSend appendBytes:&whole_byte length:1];
    }

    return commandToSend;
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
