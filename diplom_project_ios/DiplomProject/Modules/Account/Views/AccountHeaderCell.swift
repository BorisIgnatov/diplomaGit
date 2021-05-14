import Foundation
import PromiseKit
import UIKit

final class AccountHeaderCell: CommonTableViewCell {
    
    private let container: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "account-klyaksa")
        
        return imageView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 45
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        
        return label
    }()
    
    private let birthdayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        
        return label
    }()
    
    override func addElements() {
        contentView.addSubview(container)
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        container.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.leading.equalToSuperview().offset(25)
            $0.bottom.lessThanOrEqualToSuperview()
            $0.size.equalTo(90)
        }
        
        let stackView = UIStackView()
        stackView.spacing = 3
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        container.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(37)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(22)
            $0.trailing.equalToSuperview().offset(-17)
            $0.bottom.lessThanOrEqualToSuperview().offset(-37)
        }
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(birthdayLabel)
    }
    
    func configure(with model: AccountModel) {
        firstly {
            ImageDownloader.shared.downloadImage(urlStr: model.iconUrl)
        }.done { [weak self] image in
            self?.iconImageView.image = image
        }.cauterize()
        
        nameLabel.text = model.fullname
        infoLabel.text = "Class: \(model.classNumber) | Id: \(model.id)"
        birthdayLabel.text = "Birthday: \(model.birthdayDate)"
    }
}
