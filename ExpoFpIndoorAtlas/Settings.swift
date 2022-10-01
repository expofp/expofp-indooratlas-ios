import Foundation

public class Settings {
    
    public let apiKey: String
    
    public let apiSecretKey: String
    
    public init(_ apiKey: String, _ apiSecretKey: String) {
        self.apiKey = apiKey
        self.apiSecretKey = apiSecretKey
    }
}
