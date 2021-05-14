import Foundation
import SwiftyJSON

protocol Parseable {
    init?(from json: JSON)
}

extension Array: Parseable where Element: Parseable {
    init(from json: JSON) {
        let elements = json.arrayValue.compactMap {
            Element(from: $0)
        }
        self.init(elements)
    }
}
