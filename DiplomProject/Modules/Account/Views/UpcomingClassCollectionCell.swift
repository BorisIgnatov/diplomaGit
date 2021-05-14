import UIKit

final class UpcomingClassCollectionCell: ScrollCollectionViewCell, ClassNameable {
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "class-klyaksa")
        
        return imageView
    }()
    
    private let durationView = DurationView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        
        return label
    }()
    
    private let teacherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 9)
        
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2588235294, green: 0.05882352941, blue: 0.3568627451, alpha: 1)
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        
        return label
    }()
    
    override func addElements() {
        containerView.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.width.equalTo(72)
            $0.height.equalTo(66)
        }
        
        containerView.addSubview(durationView)
        durationView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(22)
            $0.height.equalTo(17)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(durationView.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-14)
        }
        
        containerView.addSubview(teacherLabel)
        teacherLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-14)
        }
        
        containerView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(teacherLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-14)
            $0.bottom.equalToSuperview().offset(-15)
        }
    }
    
    func configure(duration: String, subject: String, teacher: String, time: String) {
        durationView.duration = duration
        titleLabel.text = subject
        teacherLabel.text = "By: \(teacher)"
        timeLabel.text = time
    }
}
