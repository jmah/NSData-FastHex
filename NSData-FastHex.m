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

static char charFromNibble(uint8_t i) {
    if (i < 10) {
        return '0' + i;
    } else {
        return 'A' + (i - 10);
    }
}

- (NSString *)hexString
{
    const NSUInteger byteLength = self.length;
    const NSUInteger charLength = byteLength * 2;
    const uint8_t *bytes = self.bytes;

    char *const hexChars = malloc(charLength * sizeof(char));
    char *charPtr = hexChars;
    const uint8_t *bytePtr = bytes;
    while (bytePtr < bytes + byteLength) {
        const uint8_t byte = *bytePtr++;
        *charPtr++ = charFromNibble((byte >> 4) & 0xF);
        *charPtr++ = charFromNibble(byte & 0xF);
    }
    return [[NSString alloc] initWithBytesNoCopy:hexChars length:charLength encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

@end
