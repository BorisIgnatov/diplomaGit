import UIKit

class MainViewController: UIViewController, CanDisplayAlerts, AppRouterDelegate {

    private(set) var currentVc: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Config.shared.configureUIProxies()
        
        AppRouter.shared.delegate = self
    }
    
    func replaceScreen(with screen: Screen) {
        dismissPresentedViewControllers()
        replaceCurrentViewController(with: screen)
    }
    
    private func replaceCurrentViewController(with vc: UIViewController) {
        guard let currentVc = currentVc else {
            embedChildVc(vc: vc)
            self.currentVc = vc
            view.backgroundColor = .white
            return
        }

        embedChildVc(vc: vc)

        transition(from: currentVc, to: vc, duration: 0, options: .curveLinear, animations: nil, completion: nil)
        currentVc.removeFromParent()
        vc.didMove(toParent: self)
        self.currentVc = vc
    }
    
    private func embedChildVc(vc: UIViewController) {
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func dismissPresentedViewControllers() {
        presentedViewController?.dismiss(animated: false, completion: nil)

        if let currentVc = currentVc {
            currentVc.presentedViewController?.dismiss(animated: false, completion: nil)
        }
    }
}

