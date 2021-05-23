final class DataExample {
    static func getTermGradesModel() -> [TermGradesModel] {
        let mathGradeParts = [
            GradePart(title: "Homework", point: "95"),
            GradePart(title: "Practice", point: "0"),
            GradePart(title: "Quiz", point: "95"),
            GradePart(title: "Bonus", point: "95"),
            GradePart(title: "Exam", point: "95"),
            GradePart(title: "Attendance", point: "95"),
        ]
        
        let geometryGradeParts = [
            GradePart(title: "Homework", point: "100"),
            GradePart(title: "Practice", point: "100"),
            GradePart(title: "Quiz", point: "100"),
            GradePart(title: "Bonus", point: "0"),
            GradePart(title: "Exam", point: "100"),
            GradePart(title: "Attendance", point: "95"),
        ]
        
        let subjects1 = [
            SubjectGradesModel(subjectTitle: "Mathematics",
                               overallGrade: "95",
                               gradeParts: mathGradeParts),
            SubjectGradesModel(subjectTitle: "Geometry",
                               overallGrade: "100",
                               gradeParts: geometryGradeParts),
            SubjectGradesModel(subjectTitle: "Russian",
                               overallGrade: "100",
                               gradeParts: []),
            SubjectGradesModel(subjectTitle: "Kazakh",
                               overallGrade: "90",
                               gradeParts: []),
            SubjectGradesModel(subjectTitle: "Biology",
                               overallGrade: "88",
                               gradeParts: []),
            SubjectGradesModel(subjectTitle: "Chemistry",
                               overallGrade: "77",
                               gradeParts: []),
        ]
        
        let subjects2 = [
            SubjectGradesModel(subjectTitle: "Mathematics",
                               overallGrade: "100",
                               gradeParts: mathGradeParts),
            SubjectGradesModel(subjectTitle: "Geometry",
                               overallGrade: "100",
                               gradeParts: geometryGradeParts),
            SubjectGradesModel(subjectTitle: "Russian",
                               overallGrade: "99",
                               gradeParts: []),
            SubjectGradesModel(subjectTitle: "Kazakh",
                               overallGrade: "95",
                               gradeParts: []),
            SubjectGradesModel(subjectTitle: "Biology",
                               overallGrade: "93",
                               gradeParts: []),
            SubjectGradesModel(subjectTitle: "Chemistry",
                               overallGrade: "84",
                               gradeParts: []),
        ]
        
        
        let models = [
            TermGradesModel(title: "(2020-2021) 1. Term", subjects: subjects1),
            TermGradesModel(title: "(2020-2021) 2. Term", subjects: subjects2),
            TermGradesModel(title: "(2020-2021) 3. Term", subjects: []),
            TermGradesModel(title: "(2020-2021) 4. Term", subjects: []),
        ]
        
        return models
    }
    
    static func getAttendanceModel() -> AttendanceModel {
        let names: [String] = [
            "Chris Evans",
            "Chris Hemsworth",
            "Jeremy Renner",
            "Mark Ruffalo",
            "Robert Downey Jr",
            "Scarlett Johansson"
        ]
        
        let weeks: [String] = [
            "Mon\n3",
            "Wed\n5",
            "Fri\n7",
        ]
        
        return AttendanceModel(names: names, weeks: weeks)
    }
    
    static func classmates() -> [ClassmateModel] {
        let urls = [
            "\(Endpoint.media.fullUrl)/chris_evans45.png",
            "\(Endpoint.media.fullUrl)/chris_hemsworth38.png",
            "\(Endpoint.media.fullUrl)/jeremy_renner.jpg",
            "\(Endpoint.media.fullUrl)/mark_ruffalo1.png",
            "\(Endpoint.media.fullUrl)/robert_downey_jr48.png",
            "\(Endpoint.media.fullUrl)/scarlett_johansson46.png",
        ]
        return [
            ClassmateModel(name: "Turmanova Saule", imgUrl: "https://image.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg", id: nil, position: "teacher"),
            ClassmateModel(name: "Chris Evans", imgUrl: urls[0], id: "170107667", position: "head"),
            ClassmateModel(name: "Chris Hemsworth", imgUrl: urls[1], id: "170107667", position: "student"),
            ClassmateModel(name: "Jeremy Renner", imgUrl: urls[2], id: "170107667", position: "student"),
            ClassmateModel(name: "Mark Ruffalo", imgUrl: urls[3], id: "170107667", position: "student"),
            ClassmateModel(name: "Robert Downey Jr", imgUrl: urls[4], id: "170107667", position: "student"),
            ClassmateModel(name: "Scarlett Johansson", imgUrl: urls[5], id: "170107667", position: "student"),
        ]
    }
}
