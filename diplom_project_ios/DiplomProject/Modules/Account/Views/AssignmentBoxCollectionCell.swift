import UIKit

final class AssignmentBoxCollectionCell: ScrollCollectionViewCell, ClassNameable {
    
    private let statusView = AssignmentSmallStatusView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 9, weight: .semibold)
        label.numberOfLines = 2
        
        
        return label
    }()
    
    private let subjectLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 7)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8)
        label.numberOfLines = 3
        
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2588235294, green: 0.05882352941, blue: 0.3568627451, alpha: 1)
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        
        return label
    }()
    
    override func addElements() {
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        containerView.addSubview(subjectLabel)
        subjectLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        containerView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(subjectLabel.snp.bottom).offset(9)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        containerView.addSubview(statusView)
        statusView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(9)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-5)
        }
    }
    
    func configure(title: String, subject: String, desc: String, deadline: String?) {
        titleLabel.text = title
        subjectLabel.text = subject
        descriptionLabel.text = desc
        statusView.deadlineDate = deadline
    }
}
