import Foundation
import SwiftyJSON

struct ClassmateModel: Parseable {
    
    let name: String
    let imgUrl: String
    let id: String?
    let position: String?
    
    init?(from json: JSON) {
        name = json["name"].stringValue
        imgUrl = json["imgUrl"].stringValue
        id = json["id"].string
        position = json["position"].string
    }
    
    init(name: String, imgUrl: String, id: String?, position: String) {
        self.name = name
        self.imgUrl = imgUrl
        self.id = id
        self.position = position
    }
}
