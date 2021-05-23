import UIKit

final class AssignmentAttachmentListCell: CommonTableViewCell {
    
    var files: [String] = [] {
        didSet {
            emptyContainer.isHidden = true
            attachmentContainer.isHidden = false
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = "Attachment"
        
        return label
    }()
    
    private let emptyContainer = UIView()
    private let attachmentContainer = UIView()
    
    
    override func addElements() {
        configureEmptyContainer()
    }
    
    private func configureEmptyContainer() {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "book-image")
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "You have no attachments uploaded"
        label.textAlignment = .center
        
        emptyContainer.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.width.equalTo(216)
            $0.height.equalTo(133)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(87)
            $0.trailing.equalToSuperview().offset(-72)
        }
        
        emptyContainer.addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func configureAttachmentContainer() {
        
    }
}
