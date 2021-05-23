import UIKit
import Foundation

final class Config {
    
    static let shared = Config()
    
    let baseUrl = "http://546365095b59.ngrok.io"
    
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
