import UIKit

final class AssignmentHeaderCell: CommonTableViewCell {
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0.337254902, green: 0.3411764706, blue: 0.4078431373, alpha: 1)

        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .semibold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0.337254902, green: 0.3411764706, blue: 0.4078431373, alpha: 1)
        
        return label
    }()
    
    override func addElements() {
        addSubview(deadlineLabel)
        deadlineLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(23)
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().offset(-21)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(deadlineLabel.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().offset(-21)
        }
        
        addSubview(pointsLabel)
        pointsLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().offset(-21)
            $0.bottom.equalToSuperview().offset(-23)
        }
    }
    
    func configure(deadline: String, title: String, points: String) {
        deadlineLabel.text = deadline
        titleLabel.text = title
        pointsLabel.text = points
    }
}
