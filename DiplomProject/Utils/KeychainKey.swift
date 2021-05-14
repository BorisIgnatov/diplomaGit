enum KeychainKey: String, CaseIterable {

    case accessToken
    case refreshToken
    
    var authenticationRequired: Bool {
       return false
    }

    var authenticationPrompt: String? {
        return nil
    }

    var promptForUpdate: String? {
        return nil
    }

    var isPurgeable: Bool {
        return true
    }
}
