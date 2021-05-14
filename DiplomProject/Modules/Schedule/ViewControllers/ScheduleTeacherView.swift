import Foundation
import UIKit

final class ScheduleTecherView: CommonView {
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var icon: UIImage? {
        didSet {
            iconView.image = icon
            iconView.layer.cornerRadius = iconView.frame.width / 2
        }
    }
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        
        return label
    }()
    
    override func addElements() {
        addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.size.equalTo(32)
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(iconView.snp.trailing).offset(7)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
