//
//  ExpoFpIndoorAtlasLocationProvider.swift
//  ExpoFpIndoorAtlas
//
//  Created by Nikita Kolesnikov on 19.05.2025.
//  Copyright © 2025 ExpoFP. All rights reserved.
//

import ExpoFP
import Foundation
import IndoorAtlas

public final class ExpoFpIndoorAtlasLocationProvider: NSObject, IALocationManagerDelegate, IExpoFpLocationProvider {

    // MARK: - Properties

    public weak var expoFpLocationProviderDelegate: ExpoFpLocationProviderDelegate?

    public private(set) var traceId: String?
    public private(set) var settings: ExpoFpIndoorAtlasLocationProviderSettings
    private let locationManager = IALocationManager.sharedInstance()
    private var isLocationUpdating = false

    private var position = ExpoFpPosition() {
        didSet {
            guard isLocationUpdating else { return }
            expoFpLocationProviderDelegate?.positionDidChange(position)
        }
    }

    // MARK: - Construction

    public init(settings: ExpoFpIndoorAtlasLocationProviderSettings) {
        self.settings = settings
        super.init()

        locationManager.delegate = self
    }

    // MARK: - Methods

    /// Apply new settings.
    /// If location is updating, method will automatically stop and start location updates with new settings
    /// - Parameter settings: Settings for ExpoFpCrowdConnectedLocationProvider initialization.
    public func updateSettings(_ settings: ExpoFpIndoorAtlasLocationProviderSettings) {
        self.settings = settings

        if isLocationUpdating {
            stopUpdatingLocation()
            startUpdatingLocation()
        }
    }

    public func startUpdatingLocation() {
        guard !isLocationUpdating else { return }
        isLocationUpdating = true

        locationManager.setApiKey(settings.apiKey, andSecret: settings.secret)
        locationManager.allowsBackgroundLocationUpdates = settings.isBackgroundUpdatesAllowed
        locationManager.startUpdatingLocation()
    }

    public func stopUpdatingLocation() {
        isLocationUpdating = false
        locationManager.stopUpdatingLocation()
    }

    // MARK: - IALocationManagerDelegate

    public func indoorLocationManager(_ manager: IALocationManager, statusChanged status: IAStatus) {
        let message: String? = switch status.type {
        case .iaStatusServiceOutOfService: "iaStatusServiceOutOfService"
        case .iaStatusServiceUnavailable: "iaStatusServiceUnavailable"
        case .iaStatusServiceLimited: "iaStatusServiceLimited"
        default: nil
        }

        message.map {
            expoFpLocationProviderDelegate?.errorOccurred(.locationProviderError(message: $0), from: .indoorAtlas)
        }
    }

    public func indoorLocationManager(_ manager: IALocationManager, didReceiveExtraInfo extraInfo: [AnyHashable : Any]) {
        traceId = extraInfo[kIATraceId] as? String
    }

    public func indoorLocationManager(_ manager: IALocationManager, didUpdate newHeading: IAHeading) {
        guard position != ExpoFpPosition() else { return }
        position = position.updateHeading(newHeading: newHeading.trueHeading)
    }

    public func indoorLocationManager(_ manager: IALocationManager, didUpdateLocations locations: [Any]) {
        guard isLocationUpdating, let location = locations.last as? IALocation else { return }
        updatePosition(with: location)
    }

    public func indoorLocationManager(_ manager: IALocationManager, didUpdate locations: [IALocation]) {
        guard isLocationUpdating, let location = locations.last else { return }
        updatePosition(with: location)
    }

    // MARK: - Private Methods

    private func updatePosition(with location: IALocation) {
        let floor = (location.floor?.level).map(ExpoFpFloorType.index)
        let angle = location.location?.course ?? position.angle
        let lat = location.location?.coordinate.latitude
        let lng = location.location?.coordinate.longitude

        position = ExpoFpPosition(z: floor, angle: angle, lat: lat, lng: lng)
    }
}
