#
# Be sure to run `pod lib lint MKAppDelegateService.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKAppDelegateService'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MKAppDelegateService.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/KrisMarko/MKAppDelegateService'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kris.Marko---ZhangYu' => 'winzhyu@yeah.net' }
  s.source           = { :git => 'https://github.com/KrisMarko/MKAppDelegateService.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MKAppDelegateService/Classes/**/*'
  s.frameworks = 'UIKit', 'Foundation'

  # s.resource_bundles = {
  #   'MKAppDelegateService' => ['MKAppDelegateService/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'AFNetworking', '~> 2.3'
end
