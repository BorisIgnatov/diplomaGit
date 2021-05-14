import UIKit

final class ClassmateCell: CommonTableViewCell {
    
    enum Position: String {
        case teacher = "Class teacher"
        case head = "Class head"
        case common
        
        var bgColor: UIColor {
            switch self {
            case .teacher:
                return #colorLiteral(red: 0.4274509804, green: 0.2470588235, blue: 0.9019607843, alpha: 1)
            case .head:
                return #colorLiteral(red: 0.4274509804, green: 0.2470588235, blue: 0.9019607843, alpha: 0.1)
            case .common:
                return .clear
            }
        }
        
        var fgColor: UIColor {
            switch self {
            case .teacher:
                return .white
            case .head:
                return #colorLiteral(red: 0.4274509804, green: 0.2470588235, blue: 0.9019607843, alpha: 1)
            case .common:
                return .clear
            }
        }
    }
    
    private let container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 1, alpha: 1)
        view.layer.borderWidth = 1.5
        view.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 1, alpha: 1).cgColor
        
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.5490196078, alpha: 1)

        return label
    }()
    
    private let iconView = ClassmateAvatarView()
    
    override func addElements() {
        backgroundColor = .clear
        
        contentView.addSubview(container)
        container.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(top: 5, left: 24, bottom: 5, right: 24))
        }
        
        container.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(19)
            $0.leading.equalToSuperview().offset(14)
            $0.size.equalTo(54)
        }
        
        container.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(19)
            $0.leading.equalTo(iconView.snp.trailing).offset(28)
        }
        
        container.addSubview(idLabel)
        idLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(iconView.snp.trailing).offset(28)
            $0.bottom.equalToSuperview().offset(-27)
        }
        
        idLabel.isHidden = true
    }
    
    func configure(url: String, name: String, id: String? = nil, position: Position = .common) {
        iconView.configure(url: url)
        nameLabel.text = name
        
        if id != nil {
            idLabel.text = id
            idLabel.isHidden = false
        }
        
        guard position != .common else { return }
        
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = position.bgColor
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = position.fgColor
        label.text = position.rawValue
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5))
        }
        
        container.addSubview(view)
        view.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().offset(-14)
        }
    }
}
