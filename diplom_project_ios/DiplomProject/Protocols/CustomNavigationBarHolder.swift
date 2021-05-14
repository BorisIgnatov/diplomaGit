import Foundation
import UIKit

protocol CustomNavigationBarHolder {
    var navigationBarColor: UIColor { get }
    var navigationBarTitleColor: UIColor { get }
}

extension CustomNavigationBarHolder where Self: UIViewController {

    func makeDisplayLargeTitle(with mode: UINavigationItem.LargeTitleDisplayMode = .always) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = mode
    }

    func setNavigationBarColor(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            getAppearances().forEach { $0.backgroundColor = color }
        } else {
            navigationController?.navigationBar.barTintColor = color
        }
    }
    
    func setNavigationBarTitleColor(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            getAppearances().forEach {
                $0.titleTextAttributes = [.foregroundColor: navigationBarTitleColor]
                $0.largeTitleTextAttributes = [.foregroundColor: navigationBarTitleColor]
            }
        } else {
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: navigationBarTitleColor]
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: navigationBarTitleColor]
        }
    }

    func setNavigationBarShadowImage(hidden shouldBeHidden: Bool) {
        if #available(iOS 13.0, *) {
            getAppearances().forEach {
                $0.shadowImage = shouldBeHidden ? nil : Color.navBarShadowColor.as1ptImage()

                if shouldBeHidden {
                    $0.shadowColor = .clear
                } else {
                    $0.shadowColor = Color.navBarShadowColor
                }
            }
        } else {
            navigationController?.navigationBar.shadowImage = shouldBeHidden
                ? UIImage()
                : Color.navBarShadowColor.as1ptImage()
        }
    }

    @available(iOS 13.0, *)
    private func getAppearances() -> [UINavigationBarAppearance] {
        [
            navigationController?.navigationBar.standardAppearance,
            navigationController?.navigationBar.scrollEdgeAppearance,
            navigationController?.navigationBar.compactAppearance,
        ].compactMap { $0 }
    }
}
