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
    
    public func start() {
        self.locationManager.delegate = self
        self.locationManager.setApiKey(settings.apiKey, andSecret: settings.apiSecretKey)
        self.locationManager.startUpdatingLocation()
    }
    
    public func stop() {
        self.locationManager.stopUpdatingLocation()
        self.locationManager.delegate = nil
    }
    
    public func indoorLocationManager(_ manager: IALocationManager, didUpdateLocations locations: [Any]) {
        let l = locations.last as! IALocation
        var dloc: ExpoFpCommon.Location? = nil;
        
        if let newLocation = l.location?.coordinate {
            //print("Position changed to coordinate: \(newLocation.latitude) \(newLocation.longitude)")
            dloc = ExpoFpCommon.Location(latitude: newLocation.latitude, longitude: newLocation.longitude, angle: nil)
        }
        
        if let loc = dloc {
            if let dlg = delegate {
                dlg.didUpdateLocation(location: loc)
            }
        }
    }
}
