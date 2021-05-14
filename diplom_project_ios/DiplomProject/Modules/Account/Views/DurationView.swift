import UIKit

final class DurationView: CommonView {
    
    var duration: String? {
        didSet {
            durationLabel.text = duration
        }
    }
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.4352941176, green: 0.2549019608, blue: 0.9215686275, alpha: 1)
        label.font = .systemFont(ofSize: 9, weight: .medium)
        
        return label
    }()
    
    override func addElements() {
        backgroundColor = #colorLiteral(red: 0.4274509804, green: 0.2470588235, blue: 0.9019607843, alpha: 0.1)
        layer.cornerRadius = 8

        addSubview(durationLabel)
        durationLabel.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8))
        }
    }
}
