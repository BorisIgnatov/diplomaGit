import Foundation
import UIKit

final class TermSelectionCell: CommonTableViewCell {
    
    var isSelectedCell: Bool = false {
        didSet {
            selectionImageView.image = isSelectedCell ? #imageLiteral(resourceName: "selected_icon") : #imageLiteral(resourceName: "unselected_icon")
        }
    }
    
    var termTitle: String? {
        didSet {
            termLabel.text = termTitle
        }
    }
    
    private let selectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "unselected_icon")
        imageView.contentMode = .center

        return imageView
    }()
    
    private let termLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    override func addElements() {
        contentView.addSubview(selectionImageView)
        selectionImageView.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.top.equalToSuperview().offset(13)
            $0.bottom.equalToSuperview().offset(-13)
            $0.trailing.equalToSuperview().offset(-17)
        }
        
        contentView.addSubview(termLabel)
        termLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(18)
            $0.trailing.equalTo(selectionImageView.snp.leading).offset(-17)
            $0.centerY.equalToSuperview()
        }
    }
    
}
