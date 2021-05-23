import UIKit

final class OverallGradeView: CommonView {
    
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.cornerRadius = layer.cornerRadius
        gradient.colors = [#colorLiteral(red: 0.8941176471, green: 0.8980392157, blue: 1, alpha: 0.5).cgColor, #colorLiteral(red: 0.7215686275, green: 0.3960784314, blue: 0.9215686275, alpha: 0.5).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        
        return gradient
    }()
    
    private let gradeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "Overall score: "
        
        return label
    }()
    
    var grade: String? {
        didSet {
            gradeLabel.text = grade
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame = bounds
    }
    
    override func addElements() {
        layer.insertSublayer(gradient, at: 0)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-5)
            $0.leading.equalToSuperview().offset(75)
        }
        
        addSubview(gradeLabel)
        gradeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-5)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().offset(-75)
        }
    }
}
