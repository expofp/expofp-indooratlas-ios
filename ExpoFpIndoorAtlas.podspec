Pod::Spec.new do |spec|
  spec.name               = "ExpoFpIndoorAtlas"
  spec.version            = "3.0.10"
  spec.platform           = :ios, '14.0'
  spec.summary            = "Fplan Library for iOS apps"
  spec.description        = "Library for displaying expo plans"
  spec.homepage           = "https://www.expofp.com"
  spec.documentation_url  = "https://github.com/expofp/expofp-sdk-ios"
  spec.license            = { :type => "MIT" }
  spec.author                = { 'ExpoFP' => 'support@expofp.com' }
  spec.source             = { :git => 'https://github.com/expofp/expofp-indooratlas-ios.git', :tag => "#{spec.version}" }
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.swift_version      = "5"

  # Supported deployment targets
  spec.ios.deployment_target  = "14.0"

  # Published binaries
  spec.ios.vendored_frameworks = "xcframework/ExpoFpIndoorAtlas.xcframework"

  # Add here any resources to be exported.
  spec.dependency 'ExpoFpCommon', '3.0.10'
  spec.dependency 'IndoorAtlas', '3.5.5'

end
