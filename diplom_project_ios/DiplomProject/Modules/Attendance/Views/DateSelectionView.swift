import UIKit

final class DateSelectionView: CommonView {
    
    var date: String? {
        didSet {
            dateLabel.text = date
        }
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    private let rightArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "left-arrow")
        
        return imageView
    }()
    
    private let leftArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "left-arrow")
        
        return imageView
    }()
    
    override func addElements() {
        let topSeparator = UIView()
        let bottomSeparator = UIView()
        
        [topSeparator, bottomSeparator].forEach {
            $0.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8666666667, blue: 0.9058823529, alpha: 1)
        }
        
        addSubview(topSeparator)
        topSeparator.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        addSubview(bottomSeparator)
        topSeparator.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        addSubview(leftArrow)
        leftArrow.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(10)
        }
        
        addSubview(rightArrow)
        leftArrow.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(5)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(10)
        }
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(23)
            $0.bottom.equalToSuperview().offset(-25)
            $0.leading.equalTo(leftArrow.snp.trailing).offset(10)
            $0.trailing.equalTo(rightArrow.snp.leading).offset(-10)
        }
    }
    
}
