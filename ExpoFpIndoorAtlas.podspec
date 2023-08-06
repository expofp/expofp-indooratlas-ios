Pod::Spec.new do |spec|
  spec.name               = "ExpoFpIndoorAtlas"
  spec.version            = "4.2.3"
  spec.platform           = :ios, '14.0'
  spec.summary            = "ExpoFP-IndoorAtlas location provider"
  spec.description        = "IndoorAtlas location provider for ExpoFP SDK"
  spec.homepage           = "https://www.expofp.com"
  spec.documentation_url  = "https://expofp.github.io/expofp-mobile-sdk/ios-sdk"
  spec.license            = { :type => "MIT" }
  spec.author                = { 'ExpoFP' => 'support@expofp.com' }
  spec.source             = { :git => 'https://github.com/expofp/expofp-indooratlas-ios.git', :tag => "#{spec.version}" }
  #spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  #spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.swift_version      = "5"

  # Supported deployment targets
  spec.ios.deployment_target  = "14.0"

  # Published binaries
  spec.ios.vendored_frameworks = "xcframework/ExpoFpIndoorAtlas.xcframework"

  # Add here any resources to be exported.
  spec.dependency 'ExpoFpCommon', '4.2.3'
  spec.dependency 'IndoorAtlas', '~> 3.6'

end
