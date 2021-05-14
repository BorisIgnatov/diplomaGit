import UIKit

protocol TabBarRoutingManageable: class {
    var delegate: UITabBarControllerDelegate? { get set }

    var currentTab: TabItem { get }
    var tabItems: [TabItem] { get }
    var selectedIndex: Int { get set }

    func tabRootViewController(for tabItem: TabItem) -> UINavigationController?
}

final class TabBarRouter: NSObject {
    
    weak var tabBarRoutingManageable: (TabBarRoutingManageable & UIViewController)? {
        didSet {
            tabBarRoutingManageable?.delegate = self
        }
    }
    
    var currentlySelectedTab: TabItem? {
        tabBarRoutingManageable?.currentTab
    }
    
    func showTab(_ tabItem: TabItem) {
        guard let tabIndex = tabBarRoutingManageable?.tabItems.firstIndex(of: tabItem) else { return }

        let vc = tabBarRoutingManageable?.tabRootViewController(for: tabItem)
        vc?.presentedViewController?.dismiss(animated: false, completion: nil)
        vc?.viewControllers.last?.dismiss(animated: false, completion: nil)
        vc?.popToRootViewController(animated: false)

        tabBarRoutingManageable?.selectedIndex = tabIndex
    }
}

extension TabBarRouter: UITabBarControllerDelegate {

}
