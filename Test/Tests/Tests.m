//
//  NSData-FastHexTests.m
//  NSData-FastHexTests
//
//  Created by Jonathon Mah on 05/13/2015.
//  Copyright (c) 2014 Jonathon Mah. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSData-FastHex.h"


@interface Tests : XCTestCase
@end

@implementation Tests

- (void)testHexStringRepresentation
{
    const uint8_t bytes[] = {0x00, 0x1F, 0x3B, 0x42, 0xF0, 0xFF};
    NSData *data = [NSData dataWithBytes:bytes length:sizeof(bytes)];
    XCTAssertNotNil(data);

    NSString *hexString = [data hexStringRepresentation];
    XCTAssertEqualObjects(hexString, @"001F3B42F0FF");

    NSString *lowercaseHexString = [data hexStringRepresentationUppercase:NO];
    XCTAssertEqualObjects(lowercaseHexString, @"001f3b42f0ff");
    XCTAssertEqualObjects(lowercaseHexString, [hexString lowercaseString]);
}

- (void)testDecodeOptions
{
    const uint8_t bytes[] = {0x00, 0x1F, 0x3B, 0x42, 0xF0, 0xFF};
    NSData *data = [NSData dataWithBytes:bytes length:sizeof(bytes)];

    XCTAssertEqualObjects([NSData dataWithHexString:@""], [NSData data]);

    XCTAssertEqualObjects([[NSData alloc] initWithHexString:@"001F3B42F0FF" ignoreOtherCharacters:NO], data, @"Uppercase letters");
    XCTAssertEqualObjects([[NSData alloc] initWithHexString:@"001f3b42f0ff" ignoreOtherCharacters:NO], data, @"Lowercase letters");
    XCTAssertNil([[NSData alloc] initWithHexString:@"00 1F 3B 42 F0 FF" ignoreOtherCharacters:NO], @"nil when not ignoring non-hex characters");
    XCTAssertEqualObjects([[NSData alloc] initWithHexString:@"00 1F 3B 42 F0 FF" ignoreOtherCharacters:YES], data, @"Ignore spaces");
}

- (void)testTrailingCharacters
{
    XCTAssertNil([[NSData alloc] initWithHexString:@"x" ignoreOtherCharacters:NO], @"Trailing non-hex character");
    XCTAssertEqualObjects([[NSData alloc] initWithHexString:@"x" ignoreOtherCharacters:YES], [NSData data], @"Ignore trailing non-hex character");
    XCTAssertNil([[NSData alloc] initWithHexString:@"1" ignoreOtherCharacters:NO], @"Ignore trailing hex character");
    XCTAssertEqualObjects([[NSData alloc] initWithHexString:@"1" ignoreOtherCharacters:YES], [NSData data], @"Ignore trailing hex character");

    NSData *c3 = [NSData dataWithBytes:(uint8_t[]){0xc3} length:1];
    XCTAssertNil([[NSData alloc] initWithHexString:@"c3x" ignoreOtherCharacters:NO], @"Trailing non-hex character");
    XCTAssertEqualObjects([[NSData alloc] initWithHexString:@"c3x" ignoreOtherCharacters:YES], c3, @"Ignore trailing non-hex character");
    XCTAssertNil([[NSData alloc] initWithHexString:@"c31" ignoreOtherCharacters:NO], @"Ignore trailing hex character");
    XCTAssertEqualObjects([[NSData alloc] initWithHexString:@"c31" ignoreOtherCharacters:YES], c3, @"Ignore trailing hex character");
}

- (NSData *)randomDataWithLength:(NSUInteger)length
{
    uint8_t *bytes = malloc(length);
    int result = SecRandomCopyBytes(kSecRandomDefault, length, bytes);
    XCTAssert(result == 0);

    return [NSData dataWithBytesNoCopy:bytes length:length freeWhenDone:YES];
}

- (void)testRandomBytes
{
    NSData *data = [self randomDataWithLength:4096];
    XCTAssertNotNil(data);
    NSString *hexString = [data hexStringRepresentation];
    NSData *decodedData = [NSData dataWithHexString:hexString];
    XCTAssertEqualObjects(data, decodedData);

    NSString *lowercaseHexString = [data hexStringRepresentationUppercase:NO];
    NSData *decodedLowercaseData = [NSData dataWithHexString:lowercaseHexString];
    XCTAssertEqualObjects(data, decodedLowercaseData);
}

- (void)testInstanceType
{
    NSData *data = [self randomDataWithLength:16];
    NSString *hexString = [data hexStringRepresentation];
    XCTAssertNotNil(hexString);

    NSData *decodedData = [NSData dataWithHexString:hexString];
    XCTAssertFalse([decodedData respondsToSelector:@selector(mutableBytes)]);
    NSMutableData *mutableData = [NSMutableData dataWithHexString:hexString];
    XCTAssertTrue([mutableData respondsToSelector:@selector(mutableBytes)]);
    // -isKindOfClass:[NSMutableData class] returns true for both as a side-effect of its class cluster nature
}

- (void)testEncodePerformance
{
    NSData *data = [self randomDataWithLength:4096];
    XCTAssertNotNil(data);

    [self measureBlock:^{
        for (NSInteger i = 0; i < 10000; i++) @autoreleasepool {
            [data hexStringRepresentation];
        }
    }];
}

- (void)testDecodePerformance
{
    NSData *data = [self randomDataWithLength:4096];
    NSString *hexString = [data hexStringRepresentation];
    XCTAssertNotNil(data);

    [self measureBlock:^{
        for (NSInteger i = 0; i < 1000; i++) @autoreleasepool {
            [NSData dataWithHexString:hexString];
        }
    }];
}

@end
