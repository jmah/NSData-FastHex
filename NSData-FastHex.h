//
//  NSData-FastHex.h
//  Pods
//
//  Created by Jonathon Mah on 2015-05-13.
//
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSData (FastHex)

+ (instancetype)dataWithHexString:(NSString *)hexString;
+ (nullable instancetype)dataWithHexString:(NSString *)hexString ignoreOtherCharacters:(BOOL)ignoreOtherCharacters;

- (NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
