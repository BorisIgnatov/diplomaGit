import UIKit
import PromiseKit

final class ClassmateBoxView: CommonView {
    
    private let boxType: BoxType
    private let url: String
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 18
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = boxType.colors
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        
        return gradient
    }()
    
    init(type: BoxType, avatarUrl: String) {
        boxType = type
        url = avatarUrl
        
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        firstly {
            ImageDownloader.shared.downloadImage(urlStr: url)
        }.done { [weak self] image in
            self?.avatarImageView.image = image
        }.cauterize()
        
        guard boxType != .common else { return }
        
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = boxType.descriptionBackgroundColor
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 6, weight: .semibold)
        label.textColor = .white
        label.text = boxType.description
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4))
        }
        
        addSubview(view)
        view.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    private func addGradientBackgroud() {
        layer.insertSublayer(gradient, at: 0)
    }
}

extension ClassmateBoxView {
    
    enum BoxType {
        case head
        case teacher
        case common
        
        var colors: [CGColor] {
            switch self {
            case .teacher:
                return [#colorLiteral(red: 0.3725490196, green: 0.2196078431, blue: 0.7764705882, alpha: 1).cgColor, #colorLiteral(red: 0.737254902, green: 0.4431372549, blue: 0.7843137255, alpha: 1).cgColor]
            default:
                return  [#colorLiteral(red: 0.2235294118, green: 0.4274509804, blue: 0.9294117647, alpha: 1).cgColor, #colorLiteral(red: 0.4549019608, green: 0.8117647059, blue: 0.9411764706, alpha: 1).cgColor]
            }
        }

        var descriptionBackgroundColor: UIColor? {
            switch self {
            case .teacher:
                return #colorLiteral(red: 0.7254901961, green: 0.4392156863, blue: 0.7843137255, alpha: 1)
            case .head:
                return #colorLiteral(red: 0.4470588235, green: 0.7960784314, blue: 0.9411764706, alpha: 1)
            case .common:
                return nil
            }
        }
        
        var description: String? {
            switch self {
            case .teacher:
                return "teacher"
            case .head:
                return "head"
            case .common:
                return nil
            }
        }
    }
}
