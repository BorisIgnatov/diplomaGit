import UIKit
import SnapKit
import MaterialComponents

protocol ActivityIndicator {
    func startAnimating()
    func stopAnimating()
}

extension MDCActivityIndicator: ActivityIndicator {
}

final class LoadingLayer {
    
    typealias Loader = ActivityIndicator & UIView

    public static let shared = LoadingLayer()

    var layer: UIView?
    let indicator: Loader = {
        let indicator = MDCActivityIndicator(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        indicator.backgroundColor = .white
        indicator.layer.cornerRadius = indicator.frame.width / 2
        indicator.cycleColors = [Color.primary]
        indicator.radius = 10
        return indicator
    }()

    private init() {
        self.setup()
    }

    func setup() {
        layer = UIView(frame: UIScreen.main.bounds)
        layer?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        layer?.addSubview(indicator)
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(30)
        }
    }

    func startAnimating() {
        guard let keyWindow = UIApplication.shared.keyWindow, let layer = layer else {
            return
        }

        if layer.superview == nil {
            indicator.startAnimating()
            keyWindow.addSubview(layer)
        }
    }

    func stopAnimating() {
        guard let layer = layer else {
            return
        }

        if layer.superview != nil {
            indicator.stopAnimating()
            layer.removeFromSuperview()
        }
    }

}
