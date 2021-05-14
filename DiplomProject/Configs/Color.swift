import Foundation
import UIKit

struct Color {
    
    static var purple: UIColor {
        #colorLiteral(red: 0.5294117647, green: 0.262745098, blue: 1, alpha: 1)
    }
    
    static var primary: UIColor {
        UIColor(red: 241.0 / 255.0, green: 70.0 / 255.0, blue: 53.0 / 255.0, alpha: 1.0)
    }
    
    static var navBarShadowColor: UIColor { #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1) }
}

extension UIColor {
    
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 0.5))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 0.5))

        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()

        return image
    }
}
