import UIKit
import Foundation

final class Config {
    
    static let shared = Config()
    
    let baseUrl = "https://classrom.kz"
    
    func configureUIProxies() {
        UIRefreshControl.appearance().tintColor = Color.purple
        UIActivityIndicatorView.appearance().color = Color.purple
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = Color.purple
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().shadowImage = Color.navBarShadowColor.as1ptImage()
        UINavigationBar.appearance().backItem?.title = "Back"
    }
}
