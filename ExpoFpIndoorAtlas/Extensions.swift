//
//  Extensions.swift
//  ExpoFpIndoorAtlas
//
//  Created by Nikita Kolesnikov on 13.10.2025.
//  Copyright © 2025 ExpoFP. All rights reserved.
//

import ExpoFP

extension ExpoFpPosition {

    func updateHeading(newHeading: Double?) -> ExpoFpPosition {
        ExpoFpPosition(x: x, y: y, z: z, angle: newHeading, lat: lat, lng: lng)
    }
}
