<img src="https://expofp.com/template/img/site-header-logo-inverse.png" width="350"/>

[![Swift Package Manager compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/ExpoFpIndoorAtlas.svg)](https://cocoapods.org/pods/ExpoFpIndoorAtlas)
[![Platform](https://img.shields.io/badge/Platforms-%20iOS%20|%20iPadOS-lightgrey.svg)](https://github.com/expofp/expofp-indooratlas-ios)

**ExpoFpIndoorAtlas** is a wrapper around [IndoorAtlas Location Provider](https://github.com/IndoorAtlas), made for **ExpoFP** floor plans.<br>
This package includes the latest version of [ExpoFP SDK](https://github.com/expofp/expofp-sdk-ios).<br>
Also you can take [IndoorAtlas SDK](https://github.com/IndoorAtlas/ios-spm) and create your own wrapper to use with [ExpoFP SDK](https://github.com/expofp/expofp-sdk-ios) following the [IndoorAtlas documentation](https://docs.indooratlas.com/ios/latest/) and this package as an example.

## Setup

### Activate GPS/IPS option:
![image](https://github.com/user-attachments/assets/65658895-cd91-4a66-936d-c7e9bf8ffd82)

### Add permissions to Info.plist:

#### If SDK is started with `isBackgroundUpdatesAllowed = false`:
```xml
<key>NSMotionUsageDescription</key>
<string>YOUR DESCRIPTIVE TEXT HERE</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>YOUR DESCRIPTIVE TEXT HERE</string>
```

#### If SDK is started with `isBackgroundUpdatesAllowed = true`:
```xml
<key>UIBackgroundModes</key>
<array>
    <string>location</string>
</array>

<key>NSMotionUsageDescription</key>
<string>YOUR DESCRIPTIVE TEXT HERE</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>YOUR DESCRIPTIVE TEXT HERE</string>

<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>YOUR DESCRIPTIVE TEXT HERE</string>
```

#### Optionally enable bluetooth for better positioning:
```xml
<key>UIBackgroundModes</key>
<array>
	<string>bluetooth-central</string>
</array>

<key>NSBluetoothAlwaysUsageDescription</key>
<string>YOUR DESCRIPTIVE TEXT HERE</string>
```

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/expofp/expofp-indooratlas-ios", from: "5.0.1"),
]
```

and add it to your target’s dependencies

```swift
.target(
    name: "MyApp",
    dependencies: [
        .product(name: "ExpoFpIndoorAtlas", package: "expofp-indooratlas-ios"),
    ]
),
```

### CocoaPods
> Warning: CocoaPods [will be deprecated soon](https://blog.cocoapods.org/CocoaPods-Specs-Repo/)

```
target 'MyApp' do
    pod 'ExpoFpIndoorAtlas', '~> 5.0.1'
end
```

## Quick Guide

```swift
let locationProvider = ExpoFpIndoorAtlasLocationProvider(
    apiKey: "YourAPIKey",
    apiSecretKey: "YourSecretKey",
    isBackgroundUpdatesAllowed: true
)

let presenter = ExpoFpPlan.createPlanPresenter(
    with: .expoKey("YourExpoKey"),
    locationProvider: locationProvider
)
```

Or set to `presenter` after initialization

```swift
presenter.setLocationProvider(locationProvider)
```

When a plan appers it will call [startUpdatingLocation()](https://expofp.github.io/expofp-sdk-ios/documentation/expofp/iexpofplocationprovider/startupdatinglocation()) and start updating the location automatically.<br>
When a plan disappears it will call [stopUpdatingLocation()](https://expofp.github.io/expofp-sdk-ios/documentation/expofp/iexpofplocationprovider/stopupdatinglocation()) **if location provider is not set as Global**.<br>
You also can manually start and stop your location provider using these methods.

Use our full documentation to [setup global location provider](https://expofp.github.io/expofp-sdk-ios/documentation/expofp/setup-navigation#Setup-location-provider-as-Global) and
[listen location updates](https://expofp.github.io/expofp-sdk-ios/documentation/expofp/setup-navigation#Listen-location-updates-manually).
