import Foundation

enum Endpoint: String {
    case www
    case media = "media/images"
    
    var fullUrl: String {
        Config.shared.baseUrl + "/" + rawValue
    }
    
    var timeout: TimeInterval {
        return 30
    }
}
