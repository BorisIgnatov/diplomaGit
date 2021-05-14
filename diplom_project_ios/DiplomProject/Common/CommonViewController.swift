import UIKit

class CommonViewController: UIViewController, CanDisplayAlerts, CustomNavigationBarHolder, ClassNameable {

    var navigationBarColor: UIColor { return .white }
    
    var navigationBarTitleColor: UIColor { return .black }

    var hidesNavigationBar: Bool { false }

    var hidesKeyboardByTap: Bool { false }

    convenience init() {
        self.init(nibName: nil, bundle: nil)
        removeNavigationTitle()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        hidesBottomBarWhenPushed = true
        removeNavigationTitle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never

        navigationItem.backBarButtonItem = CommonBackBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)

        if hidesKeyboardByTap {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tapGesture)
        }

        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.standardAppearance = UINavigationBarAppearance()
            navigationController?.navigationBar.scrollEdgeAppearance = UINavigationBarAppearance()
            navigationController?.navigationBar.compactAppearance = UINavigationBarAppearance()
        }

        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isTranslucent = false
        setNavigationBarShadowImage(hidden: false)

        tabBarController?.showTabBar(animated: false)
        tabBarController?.tabBar.isHidden = hidesBottomBarWhenPushed

        setNavigationBarColor(navigationBarColor)
        setNavigationBarTitleColor(navigationBarTitleColor)

        if hidesNavigationBar {
            navigationController?.view.backgroundColor = view.backgroundColor
        }

        navigationController?.setNavigationBarHidden(hidesNavigationBar, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }

    private func removeNavigationTitle() {
        navigationItem.title = ""
    }

}
