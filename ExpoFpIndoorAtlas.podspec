Pod::Spec.new do |spec|
  spec.name               = "ExpoFpIndoorAtlas"
  spec.version            = "5.0.0"
  spec.platform           = :ios, '14.0'
  spec.summary            = "ExpoFP-IndoorAtlas location provider"
  spec.description        = "IndoorAtlas location provider for ExpoFP SDK"
  spec.homepage           = "https://www.expofp.com"
  spec.documentation_url  = "https://github.com/expofp/expofp-indooratlas-ios"
  spec.license            = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { 'ExpoFP' => 'support@expofp.com' }
  spec.source             = { :git => 'https://github.com/expofp/expofp-indooratlas-ios.git', :tag => "v#{spec.version}" }
  spec.swift_version      = "5"

  # Supported deployment targets
  spec.ios.deployment_target  = "14.0"

  # Add here any resources to be exported.
  spec.dependency 'ExpoFP', '~> 5.1.0'
  spec.dependency 'IndoorAtlas', '3.6.9'

end
