import Foundation
import UIKit

class CommonView: UIView, ClassNameable {

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addElements()
    }

    func addElements() {
        //Use this method for adding subviews programatically
    }

}
