#
# Be sure to run `pod lib lint PSDatePicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PSDatePicker'
  s.version          = '0.1.0'
  s.summary          = 'This cocoapods is for date picking.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'this pods can date pick and time pick. it has many options for datepicking.'

  s.homepage         = 'https://github.com/nanuare/psdatepicker'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MPL-2.0', :file => 'LICENSE' }
  s.author           = { 'PeaceKim' => 'me@peacekim.com' }
  s.source           = { :git => 'https://github.com/nanuare/psdatepicker.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.source_files = 'PSDatePicker/Classes/**/*'
  s.requires_arc = true
  
  # s.resource_bundles = {
  #   'PSDatePicker' => ['PSDatePicker/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
