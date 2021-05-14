import Foundation

enum Endpoint: String {
    case www
    
    var fullUrl: String {
        Config.shared.baseUrl + "/" + rawValue
    }
    
    var timeout: TimeInterval {
        return 30
    }
}
