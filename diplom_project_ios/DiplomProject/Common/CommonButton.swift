import UIKit

class CommonButton: UIButton {

    private(set) var style: Style = .purple
    
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.cornerRadius = layer.cornerRadius
        gradient.colors = [#colorLiteral(red: 0.5294117647, green: 0.262745098, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.2549019608, green: 0.2117647059, blue: 0.9450980392, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        
        return gradient
    }()

    convenience init() {
        self.init(type: .system)
        configure()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame = bounds
    }

    func configure() {
        layer.cornerRadius = 16

        setStyle(style)
    }

    func setStyle(_ style: Style) {
        switch style {
        case .purple:
            setTitleColor(.white, for: [])
            applyGradient()
        }

        self.style = style
        titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    private func applyGradient() {
        layer.insertSublayer(gradient, at: 0)
    }

}

extension CommonButton {
    enum Style {
        case purple
    }
}
