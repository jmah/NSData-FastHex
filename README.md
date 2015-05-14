# NSData+FastHex

[![CI Status](http://img.shields.io/travis/jmah/NSData-FastHex.svg?style=flat)](https://travis-ci.org/jmah/NSData-FastHex)
[![Version](https://img.shields.io/cocoapods/v/NSData-FastHex.svg?style=flat)](http://cocoapods.org/pods/NSData-FastHex)
[![License](https://img.shields.io/cocoapods/l/NSData-FastHex.svg?style=flat)](http://cocoapods.org/pods/NSData-FastHex)
[![Platform](https://img.shields.io/cocoapods/p/NSData-FastHex.svg?style=flat)](http://cocoapods.org/pods/NSData-FastHex)

## Description

NSData+FastHex adds a category on `NSData` to convert to and from a hexadecimal
string representation. As the name implies, it has a focus on performance,
without sacrificing code clarity.

Other implementations found online perform multiple message sends per byte and
make additional copies of data buffers, which is wasteful.

### Optimization techniques

* `CFStringInlineBuffer` for efficient character access (fast enumeration of
  string characters)
* `-[NSData enumerateByteRangesUsingBlock:]` to avoid an extra copy of the
  NSData buffer if the data isn't contiguous
* `-initWithBytesNoCopy:…` to avoid an extra copy of the encoded and decoded
  data and string buffers

## Usage

### Objective-C

```objective-c
#import "NSData+FastHex.h"
uint8_t bytes[] = {0xDE, 0xAD, 0xBE, 0xEF, 0x42};
NSData *data = [NSData dataWithBytes:bytes length:sizeof(bytes)];
NSString *hexString = [data hexStringRepresentation]; // => @"DEADBEEF42"
NSData *decoded = [NSData dataWithHexString:hexString];
```

### Swift

```swift
var bytes: [UInt8] = [0xDE, 0xAD, 0xBE, 0xEF, 0x42]
var data = NSData(bytes: bytes, length: bytes.count)
var hexString = data.hexStringRepresentation() // => "DEADBEEF42"
var decoded = NSData(hexString: hexString)
```

## Installation

NSData+FastHex is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "NSData+FastHex"
```

## Author

Jonathon Mah, me@JonathonMah.com

## License

NSData+FastHex is available under the MIT license. See the LICENSE file for more info.
