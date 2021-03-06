#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint isw_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'isw_flutter'
  s.version          = '0.0.1'
  s.summary          = 'A plugin for making payment with interswitch mobile payment sdk.'
  s.description      = <<-DESC
  A plugin for making payment with interswitch mobile payment sdk.
                       DESC
  s.homepage         = 'https://github.com/Mastersam07/isw_flutter'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  s.preserve_paths = 'IswMobileSdk.xcframework/**/*'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework IswMobileSdk' }
  s.vendored_frameworks = 'IswMobileSdk.xcframework'
end
