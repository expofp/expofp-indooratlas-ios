//
//  ExpoFpIndoorAtlasLocationProviderSettings.swift
//  ExpoFpIndoorAtlas
//
//  Created by Nikita Kolesnikov on 13.10.2025.
//

import ExpoFP
import Foundation

/// Settings for `ExpoFpIndoorAtlasLocationProvider` initialization.
public struct ExpoFpIndoorAtlasLocationProviderSettings {
    
    /// Authentication credential `ApiKey`
    public let apiKey: String
    /// Authentication credential `Secret`
    public let secret: String
    /// Enables location tracking while the app is in the background.
    public let isBackgroundUpdatesAllowed: Bool
    
    /// Settings for `ExpoFpIndoorAtlasLocationProvider` initialization.
    /// - Parameters:
    ///   - apiKey: Authentication credential `ApiKey`
    ///   - secret: Authentication credential `Secret`
    ///   - isBackgroundUpdatesAllowed: Enables location tracking while the app is in the background.
    public init(apiKey: String, secret: String, isBackgroundUpdatesAllowed: Bool) throws {
        let apiKey = apiKey.replacingOccurrences(of: " ", with: "")
        if apiKey.isEmpty { throw ExpoFpError.locationProviderError(message: "ApiKey must not be empty.") }
        self.apiKey = apiKey

        let secret = secret.replacingOccurrences(of: " ", with: "")
        if secret.isEmpty { throw ExpoFpError.locationProviderError(message: "Secret must not be empty.") }
        self.secret = secret

        try Self.checkLocationPermissions(isBackgroundUpdatesAllowed)
        self.isBackgroundUpdatesAllowed = isBackgroundUpdatesAllowed
    }

    // MARK: - Check Permission Methods

    private static func checkLocationPermissions(_ isBackgroundUpdatesAllowed: Bool) throws(ExpoFpError) {
        guard checkDescription(for: .motionUsage) else {
            throw ExpoFpError.locationProviderError(message: Self.message(for: .motionUsage))
        }

        guard checkDescription(for: .locationWhenInUse) else {
            throw ExpoFpError.locationProviderError(message: Self.message(for: .locationWhenInUse))
        }

        guard isBackgroundUpdatesAllowed else { return }

        guard checkDescription(for: .locationAlwaysAndWhenInUse) else {
            throw ExpoFpError.locationProviderError(message: Self.message(for: .locationAlwaysAndWhenInUse))
        }

        guard checkBackgroundMode(.location) else {
            throw ExpoFpError.locationProviderError(message: "App's Info.plist file is missing the `location` entry in the `UIBackgroundModes` array.")
        }
    }

    private static func message(for permission: Permission) -> String {
        "App's Info.plist file is missing the `\(permission.rawValue)` entry."
    }

    private static func checkDescription(for permission: Permission) -> Bool {
        let description = Bundle.main.object(forInfoDictionaryKey: permission.rawValue) as? String
        return description?.isEmpty == false
    }

    private static func checkBackgroundMode(_ mode: BackgroundMode) -> Bool {
        let modes = (Bundle.main.object(forInfoDictionaryKey: BackgroundMode.name) as? [String]) ?? []
        return modes.contains(mode.rawValue)
    }

    private enum BackgroundMode: String {
        case location

        static let name = "UIBackgroundModes"
    }

    private enum Permission: String {
        case locationWhenInUse = "NSLocationWhenInUseUsageDescription"
        case locationAlwaysAndWhenInUse = "NSLocationAlwaysAndWhenInUseUsageDescription"
        case motionUsage = "NSMotionUsageDescription"
    }
}
