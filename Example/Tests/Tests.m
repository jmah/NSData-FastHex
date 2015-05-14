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

- (void)testHexPrepresentation
{
    const uint8_t bytes[] = {0x00, 0x1F, 0x3B, 0x42, 0xF0, 0xFF};
    NSData *data = [NSData dataWithBytes:bytes length:sizeof(bytes)];
    XCTAssertNotNil(data);

    NSString *hexString = [data hexString];
    XCTAssertEqualObjects(hexString, @"001F3B42F0FF");
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
    NSString *hexString = [data hexString];
    NSData *decodedData = [NSData dataWithHexString:hexString];
    XCTAssertEqualObjects(data, decodedData);
}

- (void)testInstanceType
{
    NSData *data = [self randomDataWithLength:16];
    NSString *hexString = [data hexString];
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
        for (NSInteger i = 0; i < 1000; i++) @autoreleasepool {
            [data hexString];
        }
    }];
}

- (void)testDecodePerformance
{
    NSData *data = [self randomDataWithLength:4096];
    NSString *hexString = [data hexString];
    XCTAssertNotNil(data);

    [self measureBlock:^{
        for (NSInteger i = 0; i < 1000; i++) @autoreleasepool {
            [NSData dataWithHexString:hexString];
        }
    }];
}

@end
