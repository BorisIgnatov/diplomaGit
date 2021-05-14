import UIKit

final class TabBarController: UITabBarController {
        
    private var navControllers = [UINavigationController]()
    
    let tabItems: [TabItem]
    
    init() {
        tabItems = [
            .classroom,
            .schedule,
            .grades,
            .account
        ]
        
        super.init(nibName: nil, bundle: nil)
        
        setupTabs()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadTabItems() {
        navControllers = tabItems.map {
            let vc = $0.viewController
            vc.hidesBottomBarWhenPushed = false

            let navC = UINavigationController(rootViewController: vc)
            navC.tabBarItem = $0.tabBarItem
            return navC
        }

        viewControllers = navControllers
    }

    private func setupTabs() {
        tabBar.tintColor = Color.purple
        loadTabItems()
    }
}


extension TabBarController: TabBarRoutingManageable {
    
    var currentTab: TabItem {
        tabItems[selectedIndex]
    }
    
    func tabRootViewController(for tabItem: TabItem) -> UINavigationController? {
        guard let index = tabItems.firstIndex(of: tabItem) else { return nil }

        return navControllers[index]
    }
}
