import Foundation
import SwiftyJSON

struct AssignmentModel: Parseable {
    let title: String
    let subject: String
    let description: String
    let date: String
    let deadlineDate: String
    let status: Status
    
    init?(from json: JSON) {
        guard let status = json["status"].string else { return nil }
        
        self.status = Status(rawValue: status) ?? .waiting
        title = json["title"].stringValue
        subject = json["subjectName"].stringValue
        description = json["description"].stringValue
        date = json["date"].stringValue
        deadlineDate = json["deadline"].stringValue
    }
    
    init(title: String, subject: String, description: String, date: String, deadline: String, status: Status) {
        self.title = title
        self.subject = subject
        self.description = description
        self.date = date
        self.deadlineDate = deadline
        self.status = status
    }
}

extension AssignmentModel {
    enum Status: String {
        case submitted
        case waiting
    }
}
