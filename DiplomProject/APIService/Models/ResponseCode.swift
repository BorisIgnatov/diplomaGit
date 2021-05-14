import Foundation

enum ResponseCode: Equatable {
    case ok
    case unknown(code: Int)
    
    init(code: Int) {
        switch code {
        case 0:
            self = .ok
        default:
            self = .unknown(code: code)
        }
    }
}
