import Foundation
import SwiftyJSON

struct ScheduleModel: Parseable {
    
    let location: String
    let subject: String
    let time: String
    let teacher: String
    
    init?(from json: JSON) {
        location = json["location"].stringValue
        subject = json["subeject"].stringValue
        time = json["time"].stringValue
        teacher = json["teacher"].stringValue
    }
    
    init(location: String, subject: String, time: String, teacher: String) {
        self.location = location
        self.subject = subject
        self.time = time
        self.teacher = teacher
    }
}
