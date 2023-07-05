import Foundation
import ExpoFpCommon
import IndoorAtlas

public class IndoorAtlasProvider : NSObject, IALocationManagerDelegate, LocationProvider {
    private let settings: Settings
    private let locationManager: IALocationManager
    
    private var lDelegate: ExpoFpCommon.LocationProviderDelegate? = nil
    public var delegate: ExpoFpCommon.LocationProviderDelegate? {
        get { lDelegate }
        set(newDelegate) { lDelegate = newDelegate }
    }
    
    public init(_ settings: Settings){
        self.settings = settings
        self.locationManager = IALocationManager.sharedInstance()
    }
    
    public func start(_ inBackground: Bool) {
        self.locationManager.delegate = self
        self.locationManager.setApiKey(settings.apiKey, andSecret: settings.apiSecretKey)
        self.locationManager.startUpdatingLocation()
    }
    
    public func stop() {
        self.locationManager.stopUpdatingLocation()
        self.locationManager.delegate = nil
    }
    
    public func indoorLocationManager(_ manager: IALocationManager, didUpdateLocations locations: [Any]) {
        if (locations.isEmpty) {
            return
        }
        
        if let location = locations.first as? IALocation {
            let floor = location.floor?.level.description ?? nil
            let course = location.location?.course ?? nil
            
            let lat = location.location?.coordinate.latitude
            let lon = location.location?.coordinate.longitude

            let dloc = ExpoFpCommon.Location(z: floor, angle: course, latitude: lat, longitude: lon)
            
            if let dlg = delegate {
                dlg.didUpdateLocation(location: dloc)
            }
        }
    }
}
