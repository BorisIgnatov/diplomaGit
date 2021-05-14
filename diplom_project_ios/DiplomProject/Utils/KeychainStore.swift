import KeychainAccess

protocol KeychainWrapper {
    func entryExists(key: KeychainKey) throws -> Bool
    func set(_ value: CustomStringConvertible, forKey key: KeychainKey) throws
    func set(_ value: Data, forKey key: KeychainKey) throws
    func get(_ key: KeychainKey) -> String?
    func getData(_ key: KeychainKey) -> Data?
    func getBool(_ key: KeychainKey) -> Bool
    func getInt(_ key: KeychainKey) -> Int?
    func delete(_ key: KeychainKey) throws
    func purge()
}

final class KeychainStore {
    static let shared: KeychainWrapper = KeychainSwiftWrapper()
}

private final class KeychainSwiftWrapper: KeychainWrapper {

    private let keychain = Keychain(service: "", accessGroup: "daulet.sergazin.DiplomProject")

    private func keychain(for operationType: OperationType, key: KeychainKey) -> Keychain {
        guard key.authenticationRequired else {
            return keychain
        }

        let policy: AuthenticationPolicy

        if #available(iOS 11.3, *) {
            policy = .biometryCurrentSet
        } else {
            policy = .touchIDCurrentSet
        }

        let chain = keychain.accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: policy)

        let prompt: String?

        switch operationType {
        case .get:
            prompt = key.authenticationPrompt
        case .set:
            prompt = key.promptForUpdate
        }

        return chain.authenticationPrompt(prompt ?? "")
    }

    func entryExists(key: KeychainKey) throws -> Bool {
        try keychain.contains(key.rawValue, withoutAuthenticationUI: true)
    }

    func set(_ value: CustomStringConvertible, forKey key: KeychainKey) throws {
        let value = String(describing: value)
        try keychain(for: .set, key: key).set(value, key: key.rawValue)
    }

    func set(_ value: Data, forKey key: KeychainKey) throws {
        try keychain(for: .set, key: key).set(value, key: key.rawValue)
    }

    func get(_ key: KeychainKey) -> String? {
        try? keychain(for: .get, key: key).get(key.rawValue)
    }

    func getData(_ key: KeychainKey) -> Data? {
        try? keychain(for: .get, key: key).getData(key.rawValue)
    }

    func getBool(_ key: KeychainKey) -> Bool {
        let value = try? keychain(for: .get, key: key).get(key.rawValue)
        return value == String(describing: true)
    }

    func getInt(_ key: KeychainKey) -> Int? {
        return try? Int(keychain(for: .get, key: key).get(key.rawValue) ?? "")
    }

    func delete(_ key: KeychainKey) throws {
        try? keychain.remove(key.rawValue)
    }

    func purge() {
        let keysToRemove = KeychainKey.allCases.filter(\.isPurgeable)
        for key in keysToRemove {
            try? delete(key)
        }
    }
    
}

private enum OperationType {
    case get
    case set
}
