import Foundation
import UIKit

final class AssignmentStatusView: CommonView {
    
    var deadlineDate: String? {
        didSet {
            guard deadlineDate != nil else {
                submittedLabel.isHidden = false
                submittedIcon.isHidden = false
                deadlineLabel.isHidden = true
                return
            }
            
            submittedLabel.isHidden = true
            submittedIcon.isHidden = true
            deadlineLabel.isHidden = false
            
            deadlineLabel.text = deadlineDate
        }
    }
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = #colorLiteral(red: 0.9607843137, green: 0.2156862745, blue: 0.1764705882, alpha: 1)
        
        return label
    }()
    
    private let submittedIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "submitted")
        
        return imageView
    }()
    
    private let submittedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.text = "Submitted"
        
        return label
    }()
    
    override func addElements() {
        addSubview(submittedIcon)
        submittedIcon.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(16)
            $0.width.equalTo(18)
        }
        
        addSubview(submittedLabel)
        submittedLabel.snp.makeConstraints {
            $0.leading.equalTo(submittedIcon.snp.trailing).offset(5)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        submittedIcon.isHidden = true
        submittedLabel.isHidden = true
        
        addSubview(deadlineLabel)
        deadlineLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
