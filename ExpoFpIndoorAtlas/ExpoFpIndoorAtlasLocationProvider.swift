//
//  ExpoFpIndoorAtlasLocationProvider.swift
//  ExpoFpIndoorAtlas
//
//  Created by Nikita Kolesnikov on 19.05.2025.
//  Copyright © 2025 ExpoFP. All rights reserved.
//

import ExpoFpFplan
import Foundation
import IndoorAtlas

public final class ExpoFpIndoorAtlasLocationProvider: NSObject, IALocationManagerDelegate, IExpoFpLocationProvider {

    // MARK: - Properties

    public weak var expoFpLocationProviderDelegate: ExpoFpLocationProviderDelegate?

    private let locationManager = IALocationManager.sharedInstance()
    private var isLocationUpdating = false

    // MARK: - Construction

    public init(apiKey: String, apiSecretKey: String) {
        super.init()

        locationManager.delegate = self
        locationManager.setApiKey(apiKey, andSecret: apiSecretKey)
    }

    // MARK: - Methods

    public func startUpdatingLocation() {
        guard !isLocationUpdating else { return }

        isLocationUpdating = true
        locationManager.startUpdatingLocation()
    }

    public func stopUpdatingLocation() {
        isLocationUpdating = false
        locationManager.stopUpdatingLocation()
    }

    public func indoorLocationManager(_ manager: IALocationManager, didUpdateLocations locations: [Any]) {
        guard isLocationUpdating, let location = locations.first as? IALocation else { return }

        let floor = (location.floor?.level).map(ExpoFpFloor.index)
        let angle = location.location?.course
        let lat = location.location?.coordinate.latitude
        let lng = location.location?.coordinate.longitude
        let position = ExpoFpPosition(z: floor, angle: angle, lat: lat, lng: lng)

        expoFpLocationProviderDelegate?.positionDidChange(position)
    }
}
