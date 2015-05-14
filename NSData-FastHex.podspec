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
  s.summary          = "A short description of NSData-FastHex."
  s.description      = <<-DESC
                       An optional longer description of NSData-FastHex

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/jmah/NSData-FastHex"
  s.license          = 'MIT'
  s.author           = { "Jonathon Mah" => "me@JonathonMah.com" }
  s.source           = { :git => "https://github.com/jmah/NSData-FastHex.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  # s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = '*.{h,m}'

  s.frameworks = 'Foundation'
end
