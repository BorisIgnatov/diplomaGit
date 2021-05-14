import Foundation
import SwiftyJSON

struct AccountModel: Parseable {
    
    let iconUrl: String
    let fullname: String
    let classNumber: String
    let id: String
    let birthdayDate: String
    
    init?(from json: JSON) {
        iconUrl = json["image"].stringValue
        fullname = json["fullname"].stringValue
        classNumber = json["classNumber"].stringValue
        id = json["id"].stringValue
        birthdayDate = json["birthdayDate"].stringValue
    }
    
    init(icon: String, name: String, classNum: String, idNum: String, bd: String) {
        iconUrl = icon
        fullname = name
        classNumber = classNum
        id = idNum
        birthdayDate = bd
    }
}
