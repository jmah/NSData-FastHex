//
//  NSData-FastHex.h
//  Pods
//
//  Created by Jonathon Mah on 2015-05-13.
//
//

#import <Foundation/Foundation.h>


@interface NSData (FastHex)

+ (instancetype)dataWithHexString:(NSString *)hexString;
+ (instancetype)dataWithHexString:(NSString *)hexString ignoreOtherCharacters:(BOOL)ignoreOtherCharacters;

- (NSString *)hexString;

@end
