import UIKit

final class AssignmentUploadTitleCell: CommonTableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .semibold)
        
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .red
        label.textAlignment = .right
        
        return label
    }()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var status: String? {
        didSet {
            statusLabel.text = status
        }
    }
    
    override func addElements() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(44)
            $0.leading.equalToSuperview().offset(26)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        contentView.addSubview(statusLabel)
        (statusLabel).snp.makeConstraints {
            $0.top.equalToSuperview().offset(44)
            $0.trailing.equalToSuperview().offset(-26)
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(10)
        }
    }
}
