import Foundation
import UIKit

final class ScheduleCell: CommonTableViewCell {
    
    private let container: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9411764706, blue: 0.9843137255, alpha: 1)
        
        return view
    }()
    
    private let colorIndicator = UIView()
    
    private let subjectLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .right
        
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let teacherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        
        return label
    }()
    
    override func addElements() {
        backgroundColor = .clear
        
        contentView.addSubview(container)
        container.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        container.addSubview(colorIndicator)
        colorIndicator.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(8)
        }
        
        container.addSubview(locationLabel)
        locationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
        }
        
        container.addSubview(subjectLabel)
        subjectLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(5)
            $0.leading.equalTo(colorIndicator.snp.trailing).offset(32)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        container.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(subjectLabel.snp.bottom).offset(5)
            $0.leading.equalTo(colorIndicator.snp.trailing).offset(32)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        container.addSubview(teacherLabel)
        teacherLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(14)
            $0.leading.equalTo(colorIndicator.snp.trailing).offset(32)
            $0.trailing.lessThanOrEqualToSuperview()
            $0.bottom.equalToSuperview().offset(-18)
        }
    }
    
    func configure(with model: ScheduleModel) {
        let colors: [UIColor] = [.red, .green, .orange]
        colorIndicator.backgroundColor = colors.randomElement()
        locationLabel.text = model.location
        subjectLabel.text = model.subject
        timeLabel.text = model.time
        teacherLabel.text = model.teacher
    }
}
