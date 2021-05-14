import UIKit

final class AttachmentCollectionCell: UICollectionViewCell, ClassNameable {

    private let fileView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = #colorLiteral(red: 0.8, green: 0.7647058824, blue: 0.9137254902, alpha: 1)
        
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "attachment")
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.size.equalTo(28)
            $0.center.equalToSuperview()
        }
        
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .left
        
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
        addSubview(fileView)
        fileView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.size.equalTo(80)
        }
        
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "file-small")
        
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalTo(fileView.snp.bottom).offset(9)
            $0.leading.equalTo(fileView.snp.leading).offset(9)
            $0.width.equalTo(13)
            $0.height.equalTo(15)
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(fileView.snp.bottom).offset(12)
            $0.leading.equalTo(imageView.snp.trailing).offset(4)
            $0.trailing.equalTo(fileView.snp.trailing)
            $0.bottom.equalToSuperview()
        }
    }
    
    func configure(name: String) {
        nameLabel.text = name
    }
}
