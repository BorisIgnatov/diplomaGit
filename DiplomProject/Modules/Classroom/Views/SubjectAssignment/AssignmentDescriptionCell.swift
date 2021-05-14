import UIKit

final class AssignmentDescriptionCell: CommonTableViewCell {
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        
        return label
    }()
    
    override func addElements() {
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(top: 20, left: 21, bottom: 20, right: 21))
        }
    }
    
    func configure(description: String) {
        descriptionLabel.text = description
    }
}
