import UIKit

enum TabItem {
    case account
    case schedule
    case grades
    case classroom
    case attendance
    
    var viewController: UIViewController {
        switch self {
        case .account:
            return AccountPage()
        case .schedule:
            return SchedulePage()
        case .grades:
            return GradesListPage()
        case .classroom:
            return SubjectAssignmentsPage()
        case .attendance:
            return AttendanceViewController()
        }
    }
    
    var tabBarItem: UITabBarItem {
        switch self {
        case .account:
            return UITabBarItem(title: nil, image: #imageLiteral(resourceName: "account_unselected"), selectedImage: #imageLiteral(resourceName: "account_selected"))

        case .schedule:
            return UITabBarItem(title: nil, image: #imageLiteral(resourceName: "schedule_unselected"), selectedImage: #imageLiteral(resourceName: "schedule_selected"))

        case .grades:
            return UITabBarItem(title: nil, image: #imageLiteral(resourceName: "grades_unselected"), selectedImage: #imageLiteral(resourceName: "grades_selected"))

        case .classroom:
            return UITabBarItem(title: nil, image: #imageLiteral(resourceName: "classroom_unselected"), selectedImage: #imageLiteral(resourceName: "classroom_selected"))
            
        case .attendance:
            return UITabBarItem(title: nil, image: #imageLiteral(resourceName: "attendance-icon"), selectedImage: #imageLiteral(resourceName: "attendance-selected"))
        }
    }
}
