import Foundation
import SwiftyJSON

struct TermGradesModel: Parseable {
    let termTitle: String
    let subjects: [SubjectGradesModel]
    
    init?(from json: JSON) {
        termTitle = json["termTitle"].stringValue
        subjects = [SubjectGradesModel](from: json["subjectGrades"])
    }
    
    init(title: String) {
        termTitle = title
        subjects = []
    }
}

struct SubjectGradesModel: Parseable {
    let subjectTitle: String
    let gradeParts: [GradePart]
    
    init?(from json: JSON) {
        subjectTitle = json["subjectTitle"].stringValue
        gradeParts = [GradePart](from: json["gradeParts"])
    }
}

extension SubjectGradesModel {
    
    struct GradePart: Parseable {
        let partTitle: String
        let point: String
        
        init?(from json: JSON) {
            partTitle = json["partTitle"].stringValue
            point = json["point"].stringValue
        }
    }
}
