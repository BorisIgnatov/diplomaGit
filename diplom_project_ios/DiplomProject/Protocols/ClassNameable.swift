import Foundation

//MARK: Class name to String conversion
protocol ClassNameable {}

extension ClassNameable {
    
    static var className: String {
        return String(describing: self)
    }
    
}
