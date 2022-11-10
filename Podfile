source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '14.0'

use_frameworks!

def shared_pods
  pod 'ExpoFpCommon', '0.3.5'
  #pod 'ExpoFpCommon', :path => '/Users/vladimir/Xcode projects/expofp-common-ios'

  pod 'IndoorAtlas', '3.5.5'

end

target 'ExpoFpIndoorAtlas' do
  shared_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      config.build_settings['IPHONESIMULATOR_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
end

