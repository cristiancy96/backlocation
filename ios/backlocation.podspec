#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint backlocation.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'backlocation'
  s.version          = '0.0.1'
  s.summary          = 'Flutter background location plugin for Android and iOS.'
  s.description      = <<-DESC
  Flutter background location plugin for Android and iOS
                       DESC
  s.homepage         = 'http://quick.com.co'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Project origin - Flutter background location plugin for Android and iOS' => 'ali.almoullim@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '10.0'
  s.ios.deployment_target = '10.0'
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
