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
    return nil;
}

@end
