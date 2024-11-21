#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint tap_apple_pay_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'tap_apple_pay_flutter'
  s.version          = '1.0.0'
  s.summary          = 'Accept apple pay payments in Flutter.'
  s.description      = <<-DESC
Accept apple pay payments in Flutter.
                       DESC
  s.homepage         = 'https://tap.company'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'a.maqbool@tap.company' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'TapApplePayKit-iOS', '1.0.26'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
