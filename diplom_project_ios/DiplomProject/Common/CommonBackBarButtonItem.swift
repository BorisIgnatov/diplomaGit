import UIKit

final class CommonBackBarButtonItem: UIBarButtonItem {

    @available(iOS 14.0, *)
    override var menu: UIMenu? {
        get {
            return super.menu
        } set { }
    }
}
