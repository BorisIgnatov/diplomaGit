import UIKit

final class ClassmateCollectionCell: UICollectionViewCell, ClassNameable {

    private let containerView = UIView()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8)
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElements() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.size.equalTo(54)
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func configure(name: String, avatar: String, position: ClassmateBoxView.BoxType) {
        nameLabel.text = name
        
        containerView.subviews.forEach { $0.removeFromSuperview() }
        
        let box = ClassmateBoxView(type: position, avatarUrl: avatar)
        containerView.addSubview(box)
        box.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
