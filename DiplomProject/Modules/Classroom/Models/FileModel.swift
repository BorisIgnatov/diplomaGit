import Foundation
import SwiftyJSON

struct FileModel: Parseable {
    let filename: String
    let url: String
    
    init?(from json: JSON) {
        filename = json["filename"].stringValue
        url = json["url"].stringValue
    }
    
    init(filename: String, url: String) {
        self.filename = filename
        self.url = url
    }
}
