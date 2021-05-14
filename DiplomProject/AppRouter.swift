import Foundation
import PromiseKit

typealias Screen = UIViewController

protocol AppRouterDelegate: class, CanDisplayAlerts {
    var currentVc: UIViewController? { get }
    func replaceScreen(with screen: Screen)
}

final class AppRouter {

    static let shared = AppRouter()
    
    let tabBarRouter = TabBarRouter()
    
    weak var delegate: (AppRouterDelegate & UIViewController)?
    
    private init() {}
    
    func proceedToApp() {
        let vc = tabBarController()
        delegate?.replaceScreen(with: vc)
    }
    
    func exit() {
        let vc = LoginPage()
        delegate?.replaceScreen(with: vc)
    }
    
    private func tabBarController() -> TabBarController {
        let vc = TabBarController()
        tabBarRouter.tabBarRoutingManageable = vc
        return vc
    }
}
