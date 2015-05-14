//
//  NSData-FastHex.m
//  Pods
//
//  Created by Jonathon Mah on 2015-05-13.
//
//

#import "NSData-FastHex.h"


@implementation NSData (FastHex)

static uint8_t nibbleFromChar(unichar c) {
    if (c >= '0' && c <= '9') {
        return c - '0';
    } else if (c >= 'A' && c <= 'F') {
        return 10 + c - 'A';
    } else {
        return UINT8_MAX;
    }
}

+ (instancetype)dataWithHexString:(NSString *)hexString
{
    if (!hexString) // nonnull parameter for nonnull return
        return nil;

    NSParameterAssert(hexString.length % 2 == 0);
    const NSUInteger charLength = hexString.length;
    const NSUInteger byteLength = charLength / 2;
    uint8_t *const bytes = malloc(byteLength);
    uint8_t *bytePtr = bytes;

    CFStringInlineBuffer inlineBuffer;
    CFStringInitInlineBuffer((CFStringRef)hexString, &inlineBuffer, CFRangeMake(0, charLength));

    for (CFIndex i = 0; i < charLength; i += 2) {
        uint8_t hiNibble = nibbleFromChar(CFStringGetCharacterFromInlineBuffer(&inlineBuffer, i));
        uint8_t loNibble = nibbleFromChar(CFStringGetCharacterFromInlineBuffer(&inlineBuffer, i + 1));

        *bytePtr++ = (hiNibble << 4) + loNibble;
    }

    return [self dataWithBytesNoCopy:bytes length:(bytePtr - bytes) freeWhenDone:YES];
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
