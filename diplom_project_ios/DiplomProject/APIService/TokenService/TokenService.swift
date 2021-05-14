import Foundation

final class TokenService {

    static let shared = TokenService()
    
    var acsessToken: String? {
        KeychainStore.shared.get(.accessToken)
    }
    
    var refreshToken: String? {
        KeychainStore.shared.get(.refreshToken)
    }
    
    private init() {}
    
    func saveAccessToken(_ token: String) throws {
        try KeychainStore.shared.set(token, forKey: .accessToken)
    }
    
    func saveRefreshToken(_ token: String) throws {
        try KeychainStore.shared.set(token, forKey: .refreshToken)
    }
}
