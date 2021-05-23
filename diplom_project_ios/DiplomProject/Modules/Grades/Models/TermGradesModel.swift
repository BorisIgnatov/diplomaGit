import Foundation
import SwiftyJSON

struct TermGradesModel: Parseable {
    let termTitle: String
    let subjects: [SubjectGradesModel]
    
    init?(from json: JSON) {
        termTitle = json["termTitle"].stringValue
        subjects = [SubjectGradesModel](from: json["subjectGrades"])
    }
    
    init(title: String, subjects: [SubjectGradesModel]) {
        termTitle = title
        self.subjects = subjects
    }
}

struct SubjectGradesModel: Parseable {
    let subjectTitle: String
    let overallGrade: String
    let gradeParts: [GradePart]
    
    init?(from json: JSON) {
        subjectTitle = json["subjectTitle"].stringValue
        overallGrade = json["overallGrade"].stringValue
        gradeParts = [GradePart](from: json["gradeParts"])
    }
    
    init(subjectTitle: String, overallGrade: String, gradeParts: [GradePart]) {
        self.subjectTitle = subjectTitle
        self.overallGrade = overallGrade
        self.gradeParts = gradeParts
    }
}

struct GradePart: Parseable {
    let partTitle: String
    let point: String
    
    init?(from json: JSON) {
        partTitle = json["partTitle"].stringValue
        point = json["point"].stringValue
    }
    
    init(title: String, point: String) {
        partTitle = title
        self.point = point
    }
}

