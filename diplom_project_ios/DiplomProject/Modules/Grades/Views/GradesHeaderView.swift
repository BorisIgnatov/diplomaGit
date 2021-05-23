import Foundation
import UIKit

final class GradesHeaderView: CommonView {
    
    var title: String? {
        didSet {
            subjectLabel.text = title
        }
    }
    
    private let bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "Klyksa")
        
        return imageView
    }()
    
    private let subjectLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        
        return label
    }()
    
    override func addElements() {
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bgImageView.addSubview(subjectLabel)
        subjectLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
            $0.bottom.equalToSuperview().offset(-45)
        }
    }

}
