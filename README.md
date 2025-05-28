<img src="https://expofp.com/template/img/site-header-logo-inverse.png" width="350"/>

[![Swift Package Manager compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/ExpoFpIndoorAtlas.svg)](https://cocoapods.org/pods/ExpoFpIndoorAtlas)
[![Platform](https://img.shields.io/badge/Platforms-%20iOS%20|%20iPadOS-lightgrey.svg)](https://github.com/expofp/expofp-indooratlas-ios)

**ExpoFpIndoorAtlas** is a wrapper around [IndoorAtlas Location Provider](https://github.com/IndoorAtlas), made for **ExpoFP** floor plans.<br>
This package includes the latest version of [ExpoFP SDK](https://github.com/expofp/expofp-fplan-ios).<br>
Also you can take [IndoorAtlas SDK](https://github.com/IndoorAtlas/ios-spm) and create your own wrapper to use with [ExpoFP SDK](https://github.com/expofp/expofp-fplan-ios) after confirming it to `IExpoFpLocationProvider` protocol following the example in this package.

## 1 Installation

To use Location Provider you **must add** `NSLocationWhenInUseUsageDescription` key in your app `Info.plist` file.<br>
To use Location Provider in background you **must also add** `NSLocationAlwaysUsageDescription` key in your app `Info.plist` file.

### 1.1 Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/expofp/expofp-indooratlas-ios", from: "5.0.0"),
]
```

and then as a dependency for the Package target utilizing **ExpoFpIndoorAtlas**:

```swift
.target(
    name: "MyApp",
    dependencies: [
        .product(name: "ExpoFpIndoorAtlas", package: "expofp-indooratlas-ios"),
    ]
),
```

### 1.2 CocoaPods

```swift
spec.dependency 'ExpoFpIndoorAtlas', '~>5.0.0'
```

## 2 Usage
### 2.1 Load a location provider

```swift
let locationProvider = ExpoFpIndoorAtlasLocationProvider(
    apiKey: "YourAPIKey",
    apiSecretKey: "YourSecretKey"
)
let presenter = ExpoFpPlan.createPlanPresenter(
    with: .expoKey("YourExpoKey"),
    locationProvider: locationProvider
)
```
Plan will call `startUpdatingLocation()` when it appers and `stopUpdatingLocation()` when it disappears.

### 2.2 Load a global location provider

```swift
let locationProvider = ExpoFpIndoorAtlasLocationProvider(
    apiKey: "YourAPIKey",
    apiSecretKey: "YourSecretKey"
)
ExpoFpPlan.globalLocationProvider.sharedProvider = locationProvider

locationProvider.startUpdatingLocation() // if needed

let presenter = ExpoFpPlan.createPlanPresenter(
    with: .expoKey("YourExpoKey"),
    locationProvider: ExpoFpPlan.globalLocationProvider
)
```
Plan will call `startUpdatingLocation()` when it appers.<br>
**Important:** Plan will not call `stopUpdatingLocation()` when it disappears. You are responsible to stop global location provider when you need.

### 2.3 Location provider management

#### Start updating location:
```swift
locationProvider.startUpdatingLocation()

or if global location provider is set

ExpoFpPlan.globalLocationProvider.startUpdatingLocation()
```

#### Stop updating location:
```swift
locationProvider.stopUpdatingLocation()

or if global location provider is set

ExpoFpPlan.globalLocationProvider.stopUpdatingLocation()
```

#### Listen location updates:

```swift
let delegate: ExpoFpLocationProviderDelegate = YourExpoFpLocationProviderDelegate()
locationProvider.expoFpLocationProviderDelegate = delegate

or if global location provider is set

ExpoFpPlan.globalLocationProvider.expoFpLocationProviderDelegate = delegate
```
**Important:** When you initialize `IExpoFpPlanPresenter` with location provider, it automatically becomes location provider delegate. If you need to listen location updates, don't set it to presenter, instead you can update location manually using `presenter.selectCurrentPosition(position)`
