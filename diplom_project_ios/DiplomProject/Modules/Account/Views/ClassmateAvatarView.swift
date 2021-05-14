import UIKit
import PromiseKit

final class ClassmateAvatarView: CommonView {
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 18
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [#colorLiteral(red: 0.2235294118, green: 0.4274509804, blue: 0.9294117647, alpha: 1).cgColor, #colorLiteral(red: 0.4549019608, green: 0.8117647059, blue: 0.9411764706, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        
        return gradient
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame = frame
    }
    
    override func addElements() {
        clipsToBounds = true
        layer.cornerRadius = 18
        
        addGradientBackgroud()
        
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        }
    }
    
    private func addGradientBackgroud() {
        layer.insertSublayer(gradient, at: 0)
    }
    
    func configure(url: String) {
        firstly {
            ImageDownloader.shared.downloadImage(urlStr: url)
        }.done { [weak self] image in
            self?.avatarImageView.image = image
        }.cauterize()
    }
}
