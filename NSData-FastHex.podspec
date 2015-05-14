#
# Be sure to run `pod lib lint NSData-FastHex.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "NSData-FastHex"
  s.version          = "0.1.0"
  s.summary          = "Fast hexadecimal string encoding / decoding for NSData"
  s.description      = <<-DESC
    NSData-FastHex adds a category on `NSData` to convert to and from a
    hexadecimal string representation. As the name implies, it has a focus on
    performance, without sacrificing code clarity.
    DESC
  s.homepage         = "https://github.com/jmah/NSData-FastHex"
  s.license          = 'MIT'
  s.author           = { "Jonathon Mah" => "me@JonathonMah.com" }
  s.source           = { :git => "https://github.com/jmah/NSData-FastHex.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dev_etc'

  s.requires_arc = true

  s.source_files = '*.{h,m}'

  s.frameworks = 'Foundation'
end
